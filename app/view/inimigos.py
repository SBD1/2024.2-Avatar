import random
from InquirerPy import inquirer
from InquirerPy.base.control import Choice

from utils.print_menu import DIVISORIA, print_header

class Inimigos:
  def __init__(self, db):
    self.db = db


  def handle_inimigos(self, id_jogador, id_area):
    while True:
      print_header("BATALHA","")
      inimigos = self.get_inimigos(id_area)
      choices_inimigo = [Choice(inimigo.id, inimigo.nome) for inimigo in inimigos]
      choices_inimigo.append("-- Voltar --")

      opcao_inimigo = inquirer.select(
          message="Quem deseja enfrentar?",
          choices=choices_inimigo
        ).execute()

      if opcao_inimigo in [inimigo.id for inimigo in inimigos]:
          self.handle_battle(id_jogador, opcao_inimigo)

      if opcao_inimigo == "-- Voltar --":
        break


  def handle_battle(self, id_jogador, id_inimigo):
    j_ataques = self.db.get_ataques_personagem(id_jogador)
    j_defesas = self.db.get_defesas_personagem(id_jogador)
    j_esquivas = self.db.get_mobilidades_personagem(id_jogador)
    j_curas = self.db.get_curas_personagem(id_jogador)

    i_tecnicas = self.db.get_tecnicas_personagem(id_inimigo)

    while True:
      print_header("BATALHA","")
      inimigo = self.db.get_inimigo(id_inimigo)
      jogador = self.db.get_player(id_jogador)

      print(f"{jogador.vida_atual}/{jogador.vida_max} >>> {jogador.nome}\n")
      print(f"{inimigo.vida_atual}/{inimigo.vida_max} >>> {inimigo.nome}")
      print(DIVISORIA)
      print(f"\n{inimigo.nome}: {inimigo.fala_entrada}\n\n")

      if inimigo.vida_atual <= 0:
        print(f"{jogador.nome} derrotou {inimigo.nome}!")
        self.db.add_combate(id_jogador, id_inimigo, id_jogador)
        print(f"{inimigo.nome}: {inimigo.fala_saida}")
        print("Pressione Enter para voltar...")
        break

      if jogador.vida_atual <= 0:
        print(f"{inimigo.nome} derrotou {jogador.nome}!")
        self.db.add_combate(id_jogador, id_inimigo, id_inimigo)
        print("Pressione Enter para voltar...")
        break

      acao = inquirer.select(
        message="O que deseja fazer?",
        choices=[
          Choice("atacar", "Atacar"),
          Choice("defender", "Defender"),
          Choice("esquivar", "Esquivar"),
          Choice("curar", "Curar"),
          "-- Voltar --"
        ]
      ).execute()

      if acao == "atacar":
        acao_jogador = inquirer.select(
          message="Qual ataque deseja usar?",
          choices=[
            Choice(ataque, ataque.nome) for ataque in j_ataques
          ] + ["-- Voltar --"]
        ).execute()

      elif acao == "defender":
        acao_jogador = inquirer.select(
          message="Qual defesa deseja usar?",
          choices=[
            Choice(defesa, defesa.nome) for defesa in j_defesas
          ] + ["-- Voltar --"]
        ).execute()

      elif acao == "esquivar":
        acao_jogador = inquirer.select(
          message="Qual esquiva deseja usar?",
          choices=[
            Choice(esquiva, esquiva.nome) for esquiva in j_esquivas
          ] + ["-- Voltar --"]
        ).execute()

      elif acao == "curar":
        acao_jogador = inquirer.select(
          message="Qual cura deseja usar?",
          choices=[
            Choice(cura, cura.nome) for cura in j_curas
          ] + ["-- Voltar --"]
        ).execute()

      elif acao == "-- Voltar --":
        break
      
      # Lida com o caso do inimigo não possuir tecnicas
      if i_tecnicas != []:
        acao_inimigo = random.choice(i_tecnicas)
      else:
        acao_inimigo = None

      if acao_jogador == "-- Voltar --":
        continue
      else:
        self.handle_round(jogador, inimigo, acao_jogador, acao_inimigo)     


  def handle_round(self,jogador, inimigo, acao_jogador, acao_inimigo):
    j_tipo = self.get_acao_type(acao_jogador)
    i_tipo = self.get_acao_type(acao_inimigo)

    # Lida com o caso do inimigo não possuir tecnicas
    if j_tipo == "ataque" and i_tipo == None :
      print(f"O inimigo usou uma tecnica desconhecida e levou {acao_jogador.dano_causado} pontos de dano")
      self.db.deal_damage(inimigo.id, acao_jogador.dano_causado)
      input("\nPressione Enter para ir ao proximo round...")
      return

    elif (j_tipo == "defesa" or j_tipo == "esquiva") and i_tipo == None:
      print(f"Voce usou {acao_jogador.nome} e o inimigo usou uma tecnica desconhecida")
      print("Nenhum dano foi causado")
      input("\nPressione Enter para ir ao proximo round...")
      return

    elif j_tipo == "cura" and i_tipo == None:
      print(f"Voce usou {acao_jogador.nome} e o inimigo usou uma tecnica desconhecida")
      print("Voce se curou!")
      self.db.use_heal(jogador.id, acao_jogador.pontos_cura)
      input("\nPressione Enter para ir ao proximo round...")
      return

    print(f"Você usou {acao_jogador.nome} e o inimigo usou {acao_inimigo.nome}")

    # Jogador  |  Inimigo   =  Resultado
    #    A    <->    A      =  Ambos levam dano_causado
    #    C    <->    A      =  Jogador leva dano_causado
    #    A    <->    C      =  Inimigo leva dano_causado
    #    A    <->    D      =  Inimigo leva dano_causado - dano_bloqueado
    #    D    <->    A      =  Jogador leva dano_causado - dano_bloqueado
    #    A    <->    E      =  Inimigo esquiva se conseguir caso contrario leva dano_causado
    #    E    <->    A      =  Jogador esquiva se conseguir caso contrario leva dano_causado
    #    D    <->    C      =  Inimigo cura
    #    E    <->    C      =  Inimigo cura
    #    C    <->    D      =  Jogador cura
    #    C    <->    E      =  Jogador cura
    #    C    <->    C      =  Ambos curam
    #    D    <->    D      =  Nada
    #    D    <->    E      =  Nada
    #    E    <->    E      =  Nada
    #    E    <->    D      =  Nada

    if j_tipo == "ataque" and i_tipo == "ataque":
      print("Ambos levam dano!")
      print(f"Você causou {acao_jogador.dano_causado} pontos de dano e {inimigo.nome} causou {acao_inimigo.dano_causado} pontos de dano")
      self.db.deal_damage(jogador.id, acao_jogador.dano_causado)
      self.db.deal_damage(inimigo.id, acao_inimigo.dano_causado)

    elif j_tipo == "cura" and i_tipo == "ataque":
      print(f"Você não foi capaz de se curar e levou {acao_inimigo.dano_causado} pontos de dano")
      self.db.deal_damage(jogador.id, acao_inimigo.dano_causado)

    elif j_tipo == "ataque" and i_tipo == "cura":
      print(f"O inimigo não foi capaz de se curar e levou {acao_jogador.dano_causado} pontos de dano")
      self.db.deal_damage(inimigo.id, acao_jogador.dano_causado)

    elif j_tipo == "ataque" and i_tipo == "defesa":
      print("Bloqueio inimigo!")
      print(f"O inimigo levou {acao_jogador.dano_causado - acao_inimigo.dano_bloqueado} pontos de dano")
      self.db.deal_damage(inimigo.id, acao_jogador.dano_causado - acao_inimigo.dano_bloqueado)

    elif j_tipo == "defesa" and i_tipo == "ataque":
      print("Bloqueio!")
      print(f"Você levou {acao_inimigo.dano_causado - acao_jogador.dano_bloqueado} pontos de dano")
      self.db.deal_damage(jogador.id, acao_inimigo.dano_causado - acao_jogador.dano_bloqueado)

    elif j_tipo == "ataque" and i_tipo == "esquiva":
        if random.random() < acao_inimigo.chance_esquiva:
            print("O inimigo esquivou!")
        else:
            print(f"O inimigo tentou se esquivar mas falhou e levou {acao_jogador.dano_causado} pontos de dano")
            self.db.deal_damage(inimigo.id, acao_jogador.dano_causado)
    
    elif j_tipo == "esquiva" and i_tipo == "ataque":
        if random.random() < acao_jogador.chance_esquiva:
            print("Você esquivou!")
        else:
            print(f"Você tentou se esquivar mas falhou e levou {acao_inimigo.dano_causado} pontos de dano")
            self.db.deal_damage(jogador.id, acao_inimigo.dano_causado)

    elif (j_tipo == "defesa" or j_tipo == "esquiva") and i_tipo == "cura":
      print("O inimigo se curou!")
      self.db.use_heal(inimigo.id, acao_inimigo.pontos_cura)

    elif j_tipo == "cura" and (i_tipo == "defesa" or i_tipo == "esquiva"):
      print("Voce se curou!")
      self.db.use_heal(jogador.id, acao_jogador.pontos_cura)

    elif j_tipo == "cura" and i_tipo == "cura":
      print("Ambos se curaram!")
      self.db.use_heal(jogador.id, acao_jogador.pontos_cura)
      self.db.use_heal(inimigo.id, acao_inimigo.pontos_cura)

    else:
      print("Ninguem levou dano!")

    input("\nPressione Enter para ir ao proximo round...")


  def get_inimigos(self, id_area):
    return self.db.get_inimigos_por_area(id_area)


  def get_acao_type(self, acao):
    acao_types = {
        "dano_causado": "ataque",
        "dano_bloqueado": "defesa",
        "chance_esquiva": "esquiva",
        "pontos_cura": "cura"
    }
    for atributo, tipo in acao_types.items():
        if hasattr(acao, atributo):
            return tipo
    return None