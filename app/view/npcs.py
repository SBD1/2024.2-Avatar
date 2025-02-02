from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Npcs:
  def __init__(self, db):
    self.db = db

  def handle_npcs(self, npcs_na_area):
      while True:
        choices_npc = [Choice(npc.nome) for npc in npcs_na_area] # Colocar só o nome do NPC
        choices_npc.append("-- Voltar --")

        opcao_npc = inquirer.select(
            message="Com quem deseja conversar?",
            choices=choices_npc
          ).execute()

        if opcao_npc == "-- Voltar --":
          break