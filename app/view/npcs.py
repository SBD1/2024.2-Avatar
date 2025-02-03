import time
from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from utils.clear import clear

class Npcs:
  def __init__(self, db):
    self.db = db


  def handle_npcs(self, jogador, id_area):
    while True:
      clear()
      npcs = self.get_npcs(id_area)
      choices_npc = [Choice(npc, npc.nome) for npc in npcs]
      choices_npc.append("-- Voltar --")

      opcao_npc = inquirer.select(
        message="Com quem deseja conversar?",
        choices=choices_npc
      ).execute()

      if opcao_npc == "-- Voltar --":
        break
      else:
        self.handle_npcs_details(opcao_npc, jogador)

  def handle_npcs_details(self, npc, jogador):
    while True:
      npc_choices = []
      if npc.eh_mercador and jogador.nivel >= npc.nivel_necessario_compra:
        npc_choices.append("Comprar itens")
      if npc.eh_mestre and jogador.nivel >= npc.nivel_necessario_discipulo:
        npc_choices.append("Aprender técnicas")
      if npc.eh_curandeiro:
        npc_choices.append("Pedir para ser curado")
      npc_choices.append("-- Voltar --")
      
      npc_detalhes = inquirer.select(
        message=f"{npc.nome}: {npc.fala_entrada}",
        choices=npc_choices
      ).execute()

      if npc_detalhes == "Comprar itens":
        itens_npc = self.db.get_itens_por_npc(npc.id)
        itens_message = "Nenhum item disponível para compra"
        npc_item_choices = []
        if itens_npc != []:
          npc_item_choices = [Choice(item, item.nome) for item in itens_npc]
          itens_message = "Selecione um item para ver seus detalhes"
        npc_item_choices.append("-- Voltar --")

        item = inquirer.select(
          message=itens_message,
          choices=npc_item_choices
        ).execute()

        if item == "-- Voltar --":
          break
        else:
          self.handle_npc_item_details(npc.id, item, jogador)

      elif npc_detalhes == "-- Voltar --":
        print(f"{npc.nome}: {npc.fala_saida}")
        time.sleep(3)
        break

  def handle_npc_item_details(self, id_npc, item, jogador):
    while True:
      jogador = self.db.get_player(jogador.id)
      item_message = ""
      if hasattr(item, "pontos_cura"):
        item_message = f"Nome: {item.nome}, Peso: {item.peso}, Cura: {item.pontos_cura}"
      
      elif hasattr(item, "tecnica"):
        item_message = f"Nome: {item.nome}, Peso: {item.peso}, Raridade: {item.raridade}, Técnica: {item.tecnica}"

      elif hasattr(item, "dano"):
        item_message = f"Nome: {item.nome}, Peso: {item.peso}, Dano: {item.dano}"

      elif hasattr(item, "pontos_protecao"):
        item_message = f"Nome: {item.nome}, Peso: {item.peso}, Proteção: {item.pontos_protecao}, Parte do Corpo: {item.parte_corpo}"

      opcao_item = inquirer.select(
        message=f"{item_message}\n| Suas moedas: {jogador.moedas}\n| Preço: {item.preco}",
        choices=["Comprar item", "-- Voltar --"]
      ).execute()

      if opcao_item == "Comprar item":
        resultado = self.db.comprar_item(item.id_instancia, item.preco, id_npc, jogador.id)
        if resultado:
          break
        else:
          print("-------------------------------------------------\nVocê não tem moedas suficientes para esta compra!\n-------------------------------------------------")
      
      elif opcao_item == "-- Voltar --":
        break

  def get_npcs(self, id_area):
    return self.db.get_npcs_por_area(id_area)