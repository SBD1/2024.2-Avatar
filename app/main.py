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
            "Listar Ataques",
            "Listar Defesas",
            "Listar Mobilidades",
            "Listar Curas",
            "Sair"
          ]
        ).execute()

        if choice == "Listar Ataques":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getTecnicasAtaque())

        elif choice == "Listar Defesas":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getTecnicasDefesa())

        elif choice == "Listar Mobilidades":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getTecnicasMobilidade())

        elif choice == "Listar Curas":
            os.system('cls' if os.name == 'nt' else 'clear')
            print(db.getTecnicasCura())
        
        else:
            db.close()
            break
        
main()

