import os
import re
import subprocess
import argparse
from fuzzywuzzy import fuzz

default_directory = '/home/moises/Downloads/Movies/'

def tokenize(name):
    return re.split(r'[\W_]+', name.lower())

def list_directories(directory):
    for root, dirs, _ in os.walk(directory):
        if root == directory:
            return dirs
    return []

def calculate_similarity(token, dir_tokens):
    max_similarity = 0
    for dir_token in dir_tokens:
        similarity = fuzz.ratio(token, dir_token)
        if similarity > max_similarity:
            max_similarity = similarity
    return max_similarity

def find_best_match(directory, *target_name):
    target_tokens = [tokenize(name) for name in target_name]
    target_tokens = [token for sublist in target_tokens for token in sublist]

    dir_list = list_directories(directory)
    tokenized_directories = [(dir_name, tokenize(dir_name)) for dir_name in dir_list]

    best_match = None
    highest_score = 0

    for dir_name, tokens in tokenized_directories:
        total_similarity = sum(calculate_similarity(token, tokens) for token in target_tokens)
        average_similarity = total_similarity / len(target_tokens)

        if average_similarity > highest_score:
            highest_score = average_similarity
            best_match = dir_name

    if best_match:
        execute_largest_video(os.path.join(directory, best_match))
    else:
        print("Nenhuma correspondência encontrada.")

def execute_largest_video(directory):
    video_extensions = ('.mp4', '.avi', '.mkv')
    largest_file = None
    largest_size = 0

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(video_extensions):
                file_path = os.path.join(root, file)
                file_size = os.path.getsize(file_path)
                if file_size > largest_size:
                    largest_size = file_size
                    largest_file = file_path

    if largest_file:
        command = f'nohup vlc --fullscreen "{largest_file}" >> /tmp/alexa.log 2>&1 &'
        subprocess.run(command, shell=True)
    else:
        print("Nenhum arquivo de vídeo encontrado no diretório.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Encontra e executa o maior vídeo no diretório mais relevante.')
    parser.add_argument('parameters', metavar='P', type=str, nargs='+', help='Parâmetros para a busca do diretório')

    args = parser.parse_args()
    find_best_match(default_directory, *args.parameters)
