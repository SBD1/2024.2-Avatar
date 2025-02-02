from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from utils.clear import clear

class Inventario:
  def __init__(self, db):
    self.db = db


  def handle_inventario(self, id_jogador, id_area):
      while True:
        clear()
        jogador = self.db.get_player(id_jogador)
        opcao_inventario = inquirer.select(
            message="Qual aba deseja abrir?",
            choices=["Poções", "Pergaminhos", "Armas", "Armaduras", "-- Fechar o inventário --"]
          ).execute()

        if opcao_inventario == "Poções":
          self.handle_pocoes(jogador, id_area)
            
        elif opcao_inventario == "Pergaminhos":
          self.handle_pergaminhos(jogador, id_area)
            
        elif opcao_inventario == "Armas":
          self.handle_armas(jogador, id_area)
            
        elif opcao_inventario == "Armaduras":
          self.handle_armaduras(jogador, id_area)
          
        elif opcao_inventario == "-- Fechar o inventário --":
          break


  def handle_armaduras(self, jogador, id_area):
    while True:
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
        message=f"------- Itens equipados: -------\nCapacete  => [ {capacete_equipado_nome} ]\nPeitoral  => [ {peitoral_equipado_nome} ]\nAcessório => [ {acessorio_equipado_nome} ]\nBotas     => [ {bota_equipada_nome} ]\n--------------------------------\nSelecione um item para ver seus detalhes",
        choices=[Choice(armadura, armadura.nome) for armadura in armaduras_inventario]
        + ["-- Voltar --"]
      ).execute()
            
      if armadura == "-- Voltar --":
        break
      else:
        self.handle_aramdura_details(jogador, id_area, capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome, armadura)


  def handle_aramdura_details(self, jogador, id_area, capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome, armadura):
    while True:
      equipado_mensagem = ""
      if armadura.nome in {capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome}:
        equipado_mensagem = ["Desequipar armadura", "-- Voltar --"]
      else:
        equipado_mensagem = ["Equipar armadura", "Dropar armadura", "-- Voltar --"]

      armadura_detalhes = inquirer.select(
        message=f'Nome: {armadura.nome}, Peso: {armadura.peso}, Preço: {armadura.preco}, Proteção: {armadura.pontos_protecao}, Parte do Corpo: {armadura.parte_corpo}',
        choices=equipado_mensagem
      ).execute()

      if armadura_detalhes == "Equipar armadura":
        self.db.equipar_armadura(armadura.id_instancia, jogador.id)
      elif armadura_detalhes == "Desequipar armadura":
        self.db.desequipar_armadura(armadura.id_instancia, jogador.id)
      elif armadura_detalhes == "Dropar armadura":
        self.db.drop_item(armadura.id_instancia, id_area)
      elif armadura_detalhes == "-- Voltar --":
        break


  def handle_armas(self, jogador, id_area):
      while True:
        arma_equipada = None
        arma_equipada_nome = "-"
        if (jogador.item_arma != None):
          arma_equipada = self.db.get_item(jogador.item_arma)
          arma_equipada_nome = arma_equipada.nome

        armas_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Armas")
              
        arma = inquirer.select(
          message=f"------- Itens equipados: -------\nArma => [ {arma_equipada_nome} ]\n--------------------------------\nSelecione um item para ver seus detalhes",
          choices=[Choice(arma, arma.nome) for arma in armas_inventario]
          + ["-- Voltar --"]
        ).execute()
              
        if arma == "-- Voltar --":
          break
        else:
          self.handle_armas_details(jogador, id_area, arma, arma_equipada_nome)


  def handle_armas_details(self, jogador, id_area, arma, arma_equipada_nome):
          while True:
            equipado_mensagem = ""
            if arma.nome == arma_equipada_nome:
              equipado_mensagem = ["Desequipar arma", "-- Voltar --"]
            else:
              equipado_mensagem = ["Equipar arma", "Dropar arma", "-- Voltar --"]

            arma_detalhes = inquirer.select(
              message=f'Nome: {arma.nome}, Peso: {arma.peso}, Preço: {arma.preco}, Dano: {arma.dano}',
              choices=equipado_mensagem
            ).execute()

            if arma_detalhes == "Equipar arma":
              self.db.equipar_arma(arma.id_instancia, jogador.id)
            elif arma_detalhes == "Desequipar arma":
              self.db.desequipar_arma(arma.id_instancia, jogador.id)
            elif arma_detalhes == "Dropar arma":
              self.db.drop_item(arma.id_instancia, id_area)
            elif arma_detalhes == "-- Voltar --":
              break


  def handle_pergaminhos(self, jogador, id_area):
      while True:
        pergaminhos_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Pergaminhos")
              
        pergaminho = inquirer.select(
          message="Selecione um item para ver seus detalhes",
          choices=[Choice(pergaminho, pergaminho.nome) for pergaminho in pergaminhos_inventario]
          + ["-- Voltar --"]
        ).execute()

        if pergaminho == "-- Voltar --":
          break
        else:
              self.handle_pergaminhos_details(id_area, pergaminho)


  def handle_pergaminhos_details(self, id_area, pergaminho):
      while True:
        pergaminho_detalhes = inquirer.select(
            message=f'Nome: {pergaminho.nome}, Peso: {pergaminho.peso}, Preço: {pergaminho.preco}, Raridade: {pergaminho.raridade}, Técnica: {pergaminho.tecnica}',
            choices=["Aprender técnica", "Dropar pergaminho", "-- Voltar --"]
          ).execute()
                      
        if pergaminho_detalhes == "Dropar pergaminho":
          self.db.drop_item(pergaminho.id_instancia, id_area)

        # TODO: Aprender tecnica

        elif pergaminho_detalhes == "-- Voltar --":
          break


  def handle_pocoes(self, jogador, id_area):
      while True:
        pocoes_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Poções")

        pocao = inquirer.select(
          message="Selecione um item para ver seus detalhes",
          choices=[Choice(pocao, pocao.nome) for pocao in pocoes_inventario]
          + ["-- Voltar --"]
        ).execute()

        if pocao == "-- Voltar --":
          break
        else:
          self.handle_pocoes_details(id_area, pocao)


  def handle_pocoes_details(self, id_area, pocao):
      while True:
        pocao_detalhes = inquirer.select(
          message=f'Nome: {pocao.nome}, Peso: {pocao.peso}, Preço: {pocao.preco}, Cura: {pocao.pontos_cura}',
          choices=["Usar poção", "Dropar poção", "-- Voltar --"]
        ).execute()
                  
        if pocao_detalhes == "Dropar poção":
          self.db.drop_item(pocao.id_instancia, id_area)

        elif pocao_detalhes == "-- Voltar --":
          break
