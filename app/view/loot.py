from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Loot:
  def __init__(self, db):
    self.db = db


  def handle_loot(self, id_jogador, id_area_atual):
      while True:
        loot = self.get_loot(id_area_atual)
        choices_item = [Choice(item, item.nome) for item in loot]
        choices_item.append("-- Voltar --")

        opcao_item = inquirer.select(
            message="Selecione um item para adicioná-lo ao inventário",
            choices=choices_item
          ).execute()

        if opcao_item == "-- Voltar --":
          break
        else:
          self.db.add_item_inventario(opcao_item.id_instancia, id_jogador)

  def get_loot(self, id_area):
    return self.db.get_itens_por_area(id_area)
