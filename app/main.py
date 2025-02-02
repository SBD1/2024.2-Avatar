from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from app.model.database import Database
from app.view.inventario import Inventario
from app.view.loot import Loot
from app.view.npcs import Npcs
from app.view.inimigos import Inimigos

from app.utils.clear import clear
from app.assets.ascii_art import AANG, APPA

class Game():
  def __init__(self):
    self.db = Database()
    self.inv = Inventario(self.db)
    self.loot = Loot(self.db)
    self.npcs = Npcs(self.db)
    self.inimigos = Inimigos(self.db)

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
      self.print_player_status(jogador)

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

      if self.loot.get_loot(self, area_atual.id):
        choices.append("Procurar por Itens na área")

      if self.npcs.get_npcs(self, area_atual.id):
        choices.append("Procurar por NPCs na área")
      
      if self.inimigos.get_inimigos(self, id_jogador, area_atual.id):
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
      # elif opcao == "Abrir o inventário":
      #   self.inv.handle_inventario(jogador, area_atual)
      
      # Itens na área
      elif opcao == "Procurar por Itens na área":
        self.loot.handle_loot( id_jogador, area_atual.id)

      # NPCs na área
      elif opcao == "Procurar por NPCs na área":
        self.npcs.handle_npcs(area_atual.id)

      # Inimigos na área
      elif opcao == "Procurar por Inimigos na área":
        self.inimigos.handle_inimigos(jogador, area_atual.id)
      
      elif opcao == "-- Voltar ao Menu Inicial --":
        break

  def print_player_status(self, jogador):
      clear()
      print("================================")
      print("STATUS DO JOGADOR")
      print(jogador.nome)
      print(f'Pontos de Vida: {jogador.vida_atual}/{jogador.vida_max}')
      print(f'Nível: {jogador.nivel} ({jogador.xp} XP)')
      print("================================")

if __name__ == "__main__":
  game = Game()
  game.start()