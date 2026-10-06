# Banco de Dados - Loja de Eletrônicos

Projeto desenvolvido para o desafio de Banco de Dados, com o objetivo de criar um banco de dados para uma loja virtual de produtos eletrônicos.

O sistema foi desenvolvido utilizando MySQL e permite controlar produtos, categorias, fornecedores, clientes, pedidos, pagamentos, entregas e avaliações.

## Objetivo

O projeto tem como objetivo organizar as informações de uma loja de eletrônicos e realizar consultas para analisar produtos, vendas, clientes, fornecedores, pagamentos, entregas e avaliações.

# tecnologias utilizadas

- MySQL
- MySQL Workbench
- SQL
- GitHub

## Banco de dados

Nome do banco:

`loja_eletronicos`

O banco possui 9 tabelas:

- Categoria
- Fornecedor
- Produto
- Cliente
- Pedido
- Item_Pedido
- Pagamento
- Entrega
- Avaliacao

## Relacionamentos

As principais relações do banco são:

```text
Categoria
    |
    └── Produto ─── Fornecedor
           |
           └── Item_Pedido ─── Pedido ─── Cliente
                                  |
                                  ├── Pagamento
                                  |
                                  └── Entrega

Cliente ─── Avaliacao ─── Produto
