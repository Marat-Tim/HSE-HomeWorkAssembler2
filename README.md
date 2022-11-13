# HSE_HomeWorkAssembler2
🏫 Домашнее задание №2 по курсу "Архитектуры вычислительных систем", БПИ216 Багаев Марат

# Задание на 4 балла
1. Написал код на C - [program.c](program.c)
2. С помощью команды ```gcc program.c -S -o program.s``` получил код на ассемблере - [program.s](program.s)
3. Добавил в код на ассемблере комментарии, поясняющие эквивалентное представление переменных в программе на C
4. С помощью команды ```gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions program.c -S -o program_nice.s``` убрал из ассемблерного кода лишние макросы - [program_nice.s](program_nice.s)
5. Скомпилировал программу из ассемблера в исполняемый файл с помощью команды ```gcc program_nice.s -o program_nice.exe``` - [program_nice.exe](program_nice.exe) 
