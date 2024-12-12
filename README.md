<h1 align="center"> Avatar </h1>
<h3 align="center"> 2024.2 </h3>

## 💡 Sobre

Repositório para o projeto de um jogo RPG baseado na série animada Avatar, desenvolvido na disciplina de Sistemas de Banco de Dados 1 na Universidade de Brasilia.

## 📒 Documentação

A documentação do projeto está disponivel nesse [link](https://sbd1.github.io/2024.2-Avatar/).


## ⚙️ Instruções para colaboradores

**Para desenvolver a documentação:**

1. Instale o python e o pip
2. Instale o mkdocs-material com ```pip install mkdocs-material```
3. Execute a documentação localmente com ```python -m mkdocs serve```
4. **Obs:** As suas alterações só ficaram disponíveis na versão online após o PR para o branch *docs* ser aceito
5. **Importante:** Nunca mexa no branch *gh-pages*

## 🎮 Como rodar o jogo

### Pré-requisitos

- **Sistema operacional**: Distribuição Linux (testado no Ubuntu 20.04)
- **Docker**: versão 27 ou maior. [link para instalação no Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- **Docker Compose**: versão 2 ou maior. [link para instalação no Ubuntu](https://docs.docker.com/compose/install/linux/#install-using-the-repository)

### Comandos para rodar

Primeiramente, tenha certeza que a porta localhost 5432 esteja livre para ser utilizada.

Após isso, para subir o banco e iniciar o jogo, basta executar a linha de comando abaixo na pasta do projeto:

```
docker compose build && docker compose up -d
```

### Acessando o Banco de Dados

Para acessar o banco de dados, é possível utilizar o `psql`, que é um cliente em linha de comando que permite essa interação com bancos de dados do postgres. Para acessar usando o docker utiliza-se o seguinte comando:

```
  docker compose exec -u postgres db psql DB
```

Assim, é possível utilizar queries SQL e comandos do próprio `psql` para visualizar e manipular os dados do banco.