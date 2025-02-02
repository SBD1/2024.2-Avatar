from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Inimigos:
  def __init__(self, db):
    self.db = db

  def handle_inimigos(self, inimigos_na_area):
      while True:
        choices_inimigo = [Choice(inimigo.nome) for inimigo in inimigos_na_area] # Colocar só o nome do Inimigo
        choices_inimigo.append("-- Voltar --")

        opcao_inimigo = inquirer.select(
            message="Quem deseja enfrentar?",
            choices=choices_inimigo
          ).execute()

        if opcao_inimigo == "-- Voltar --":
          break
    