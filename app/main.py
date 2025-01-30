from InquirerPy import inquirer
from InquirerPy.base.control import Choice
from database import Database
import os

from ascii_art import AANG, APPA


# limpa o terminal
def clear():
  os.system('cls' if os.name == 'nt' else 'clear')

class Game():
    
  def __init__(self):
    self.db = Database()
  
  def start(self):
    while True:
      clear()
      print("================================")
      print(AANG)
      print("RPG AVATAR: A LENDA DE AANG")
      print("================================")

      startOptions = ["Iniciar Novo Jogo", "Carregar Jogo", "Sair"]
      choice = inquirer.select(
      message="Bem vindo Jogador, escolha uma opção",
      choices=startOptions,
      ).execute()

      # Iniciar Novo Jogo
      if choice == startOptions[0]:
        self.new_game()
      
      # Carregar Jogo
      elif choice == startOptions[1]:
        self.load_game()

      # Sair
      elif choice == startOptions[2]:
        print("Saindo...")
        self.db.close()
        break

  def new_game(self):
    clear()
    print("================================")
    print("NOVO JOGO")
    print("================================")
    nome = inquirer.text(
      message="Digite o nome do Jogador",
      validate=lambda result: len(result) >= 3 and len(result) <= 50,
      invalid_message="O nome do jogador deve ter no mínimo 3 e no máximo 50 caracteres.",
    ).execute()
    
    id_jogador = self.db.create_player(nome)
    
    clear()
    print("================================")
    print(APPA)
    print("O mundo está em guerra, e o equilíbrio entre os quatro elementos foi quebrado. Em um tempo de incerteza, heróis surgem de onde menos se espera. Agora é sua vez de agir. Você será testado em coragem, sabedoria e poder. Sua jornada será difícil, mas sua determinação pode mudar o destino do mundo. Prepare-se para enfrentar desafios e lutar pela paz. O futuro depende de suas escolhas!")
    print("================================")
    print()
    input("Pressione Enter para começar...")

    self.gameplay(id_jogador)

  def load_game(self):
    clear()
    print("================================")
    print("CARREGAR JOGO")
    print("================================")
    jogadores = self.db.get_players()
    if len(jogadores) == 0:
      print("Nenhum jogo salvo.")
      input("Pressione Enter para voltar ao menu...")
      return

    jogadores_choices = [Choice(jogador.id, f'{jogador.id}. {jogador.nome}') for jogador in jogadores]
    jogador = inquirer.select(
      message="Escolha o jogador que deseja carregar",
      choices=jogadores_choices,
    ).execute()

    self.gameplay(jogador)

  def gameplay(self, id_jogador):

    while True:
      jogador = self.db.get_player(id_jogador)
      clear()
      print("================================")
      print("STATUS DO JOGADOR")
      print(jogador.nome)
      print(f'Pontos de Vida: {jogador.vida_atual}/{jogador.vida_max}')
      print(f'Nível: {jogador.nivel} ({jogador.xp} XP)')
      print("================================")

      area_atual = self.db.get_area(jogador.id_area_atual)

      print(f'Cidade atual: {area_atual.cidade}')
      print(f'Area Atual: {area_atual.nome}')
      print(f'Descrição: {area_atual.descricao}')
      print()
      
      area_norte = self.db.get_nome_area(area_atual.area_norte)
      area_sul = self.db.get_nome_area(area_atual.area_sul)
      area_leste = self.db.get_nome_area(area_atual.area_leste)
      area_oeste = self.db.get_nome_area(area_atual.area_oeste)
      choices = [
        Choice("norte", f'Ir para o Norte: {area_norte}'),
        Choice("sul", f'Ir para o Sul: {area_sul}'),
        Choice("leste", f'Ir para o Leste: {area_leste}'),
        Choice("oeste", f'Ir para o Oeste: {area_oeste}'),
        "Abrir o inventário"
      ]

      itens_na_area = self.db.get_itens_por_area(area_atual.id)
      if len(itens_na_area) > 0:
        choices.append("Procurar por Itens na área")

      npcs_na_area = self.db.get_npcs_por_area(area_atual.id)
      if npcs_na_area:
        choices.append("Procurar por NPCs na área")
      
      inimigos_na_area = self.db.get_inimigos_por_area(area_atual.id)
      if inimigos_na_area:
        choices.append("Procurar por Inimigos na área")

      choices.append("-- Voltar ao Menu Inicial --")

      opcao = inquirer.select(
        message="Que ação deseja realizar?",
        choices=choices
      ).execute()

      # Se mover entre áreas
      if opcao == "norte" and area_norte != "Nenhuma":
        id_prox_area = area_atual.area_norte
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "sul" and area_sul != "Nenhuma":
        id_prox_area = area_atual.area_sul
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "leste" and area_leste != "Nenhuma":
        id_prox_area = area_atual.area_leste
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "oeste" and area_oeste != "Nenhuma":
        id_prox_area = area_atual.area_oeste
        self.db.update_player_area(id_jogador, id_prox_area)

      # Inventário
      elif opcao == "Abrir o inventário":
        while True:
          opcao_inventario = inquirer.select(
            message="Qual aba deseja abrir?",
            choices=["Poções", "Pergaminhos", "Armas", "Armaduras", "-- Fechar o inventário --"]
          ).execute()

          if opcao_inventario == "Poções":
            while True:
              pocoes_inventario = self.db.get_itens_inventario_por_aba(id_jogador, "Poções")
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
                      
                      if opcao_inventario_pocoes_detalhes == "-- Voltar --":
                        break
                    break
            
          elif opcao_inventario == "Pergaminhos":
            while True:
              pergaminhos_inventario = self.db.get_itens_inventario_por_aba(id_jogador, "Pergaminhos")
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
                      
                      if opcao_inventario_pergaminhos_detalhes == "-- Voltar --":
                        break
                    break
            
          elif opcao_inventario == "Armas":
            while True:
              armas_inventario = self.db.get_itens_inventario_por_aba(id_jogador, "Armas")
              choices_inventario_armas = [Choice(item.nome) for item in armas_inventario]
              choices_inventario_armas.append("-- Voltar --")
              
              opcao_inventario_armas = inquirer.select(
                message="Selecione um item para ver seus detalhes",
                choices=choices_inventario_armas
              ).execute()
              
              if opcao_inventario_armas == "-- Voltar --":
                break
              else:
                for item in armas_inventario:
                  if (item.nome == opcao_inventario_armas):
                    while True:
                      opcao_inventario_armas_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Dano: {item.dano}',
                        choices=["Equipar arma", "Dropar arma", "-- Voltar --"] # Implementar equipar/desequipar
                      ).execute()
                      
                      if opcao_inventario_armas_detalhes == "-- Voltar --":
                        break
                    break
            
          elif opcao_inventario == "Armaduras":
            while True:
              armaduras_inventario = self.db.get_itens_inventario_por_aba(id_jogador, "Armaduras")
              choices_inventario_armaduras = [Choice(item.nome) for item in armaduras_inventario]
              choices_inventario_armaduras.append("-- Voltar --")
              
              opcao_inventario_armaduras = inquirer.select(
                message="Selecione um item para ver seus detalhes",
                choices=choices_inventario_armaduras
              ).execute()
              
              if opcao_inventario_armaduras == "-- Voltar --":
                break
              else:
                for item in armaduras_inventario:
                  if (item.nome == opcao_inventario_armaduras):
                    while True:
                      opcao_inventario_armaduras_detalhes = inquirer.select(
                        message=f'Nome: {item.nome}, Peso: {item.peso}, Preço: {item.preco}, Proteção: {item.pontos_protecao}, Parte do Corpo: {item.parte_corpo}',
                        choices=["Equipar armadura", "Dropar armadura", "-- Voltar --"] # Implementar equipar/desequipar
                      ).execute()
                      
                      if opcao_inventario_armaduras_detalhes == "-- Voltar --":
                        break
                    break
          
          elif opcao_inventario == "-- Fechar o inventário --":
            break
      
      # Itens na área
      elif opcao == "Procurar por Itens na área":
        while True:
          choices_item = [Choice(item.nome) for item in itens_na_area] # Colocar só o nome do item
          choices_item.append("-- Voltar --")

          opcao_item = inquirer.select(
            message="Selecione um item para adicioná-lo ao inventário",
            choices=choices_item
          ).execute()

          if opcao_item == "-- Voltar --":
            break

      # NPCs na área
      elif opcao == "Procurar por NPCs na área":
        while True:
          choices_npc = [Choice(npc.nome) for npc in npcs_na_area] # Colocar só o nome do NPC
          choices_npc.append("-- Voltar --")

          opcao_npc = inquirer.select(
            message="Com quem deseja conversar?",
            choices=choices_npc
          ).execute()

          if opcao_npc == "-- Voltar --":
            break

      # Inimigos na área
      elif opcao == "Procurar por Inimigos na área":
        while True:
          choices_inimigo = [Choice(inimigo.nome) for inimigo in inimigos_na_area] # Colocar só o nome do Inimigo
          choices_inimigo.append("-- Voltar --")

          opcao_inimigo = inquirer.select(
            message="Quem deseja enfrentar?",
            choices=choices_inimigo
          ).execute()

          if opcao_inimigo == "-- Voltar --":
            break
      
      elif opcao == "-- Voltar ao Menu Inicial --":
        break
    

if __name__ == "__main__":
  game = Game()
  game.start()
