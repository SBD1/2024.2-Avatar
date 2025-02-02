from InquirerPy import inquirer
from InquirerPy.base.control import Choice

class Inventario:
  def __init__(self, db):
    self.db = db

  def handle_inventario(self, jogador, area_atual):
      while True:
        opcao_inventario = inquirer.select(
            message="Qual aba deseja abrir?",
            choices=["Poções", "Pergaminhos", "Armas", "Armaduras", "-- Fechar o inventário --"]
          ).execute()

        if opcao_inventario == "Poções":
          self.handle_pocoes(area_atual)
            
        elif opcao_inventario == "Pergaminhos":
          self.handle_pergaminhos(area_atual)
            
        elif opcao_inventario == "Armas":
          self.handle_armas(jogador, area_atual)
            
        elif opcao_inventario == "Armaduras":
          self.handle_armaduras(jogador, area_atual)
          
        elif opcao_inventario == "-- Fechar o inventário --":
          break

  def handle_armaduras(self, jogador, area_atual):
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
        choices_inventario_armaduras = [Choice(item.nome) for item in armaduras_inventario]
        choices_inventario_armaduras.append("-- Voltar --")
              
        opcao_inventario_armaduras = inquirer.select(
                message=f"------- Itens equipados: -------\nCapacete  => [ {capacete_equipado_nome} ]\nPeitoral  => [ {peitoral_equipado_nome} ]\nAcessório => [ {acessorio_equipado_nome} ]\nBotas     => [ {bota_equipada_nome} ]\n--------------------------------\nSelecione um item para ver seus detalhes",
                choices=choices_inventario_armaduras
              ).execute()
              
        if opcao_inventario_armaduras == "-- Voltar --":
          break
        else:
          for item in armaduras_inventario:
            if (item.nome == opcao_inventario_armaduras):
              while True:
                equipado_mensagem = ""
                if item.nome in {capacete_equipado_nome, peitoral_equipado_nome, acessorio_equipado_nome, bota_equipada_nome}:
                  equipado_mensagem = ["Desequipar armadura", "-- Voltar --"]
                else:
                  equipado_mensagem = ["Equipar armadura", "Dropar armadura", "-- Voltar --"]

                opcao_inventario_armaduras_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Proteção: {item.pontos_protecao}, Parte do Corpo: {item.parte_corpo}',
                        choices=equipado_mensagem
                      ).execute()
                      
                if opcao_inventario_armaduras_detalhes == "Equipar armadura":
                  resultado = self.db.equipar_armadura(item.id_instancia, jogador.id)
                  if (resultado == True):
                    jogador = self.db.get_player(jogador.id)
                  break
                elif opcao_inventario_armaduras_detalhes == "Desequipar armadura":
                  resultado = self.db.desequipar_armadura(item.id_instancia, jogador.id)
                  if (resultado == True):
                    jogador = self.db.get_player(jogador.id)
                  break
                elif opcao_inventario_armaduras_detalhes == "Dropar armadura":
                  resultado = self.db.drop_item(item.id_instancia, area_atual.id)
                  if (resultado == True):
                    self.db.get_itens_por_area(area_atual.id)
                    break

                elif opcao_inventario_armaduras_detalhes == "-- Voltar --":
                  break
              break

  def handle_armas(self, jogador, area_atual):
      while True:
        arma_equipada = None
        arma_equipada_nome = "-"
        if (jogador.item_arma != None):
          arma_equipada = self.db.get_item(jogador.item_arma)
          arma_equipada_nome = arma_equipada.nome

        armas_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Armas")
        choices_inventario_armas = [Choice(item.nome) for item in armas_inventario]
        choices_inventario_armas.append("-- Voltar --")
              
        opcao_inventario_armas = inquirer.select(
                message=f"------- Itens equipados: -------\nArma => [ {arma_equipada_nome} ]\n--------------------------------\nSelecione um item para ver seus detalhes",
                choices=choices_inventario_armas
              ).execute()
              
        if opcao_inventario_armas == "-- Voltar --":
          break
        else:
          for item in armas_inventario:
            if item.nome == opcao_inventario_armas:
              while True:
                equipado_mensagem = ""
                if item.nome == arma_equipada_nome:
                  equipado_mensagem = ["Desequipar arma", "-- Voltar --"]
                else:
                  equipado_mensagem = ["Equipar arma", "Dropar arma", "-- Voltar --"]

                opcao_inventario_armas_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Dano: {item.dano}',
                        choices=equipado_mensagem
                      ).execute()
                      
                if opcao_inventario_armas_detalhes == "Equipar arma":
                  resultado = self.db.equipar_arma(item.id_instancia, jogador.id)
                  if (resultado == True):
                    jogador = self.db.get_player(jogador.id) # TODO: Rever se isso aqui vale a pena tbm. Tavlez fosse mais simples usar a mesma abordagem dos itens da area.
                  break
                elif opcao_inventario_armas_detalhes == "Desequipar arma":
                  resultado = self.db.desequipar_arma(item.id_instancia, jogador.id)
                  if (resultado == True):
                    jogador = self.db.get_player(jogador.id)
                  break
                elif opcao_inventario_armas_detalhes == "Dropar arma":
                  resultado = self.db.drop_item(item.id_instancia, area_atual.id)
                  if (resultado == True):
                    itens_na_area = self.db.get_itens_por_area(area_atual.id) # TODO: Remover esse tipo de coisa pra esse caso acho que vai ser mais simples a gente usar e abusar dos requests no banco do que tentar ficar mantendo uma variavel local atualizada.
                    break
                        
                elif opcao_inventario_armas_detalhes == "-- Voltar --":
                  break
              break

  def handle_pergaminhos(self, jogador, area_atual):
      while True:
        pergaminhos_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Pergaminhos")
        choices_inventario_pergaminhos = [Choice(item.nome) for item in pergaminhos_inventario]
        choices_inventario_pergaminhos.append("-- Voltar --")
              
        opcao_inventario_pergaminhos = inquirer.select(
                message="Selecione um item para ver seus detalhes",
                choices=choices_inventario_pergaminhos
              ).execute()
              
        if opcao_inventario_pergaminhos == "-- Voltar --":
          break
        else:
          for item in pergaminhos_inventario:
            if (item.nome == opcao_inventario_pergaminhos):
              while True:
                opcao_inventario_pergaminhos_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Raridade: {item.raridade}, Técnica: {item.tecnica}',
                        choices=["Aprender técnica", "Dropar pergaminho", "-- Voltar --"]
                      ).execute()
                      
                if opcao_inventario_pergaminhos_detalhes == "Dropar pergaminho":
                  resultado = self.db.drop_item(item.id_instancia, area_atual.id)
                  if (resultado == True):
                    itens_na_area = self.db.get_itens_por_area(area_atual.id)
                    break
                        
                elif opcao_inventario_pergaminhos_detalhes == "-- Voltar --":
                  break
              break

  def handle_pocoes(self, jogador, area_atual):
      while True:
        pocoes_inventario = self.db.get_itens_inventario_por_aba(jogador.id, "Poções")
        choices_inventario_pocoes = [Choice(item.nome) for item in pocoes_inventario]
        choices_inventario_pocoes.append("-- Voltar --")
              
        opcao_inventario_pocoes = inquirer.select(
                message="Selecione um item para ver seus detalhes",
                choices=choices_inventario_pocoes
              ).execute()
              
        if opcao_inventario_pocoes == "-- Voltar --":
          break
        else:
          for item in pocoes_inventario:
            if (item.nome == opcao_inventario_pocoes):
              while True:
                opcao_inventario_pocoes_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Cura: {item.pontos_cura}',
                        choices=["Usar poção", "Dropar poção", "-- Voltar --"]
                      ).execute()
                      
                if opcao_inventario_pocoes_detalhes == "Dropar poção":
                  resultado = self.db.drop_item(item.id_instancia, area_atual.id)
                  if (resultado == True):
                    itens_na_area = self.db.get_itens_por_area(area_atual.id) # TODO: Remover esse tipo de coisa pra esse caso acho que vai ser mais simples a gente usar e abusar dos requests no banco do que tentar ficar mantendo uma variavel local atualizada.
                    break
                        
                elif opcao_inventario_pocoes_detalhes == "-- Voltar --":
                  break
              break
