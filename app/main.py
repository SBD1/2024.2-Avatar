import os
from InquirerPy import inquirer
from database import Database
from asciiArt import AANG

def main():
    db = Database()
    os.system('cls' if os.name == 'nt' else 'clear')
    print(AANG)

    while True:
        print("==================================================")

        choice = inquirer.rawlist(
          message="Selecione uma opção",
          choices=[
            "Listar dobras",
            "Listar movimentos",
            "Listar subdobras",
            "Sair"
          ]
        ).execute()

        if choice == "Listar dobras":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getDobras())
        elif choice == "Listar movimentos":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getMovimentos())
        elif choice == "Listar subdobras":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getSubdobras())
        else:
            db.close()
            break
        
main()

