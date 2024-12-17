from InquirerPy import inquirer
from app.database import Database

class Game:
    def run(self):
        while True:
            menu =  inquirer.select(
                message="O que deseja fazer?",
                choices=[
                    "Listar Dobras",
                    "Listar Subdobras",
                    "Listar Movimentos",
                    "Sair"
                ]
            ).execute()
            if menu == "Listar Dobras":
                print(Database.getDobras())
            elif menu == "Listar Subdobras":
                print(Database.getSubdobras())
            elif menu == "Listar Movimentos":
                print(Database.getMovimentos())
            elif menu == "Sair":
                print("Sair")
                Database.close()
                break
    
if __name__ == "__main__":
    game = Game()
    game.run()