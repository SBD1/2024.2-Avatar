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
    self.db.populate_db()
  
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

      direcao = inquirer.select(
        message="Para qual direção você quer se mover?",
        choices=[
          Choice("norte", f'Norte: {self.db.get_nome_area(area_atual.area_norte)}'),
          Choice("sul", f'Sul: {self.db.get_nome_area(area_atual.area_sul)}'),
          Choice("leste", f'Leste: {self.db.get_nome_area(area_atual.area_leste)}'),
          Choice("oeste", f'Oeste: {self.db.get_nome_area(area_atual.area_oeste)}'),
          "Voltar ao Menu Inicial"
        ]
      ).execute()

      if direcao == "norte":
        id_prox_area = area_atual.area_norte
      elif direcao == "sul":
        id_prox_area = area_atual.area_sul
      elif direcao == "leste":
        id_prox_area = area_atual.area_leste
      elif direcao == "oeste":
        id_prox_area = area_atual.area_oeste
      
      elif direcao == "Voltar ao Menu Inicial":
        break

      self.db.update_player_area(id_jogador, id_prox_area)
    

if __name__ == "__main__":
  game = Game()
  game.start()
