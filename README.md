# agenda

O projeto agenda foi construído com base nas orientações do capítulo 11 - Banco de Dados do livro Iniciando com Flutter Framework, cujo objetivo é construir um aplicativo de agenda em que possam ser consultados os contatos cadastrados no aplicativo. 

O armazenamento é feito localmente utilizando o banco de dados SQLite, através da dependência sqflite.

Além das funções de CRUD é possível selecionar um contato para fazer uma ligação, para isso é utilizada a biblioteca url_launcher e é passada uma url com o número de telefone do contato selecionado como parâmetro direcionando para a tela de ligação do dispotivo com o número de telefone já preenchido.