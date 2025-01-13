from InquirerPy import inquirer
from prompt_toolkit.validation import ValidationError, Validator
from database import Database
import os

from asciiArt import AANG, APPA


# limpa o terminal
def clear():
  os.system('cls' if os.name == 'nt' else 'clear')

class Game():
    
  def __init__(self):
    self.db = Database()
  
  def start(self):
    clear()
    print("================================")
    print(AANG)
    print("RPG AVATAR: A LENDA DE AANG")
    print("================================")

    startOptions = ["Iniciar Novo Jogo", "Carregar Jogo", "Sair"]
    choice = inquirer.select(
      message="Bem vindo Jogador, escolha uma opção",
      choices= startOptions,
    ).execute()

    # Iniciar Novo Jogo
    if choice == startOptions[0]:
      self.new_game()
      
    # Carregar Jogo
    elif choice == startOptions[1]:
      print("Carregar Jogo")

    # Sair
    elif choice == startOptions[2]:
      print("Saindo...")
      self.db.close()

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
    print(f"Seja bem vindo {nome}!")

    self.gameplay(id_jogador)

  def gameplay(self, id_jogador):
    clear()
    print("================================")
    print(APPA)
    print("GAMEPLAY")
    print("================================")
    print("O mundo está em guerra, e o equilíbrio entre os quatro elementos foi quebrado. Em um tempo de incerteza, heróis surgem de onde menos se espera. Agora é sua vez de agir. Você será testado em coragem, sabedoria e poder. Sua jornada será difícil, mas sua determinação pode mudar o destino do mundo. Prepare-se para enfrentar desafios e lutar pela paz. O futuro depende de suas escolhas!")
    print()
    input("Pressione Enter para começar...")

    while True:
      jogador = self.db.get_player(id_jogador)
      clear()
      print("================================")
      print("STATUS DO JOGADOR")
      print(jogador["nome"])
      print(f'Pontos de Vida: {jogador["vidaAtual"]}/{jogador["vidaMax"]}')
      print(f'Nível: {jogador["nivel"]} ({jogador["xp"]} XP)')
      print("================================")

      input("ha ha ha")

    
    
def valida_nome_jogador(answers, current):
  # Verifica se o comprimento está entre 3 e 50 caracteres
  if len(current) < 3:
    raise Exception("O valor precisa ter pelo menos 3 caracteres.")
  elif len(current) > 50:
    raise Exception("O valor não pode ter mais de 50 caracteres.")
  return True


if __name__ == "__main__":
  game = Game()
  game.start()
