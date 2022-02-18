import sys

pwd = sys.argv[1]


def override_parameters(file_name, key_name, new_value):

    # cria uma lista (array) mas não exclui a quebra de linha "\n"
    with open(file_name, 'r') as file:
        file_as_array = file.readlines()

    # acha em qual linha essa variável está
    line_index = None
    for index, line in enumerate(file_as_array):
        if key_name in line:
            line_index = index
            break

    if line_index:
        file_as_array[line_index] = key_name + '=' + new_value + '\n'

    with open(file_name, 'w') as file:
        file.writelines(file_as_array)

database_name = input('\nwhat is the database name? \n')
if database_name:
    override_parameters(pwd + '/.env', 'DB_HOST', 'mysql')
    override_parameters(pwd + '/.env', 'DB_DATABASE', database_name)
    override_parameters(pwd + '/.env', 'DB_USERNAME', 'root')
    override_parameters(pwd + '/.env', 'DB_PASSWORD', 'secret')

