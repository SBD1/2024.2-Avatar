from InquirerPy import inquirer
from database import Database

def main():
    db = Database()

    while True:
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
            print(db.getDobras())
        elif choice == "Listar movimentos":
            print(db.getMovimentos())
        elif choice == "Listar subdobras":
            print(db.getSubdobras())
        else:
            db.close()
            break

main()
        
    