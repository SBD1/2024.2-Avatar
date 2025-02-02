from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Npcs:
  def __init__(self, db):
    self.db = db

  def handle_npcs(self, id_area):
      while True:
        npcs = self.get_npcs(id_area)
        choices_npc = [Choice(npc, npc.nome) for npc in npcs]
        choices_npc.append("-- Voltar --")

        opcao_npc = inquirer.select(
            message="Com quem deseja conversar?",
            choices=choices_npc
          ).execute()

        if opcao_npc == "-- Voltar --":
          break

  def get_npcs(self, id_area):
    return self.db.get_npcs_por_area(id_area)