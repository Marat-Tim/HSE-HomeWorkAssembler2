from collections import Counter
from random import randint
import os
import time

in_path = "in.txt"
out_path = "out.txt"


def solve_task(in_data):
    counter = Counter(in_data)
    correct_out = ""
    for i in range(10):
        correct_out += f"Count of \"{i}\": {counter[str(i)]}\n"
    return correct_out


def random_input_str():
    string = ""
    for i in range(randint(0, 1000)):
        string += chr(randint(1, 127))
    return string


def main():
    programs_names = input("Какие программы тестируем?(Если все, то нажмите enter)\n").split()
    if len(programs_names) == 0:
        programs_names = [filename[:-4] for filename in os.listdir() if filename[-3:] == "exe"]
    programs_time = {key: [] for key in programs_names}

    for _ in range(1000):
        in_ = random_input_str()
        with open(in_path, 'w', encoding="ascii") as f:
            f.write(in_)
        correct_out = solve_task(in_)

        for program_name in programs_names:
            start_t = time.time()
            os.system(f"./{program_name}.exe < {in_path} > {out_path}")
            end_t = time.time()
            programs_time[program_name].append(end_t - start_t)
            with open(out_path, 'r') as f:
                out = f.read()
            if out != correct_out:
                print(f"Ошибка! Программа {program_name} выдает неправильный результат, на входных данных из {in_path}")
                return
    else:
        print("Ошибок не найдено")
        for program_name in programs_names:
            print(
                f"Среднее время выполнения {program_name}: {sum(programs_time[program_name]) / len(programs_time[program_name])}")


main()

