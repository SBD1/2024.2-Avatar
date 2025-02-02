from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Loot:
  def __init__(self, db):
    self.db = db

  def handle_loot(self, jogador, area_atual, itens_na_area):
      while True:
        choices_item = [Choice(item.nome) for item in itens_na_area] # Colocar só o nome do item
        choices_item.append("-- Voltar --")

        opcao_item = inquirer.select(
            message="Selecione um item para adicioná-lo ao inventário",
            choices=choices_item
          ).execute()

        if opcao_item == "-- Voltar --":
          break
        else:
          for item in itens_na_area:
            if (item.nome == opcao_item):
              resultado = self.db.add_item_inventario(item.id_instancia, jogador.id)
              if (resultado == True):
                itens_na_area = self.db.get_itens_por_area(area_atual.id)
                break

