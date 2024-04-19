# contacts
A new Flutter project.
## Getting Started
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# SEQUENCIA

## MODELO de Contatos
- Com uma chave 'ID' o modelo de Contatos terá os campos Name, Email, Phone, Img
  - Ter nessa classe Construtores para
- carregar os dados via MAP -> FromMAP
- Transformar para MAP os dados do Contato -> ToMap
- Sobrescrever o ToString

## Classe HELPER (repository)
- Será no padrão SINGLETON
- Inicializar o DB (Banco de Dados - SQLITE) se já não estiver inicializado
- Criará a tabela de Contatos (Comandos em maiusculas e parâmetros em minusculas)
- Terá função para SALVAR um Contato
- Terá função para OBTER dados de um Contato
- Terá função para ELIMINAR um Contato
- Terá função para ATUALIZAR um Contato
- como adicional criar uma função para OBTER TODOS os Contatos
- também como adicional terá uma função para OBTER TOTAL DE CONTATOS cadastrados
- Tentar criar REPOSITORY DYNAMICALY
- Tentar criar funcionalidade para rodar pelo WINDOWS

## TELAS
- TELA LISTAGEM DOS CONTATOS (List View Builder)
- TERÁ UM BOTÃO PARA ADICIONAR CONTATOS
- TERÁ A OPÇÃO DE MOSTRAR UMA TELA DE DETALHES DO CONTATO PRESSIONANDO NESTE
- TELA PARA CRIAR OU ALTERAR UM CONTATO
- NESTA TELA TERÁ A OPÇÃO DE BUSCAR IMAGEM NA GALERIA OU TIRAR UMA FOTO PELO CELULAR
- OPÇÃO DE ESCOLHAR PARA EDITAR, EXCLUIR OU LIGAR PARA O CONTATO SELECIONADO
- MOSTRAR OPÇÃO PARA ORDENAR OS CONTATOS
- TENTAR FAZER OPÇÃO DE BUSCA DE CONTATO
