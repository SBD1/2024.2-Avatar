from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from model.database import Database
from view.inventario import Inventario
from view.loot import Loot
from view.amigos import Amigos
from view.inimigos import Inimigos

from utils.clear import clear
from utils.print_menu import print_header
from assets.ascii_art import AANG, APPA

class Game():
  def __init__(self):
    self.db = Database()
    self.inv = Inventario(self.db)
    self.loot = Loot(self.db)
    self.amigos = Amigos(self.db)
    self.inimigos = Inimigos(self.db)


  def start(self):
    while True:
      print_header(AANG, "RPG AVATAR: A LENDA DE AANG")

      choice = inquirer.select(
      message="Bem vindo Jogador, escolha uma opção",
      choices=["Iniciar Novo Jogo", "Carregar Jogo", "Sair"],
      ).execute()

      if choice == "Iniciar Novo Jogo":
        self.new_game()
      
      elif choice == "Carregar Jogo":
        self.load_game()

      elif choice == "Sair":
        print("Saindo...")
        self.db.close()
        break


  def new_game(self):
    print_header("NOVO JOGO","")
    nome = inquirer.text(
      message="Digite o nome do Jogador",
      validate=lambda result: len(result) >= 3 and len(result) <= 50,
      invalid_message="O nome do jogador deve ter no mínimo 3 e no máximo 50 caracteres.",
    ).execute()
    
    id_jogador = self.db.create_player(nome)
    
    print_header(APPA, "O mundo está em guerra, e o equilíbrio entre os quatro elementos foi quebrado. Em um tempo de incerteza, heróis surgem de onde menos se espera. Agora é sua vez de agir. Você será testado em coragem, sabedoria e poder. Sua jornada será difícil, mas sua determinação pode mudar o destino do mundo. Prepare-se para enfrentar desafios e lutar pela paz. O futuro depende de suas escolhas!", "TITLE")
    input("Pressione Enter para começar...")

    self.gameplay(id_jogador)


  def load_game(self):
    print_header("CARREGAR JOGO","")
    jogadores = self.db.get_players()
    if len(jogadores) == 0:
      print("Nenhum jogo salvo.")
      input("Pressione Enter para voltar ao menu...")
      return

    id_jogador = inquirer.select(
      message="Escolha o jogador que deseja carregar",
      choices=[Choice(jogador.id, f'{jogador.id}. {jogador.nome}') for jogador in jogadores],
    ).execute()

    self.gameplay(id_jogador)


  def gameplay(self, id_jogador):
    while True:
      jogador = self.db.get_player(id_jogador)
      area_atual = self.db.get_area(jogador.id_area_atual)

      player_status = f"{jogador.nome}\nPontos de Vida: {jogador.vida_atual}/{jogador.vida_max}\nNível: {jogador.nivel} ({jogador.xp} XP)"
      area_status = f'Cidade atual: {area_atual.cidade}\nArea Atual: {area_atual.nome}\nDescrição: {area_atual.descricao}'
      print_header(player_status,area_status,False)

      area_norte = self.db.get_nome_area(area_atual.area_norte)
      area_sul = self.db.get_nome_area(area_atual.area_sul)
      area_leste = self.db.get_nome_area(area_atual.area_leste)
      area_oeste = self.db.get_nome_area(area_atual.area_oeste)

      # Monta as escolhas de acoes possiveis
      choices = []

      if area_norte:
          choices.append(Choice("norte", f'Ir para o Norte: {area_norte}'))
      if area_sul:
          choices.append(Choice("sul", f'Ir para o Sul: {area_sul}'))
      if area_leste:
          choices.append(Choice("leste", f'Ir para o Leste: {area_leste}'))
      if area_oeste:
          choices.append(Choice("oeste", f'Ir para o Oeste: {area_oeste}'))

      choices.append("Abrir o inventário")

      if self.loot.get_loot(area_atual.id):
        choices.append("Procurar por Itens na área")

      if self.amigos.get_amigos(area_atual.id):
        choices.append("Procurar por NPCs na área")
      
      if self.inimigos.get_inimigos(area_atual.id):
        choices.append("Procurar por Inimigos na área")

      choices.append("-- Voltar ao Menu Inicial --")

      opcao = inquirer.select(
        message="Que ação deseja realizar?",
        choices=choices
      ).execute()

      # Se mover entre áreas
      if opcao == "norte":
        id_prox_area = area_atual.area_norte
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "sul":
        id_prox_area = area_atual.area_sul
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "leste":
        id_prox_area = area_atual.area_leste
        self.db.update_player_area(id_jogador, id_prox_area)
        
      elif opcao == "oeste":
        id_prox_area = area_atual.area_oeste
        self.db.update_player_area(id_jogador, id_prox_area)

      # Inventário
      elif opcao == "Abrir o inventário":
        self.inv.handle_inventario(id_jogador, area_atual.id)
      
      # Itens na área
      elif opcao == "Procurar por Itens na área":
        self.loot.handle_loot(id_jogador, area_atual.id)

      # NPCs na área
      elif opcao == "Procurar por NPCs na área":
        self.amigos.handle_amigos(jogador, area_atual.id)

      # Inimigos na área
      elif opcao == "Procurar por Inimigos na área":
        self.inimigos.handle_inimigos(id_jogador, area_atual.id)
      
      elif opcao == "-- Voltar ao Menu Inicial --":
        break


if __name__ == "__main__":
  game = Game()
  game.start()
