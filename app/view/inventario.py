import time
from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from utils.print_menu import print_header, DIVISORIA

class Inventario:
  def __init__(self, db):
    self.db = db


  def handle_inventario(self, id_jogador, id_area):
    while True:
      print_header("INVENTÁRIO","")
      jogador = self.db.get_player(id_jogador)
      opcao_inventario = inquirer.select(
          message="Qual aba deseja abrir?",
          choices=["Poções", "Pergaminhos", "Armas", "Armaduras", "Tecnicas", "-- Fechar o inventário --"]
        ).execute()

      if opcao_inventario == "Poções":
        self.handle_pocoes(jogador, id_area)
            
      elif opcao_inventario == "Pergaminhos":
        self.handle_pergaminhos(jogador, id_area)
            
      elif opcao_inventario == "Armas":
        self.handle_armas(jogador, id_area)
            
      elif opcao_inventario == "Armaduras":
        self.handle_armaduras(jogador, id_area)

      elif opcao_inventario == "Tecnicas":
        self.handle_tecnicas(jogador)
          
      elif opcao_inventario == "-- Fechar o inventário --":
        break


  def handle_tecnicas(self, jogador):
    while True:
      print_header("INVENTÁRIO","Tecnicas")
      tecnicas = self.db.get_tecnicas_personagem(jogador.id)

      tecnica = inquirer.select(
        message="Selecione uma tecnica para ver seus detalhes",
        choices=[Choice(tecnica, tecnica.nome) for tecnica in tecnicas]
        + ["-- Voltar --"]
      ).execute()

      if tecnica == "-- Voltar --":
        break
      else:
        self.handle_tecnicas_details(tecnica)

  def handle_tecnicas_details(self, tecnica):
    while True:
      print_header("INVENTÁRIO","Tecnicas")
      tecnica_detalhes=f"{tecnica.nome}\nDescrição: {tecnica.descricao}\nElemento: {tecnica.elemento}\nNivel: {tecnica.nivel_necessario_aprender}\n"
      if hasattr(tecnica, "dano_causado"):
        tecnica_detalhes += f"Dano Causado: {tecnica.dano_causado}pts\n"
      elif hasattr(tecnica, "dano_bloqueado"):
        tecnica_detalhes += f"Dano Bloqueado: {tecnica.dano_bloqueado}pts\n"
      elif hasattr(tecnica, "chance_esquiva"):
        tecnica_detalhes += f"Chance de Esquiva: {tecnica.chance_esquiva}%\n"
      elif hasattr(tecnica, "pontos_cura"):
        tecnica_detalhes += f"Vida Curada: {tecnica.pontos_cura}pts\n"

      tecnica_detalhes_menu = inquirer.select(
        message=tecnica_detalhes,
        choices=["-- Voltar --"]
      ).execute()

      if tecnica_detalhes_menu == "-- Voltar --":
        break

  def handle_armaduras(self, jogador, id_area):
    while True:
      print_header("INVENTÁRIO","Armaduras")
      jogador = self.db.get_player(jogador.id)

      capacete_equipado = None
      capacete_equipado_nome = "-"
      if (jogador.item_capacete != None):
        capacete_equipado = self.db.get_item(jogador.item_capacete)
        capacete_equipado_nome = capacete_equipado.nome

      peitoral_equipado = None
      peitoral_equipado_nome = "-"
      if (jogador.item_peitoral != None):
        peitoral_equipado = self.db.get_item(jogador.item_peitoral)
        peitoral_equipado_nome = peitoral_equipado.nome

      acessorio_equipado = None
      acessorio_equipado_nome = "-"
      if (jogador.item_acessorio != None):
        acessorio_equipado = self.db.get_item(jogador.item_acessorio)
        acessorio_equipado_nome = acessorio_equipado.nome

      bota_equipada = None
      bota_equipada_nome = "-"
      if (jogador.item_botas != None):
        bota_equipada = self.db.get_item(jogador.item_botas)
        bota_equipada_nome = bota_equipada.nome

      armaduras_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Armaduras")

      armadura = inquirer.select(
        message=f"Armaduras equipadas:\nCapacete  => [ {capacete_equipado_nome} ]\nPeitoral  => [ {peitoral_equipado_nome} ]\nAcessório => [ {acessorio_equipado_nome} ]\nBotas     => [ {bota_equipada_nome} ]\n{DIVISORIA}\nSelecione um item para ver seus detalhes",
        choices=[Choice(armadura, armadura.nome) for armadura in armaduras_inventario]
        + ["-- Voltar --"]
      ).execute()
            
      if armadura == "-- Voltar --":
        break
      else:
        self.handle_armadura_details(jogador, id_area, capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome, armadura)


  def handle_armadura_details(self, jogador, id_area, capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome, armadura):
    while True:
      print_header("INVENTÁRIO","Armaduras")
      equipado_mensagem = ""
      if armadura.nome in {capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome}:
        equipado_mensagem = ["Desequipar armadura", "-- Voltar --"]
      else:
        equipado_mensagem = ["Equipar armadura", "Dropar armadura", "-- Voltar --"]

      armadura_detalhes = inquirer.select(
        message=f'{armadura.nome}\nPeso: {armadura.peso}\nPreço: {armadura.preco}\nProteção: {armadura.pontos_protecao}\nParte do Corpo: {armadura.parte_corpo}\n',
        choices=equipado_mensagem
      ).execute()

      if armadura_detalhes == "Equipar armadura":
        self.db.equipar_armadura(armadura.id_instancia, jogador.id)
        break
      elif armadura_detalhes == "Desequipar armadura":
        self.db.desequipar_armadura(armadura.id_instancia, jogador.id)
        break
      elif armadura_detalhes == "Dropar armadura":
        self.db.drop_item(armadura.id_instancia, id_area)
        break
      elif armadura_detalhes == "-- Voltar --":
        break


  def handle_armas(self, jogador, id_area):
    while True:
      print_header("INVENTÁRIO","Armas")
      jogador = self.db.get_player(jogador.id)

      arma_equipada = None
      arma_equipada_nome = "-"
      if (jogador.item_arma != None):
        arma_equipada = self.db.get_item(jogador.item_arma)
        arma_equipada_nome = arma_equipada.nome

      armas_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Armas")
              
      arma = inquirer.select(
        message=f"Armas equipadas:\nArma => [ {arma_equipada_nome} ]\n{DIVISORIA}\nSelecione um item para ver seus detalhes",
        choices=[Choice(arma, arma.nome) for arma in armas_inventario]
        + ["-- Voltar --"]
      ).execute()
              
      if arma == "-- Voltar --":
        break
      else:
        self.handle_armas_details(jogador, id_area, arma, arma_equipada_nome)


  def handle_armas_details(self, jogador, id_area, arma, arma_equipada_nome):
    while True:
      print_header("INVENTÁRIO","Armas")
      equipado_mensagem = ""
      if arma.nome == arma_equipada_nome:
        equipado_mensagem = ["Desequipar arma", "-- Voltar --"]
      else:
        equipado_mensagem = ["Equipar arma", "Dropar arma", "-- Voltar --"]

      arma_detalhes = inquirer.select(
        message=f'{arma.nome}\nPeso: {arma.peso}\nPreço: {arma.preco}\nDano: {arma.dano}\n',
        choices=equipado_mensagem
      ).execute()

      if arma_detalhes == "Equipar arma":
        self.db.equipar_arma(arma.id_instancia, jogador.id)
        break
      elif arma_detalhes == "Desequipar arma":
        self.db.desequipar_arma(arma.id_instancia, jogador.id)
        break
      elif arma_detalhes == "Dropar arma":
        self.db.drop_item(arma.id_instancia, id_area)
        break
      elif arma_detalhes == "-- Voltar --":
        break


  def handle_pergaminhos(self, jogador, id_area):
    while True:
      print_header("INVENTÁRIO","Pergaminhos")
      pergaminhos_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Pergaminhos")
              
      pergaminho = inquirer.select(
        message="Selecione um item para ver seus detalhes",
        choices=[Choice(pergaminho, pergaminho.nome) for pergaminho in pergaminhos_inventario]
        + ["-- Voltar --"]
      ).execute()

      if pergaminho == "-- Voltar --":
        break
      else:
        self.handle_pergaminhos_details(id_area, pergaminho, jogador)


  def handle_pergaminhos_details(self, id_area, pergaminho, jogador):
    while True:
      print_header("INVENTÁRIO","Pergaminhos")
      pergaminho_detalhes = inquirer.select(
        message=f'{pergaminho.nome}\nPeso: {pergaminho.peso}\nPreço: {pergaminho.preco}\nRaridade: {pergaminho.raridade}\nTécnica: {pergaminho.tecnica}\n',
        choices=["Aprender técnica", "Dropar pergaminho", "-- Voltar --"]
      ).execute()

      if pergaminho_detalhes == "Aprender técnica": #TODO: Ocultar se o player ja sabe a tecnica sinao da bug 
        resultado = self.db.aprender_tecnica(pergaminho.tecnica, jogador.id, pergaminho.id_instancia)
        if resultado == True:
          print(f"-- Você aprendeu a técnica {pergaminho.tecnica}!!! --")
          break
        else:
          print("-- Você já sabe essa técnica!!! --")
          time.sleep(3)

      elif pergaminho_detalhes == "Dropar pergaminho":
        self.db.drop_item(pergaminho.id_instancia, id_area)
        break

      elif pergaminho_detalhes == "-- Voltar --":
        break


  def handle_pocoes(self, jogador, id_area):
    while True:
      print_header("INVENTÁRIO","Poções")
      pocoes_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Poções")

      pocao = inquirer.select(
        message="Selecione um item para ver seus detalhes",
        choices=[Choice(pocao, pocao.nome) for pocao in pocoes_inventario]
        + ["-- Voltar --"]
      ).execute()

      if pocao == "-- Voltar --":
        break
      else:
        self.handle_pocoes_details(id_area, pocao, jogador)


  def handle_pocoes_details(self, id_area, pocao, jogador):
    while True:
      print_header("INVENTÁRIO","Poções")
      pocao_detalhes = inquirer.select(
        message=f'{pocao.nome}\nPeso: {pocao.peso}\nPreço: {pocao.preco}\nCura: {pocao.pontos_cura}\n',
        choices=["Usar poção", "Dropar poção", "-- Voltar --"]
      ).execute()

      if pocao_detalhes == "Usar poção":
        if jogador.vida_atual == jogador.vida_max:
          print("-- Sua vida já está cheia! --")
        else:
          self.db.usar_pocao(pocao.pontos_cura, jogador, pocao.id_instancia)
          print(f"-- Você utilizou {pocao.nome}!!! --")
          break
                  
      elif pocao_detalhes == "Dropar poção":
        self.db.drop_item(pocao.id_instancia, id_area)
        break

      elif pocao_detalhes == "-- Voltar --":
        break