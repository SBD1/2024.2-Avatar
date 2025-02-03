from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from utils.print_menu import DIVISORIA, print_fala, print_header

class Amigos:
  def __init__(self, db):
    self.db = db


  def handle_amigos(self, jogador, id_area):
    while True:
      print_header("BATE-PAPO", "")
      amigos = self.get_amigos(id_area)
      choices_amigo = [Choice(amigo, amigo.nome) for amigo in amigos]
      choices_amigo.append("-- Voltar --")

      opcao_amigo = inquirer.select(
        message="Com quem deseja conversar?",
        choices=choices_amigo
      ).execute()

      if opcao_amigo == "-- Voltar --":
        break
      else:
        self.handle_conversa(opcao_amigo, jogador)


  def handle_conversa(self, amigo, jogador):
    while True:
      print_header("BATE-PAPO", "")
      amigo_choices = []
      if amigo.eh_mercador and jogador.nivel >= amigo.nivel_necessario_compra:
        amigo_choices.append("Comprar itens")
      if amigo.eh_mestre and jogador.nivel >= amigo.nivel_necessario_discipulo:
        amigo_choices.append("Aprender técnicas")
      if amigo.eh_curandeiro:
        amigo_choices.append("Pedir para ser curado")
      amigo_choices.append("-- Voltar --")
      
      amigo_detalhes = inquirer.select(
        message=f"{amigo.nome}: {amigo.fala_entrada}",
        choices=amigo_choices
      ).execute()

      if amigo_detalhes == "Comprar itens":
        itens_amigo = self.db.get_itens_por_amigo(amigo.id)
        itens_message = "Nenhum item disponível para compra"
        amigo_item_choices = []
        if itens_amigo != []:
          amigo_item_choices = [Choice(item, item.nome) for item in itens_amigo]
          itens_message = "Selecione um item para ver seus detalhes"
        amigo_item_choices.append("-- Voltar --")

        item = inquirer.select(
          message=itens_message,
          choices=amigo_item_choices
        ).execute()

        if item == "-- Voltar --":
          break
        else:
          self.handle_venda_details(amigo.id, item, jogador)

      # elif amigo_detalhes == "Aprender técnicas": # TODO: impelemntar
        
      elif amigo_detalhes == "Pedir para ser curado":
        self.db.use_heal(jogador.id, 50)
        print(f"{amigo.nome}: Prontinho novinho em folha")

      elif amigo_detalhes == "-- Voltar --":
        print_fala(amigo.nome, amigo.fala_saida)
        break


  def handle_venda_details(self, id_amigo, item, jogador):
    while True:
      print_header("BATE-PAPO", "Mercador")
      jogador = self.db.get_player(jogador.id)
      item_message = f"{item.nome}\nPeso: {item.peso}\n"
      if hasattr(item, "pontos_cura"):
        item_message += f"Cura: {item.pontos_cura}"
      
      elif hasattr(item, "tecnica"):
        item_message += f"Raridade: {item.raridade}\nTécnica: {item.tecnica}"

      elif hasattr(item, "dano"):
        item_message += f"Dano: {item.dano}"

      elif hasattr(item, "pontos_protecao"):
        item_message += f"Proteção: {item.pontos_protecao}\nParte do Corpo: {item.parte_corpo}"

      opcao_item = inquirer.select(
        message=f"{item_message}\n\n| Suas moedas: {jogador.moedas}\n| Preço: {item.preco}\n",
        choices=["Comprar item", "-- Voltar --"]
      ).execute()

      if opcao_item == "Comprar item":
        resultado = self.db.comprar_item(item.id_instancia, item.preco, id_amigo, jogador.id)
        if resultado:
          break
        else:
          print(f"{DIVISORIA}\nVocê não tem moedas suficientes para esta compra!\n{DIVISORIA}")
      elif opcao_item == "-- Voltar --":
        break


  def get_amigos(self, id_area):
    return self.db.get_amigos_por_area(id_area)