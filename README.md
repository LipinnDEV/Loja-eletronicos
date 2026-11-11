# Banco de Dados — Loja de Eletrônicos

## 1. Visão geral

Este projeto consiste no desenvolvimento de um banco de dados relacional para uma loja virtual de produtos eletrônicos, desenvolvido como parte de um desafio acadêmico na área de Banco de Dados.

A solução utiliza MySQL e SQL para organizar as informações da loja, estabelecer relacionamentos entre entidades e permitir consultas relacionadas a produtos, clientes, vendas e operações comerciais.

O projeto tem como objetivo aplicar conceitos fundamentais de modelagem e gerenciamento de bancos de dados relacionais, demonstrando como diferentes entidades podem ser organizadas para representar as operações de uma loja virtual.

## 2. Objetivos do projeto

O principal objetivo é desenvolver uma estrutura de banco de dados capaz de representar as principais operações de uma loja de produtos eletrônicos, facilitando a organização, a consulta e a integridade das informações.

Entre os objetivos específicos, destacam-se:

- Estruturar um banco de dados relacional para uma loja virtual.
- Organizar informações sobre produtos, categorias e fornecedores.
- Representar clientes, pedidos e os respectivos itens de compra.
- Armazenar informações relacionadas a pagamentos e entregas.
- Relacionar clientes, produtos e avaliações.
- Aplicar conceitos de chaves primárias e estrangeiras.
- Compreender a importância da integridade referencial.
- Desenvolver consultas utilizando a linguagem SQL.

## 3. Tecnologias utilizadas

<p>
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
  <img src="https://img.shields.io/badge/SQL-336791?style=for-the-badge" alt="SQL" />
  <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub" />
</p>

| Tecnologia | Descrição |
| :--- | :--- |
| MySQL | Sistema de gerenciamento de banco de dados relacional utilizado no projeto. |
| SQL | Linguagem utilizada para criar estruturas, manipular registros e consultar informações. |
| GitHub | Plataforma utilizada para hospedar, versionar e compartilhar o projeto. |

## 4. Estrutura do banco de dados

**Nome do banco de dados:** `loja_eletronicos`

O banco de dados está organizado em nove tabelas, responsáveis por representar as principais entidades e operações do sistema.

| Tabela | Descrição |
| :--- | :--- |
| `Categoria` | Armazena as categorias utilizadas para classificar os produtos. |
| `Produto` | Armazena as informações dos produtos comercializados pela loja. |
| `Fornecedor` | Representa os fornecedores associados aos produtos. |
| `Cliente` | Armazena as informações dos clientes cadastrados. |
| `Pedido` | Registra os pedidos realizados pelos clientes. |
| `Item_Pedido` | Representa os produtos e os itens que compõem cada pedido. |
| `Pagamento` | Armazena informações relacionadas aos pagamentos dos pedidos. |
| `Entrega` | Registra informações relacionadas à entrega dos pedidos. |
| `Avaliacao` | Armazena avaliações associadas aos clientes e aos produtos. |

## 5. Modelo de dados e relacionamentos

O modelo relacional conecta as entidades necessárias para representar as operações da loja, permitindo relacionar informações e manter a consistência dos registros.

O diagrama a seguir apresenta uma representação conceitual das principais entidades e de suas relações.

```text
Categoria -------- Produto -------- Fornecedor
                     |
                     |
                 Item_Pedido
                     |
                     |
                   Pedido -------- Cliente
                     |
                +----+----+
                |         |
            Pagamento   Entrega

Cliente -------- Avaliacao -------- Produto
```

### 5.1. Categoria e Produto

Relacionamento utilizado para organizar os produtos em categorias, facilitando a classificação e a consulta dos itens comercializados.

### 5.2. Fornecedor e Produto

Representa a associação entre os fornecedores e os produtos disponibilizados pela loja.

### 5.3. Cliente e Pedido

Relaciona os pedidos aos clientes responsáveis por suas realizações, permitindo consultar as compras registradas.

### 5.4. Pedido e Item_Pedido

A tabela `Item_Pedido` representa os itens que compõem cada pedido, permitindo organizar os produtos associados às compras.

### 5.5. Produto e Item_Pedido

Permite identificar os produtos presentes nos pedidos e consultar sua participação nas compras realizadas.

### 5.6. Pedido e Pagamento

Relaciona os pedidos às informações correspondentes aos pagamentos.

### 5.7. Pedido e Entrega

Representa a associação entre os pedidos e as respectivas informações de entrega.

### 5.8. Cliente, Produto e Avaliacao

A tabela `Avaliacao` relaciona os clientes que registram avaliações aos produtos avaliados, permitindo organizar essas informações.

**Observação:** o diagrama é conceitual e não representa as cardinalidades das relações. As chaves primárias, as chaves estrangeiras e as restrições devem corresponder à implementação efetiva nos arquivos SQL do projeto.

## 6. Consultas e análises

A estrutura do banco de dados permite realizar consultas para explorar diferentes aspectos das operações da loja.

Entre as possibilidades de consulta, destacam-se:

- Listagem de produtos e suas respectivas categorias.
- Consulta dos fornecedores associados aos produtos.
- Identificação dos pedidos realizados pelos clientes.
- Consulta dos itens que compõem cada pedido.
- Análise das informações relacionadas aos pagamentos.
- Consulta das entregas associadas aos pedidos.
- Visualização das avaliações registradas para os produtos.
- Combinação de informações de diferentes tabelas utilizando operações como `INNER JOIN` e `LEFT JOIN`.

Essas consultas permitem explorar os dados armazenados e demonstrar a aplicação prática da linguagem SQL em um cenário comercial.

## 7. Conceitos de banco de dados aplicados

O projeto aborda conceitos fundamentais para a construção e a manutenção de bancos de dados relacionais.

### Modelagem de dados

Organização das entidades, definição das tabelas e identificação dos relacionamentos necessários para representar o funcionamento da loja.

### Chaves primárias

Utilização de `PRIMARY KEY` para identificar unicamente os registros de cada tabela.

### Chaves estrangeiras

Utilização de `FOREIGN KEY` para estabelecer relacionamentos entre tabelas e conectar registros relacionados.

### Integridade referencial

Aplicação de restrições que contribuem para preservar a consistência dos relacionamentos entre os registros.

### Linguagem SQL

Utilização de comandos SQL para definir estruturas, manipular informações e realizar consultas no banco de dados.

### Organização dos dados

Estruturação das informações em tabelas relacionadas, facilitando a manutenção e a recuperação dos dados.

## 8. Como executar o projeto

Para executar o banco de dados, é necessário possuir um ambiente MySQL configurado e acesso aos arquivos SQL disponibilizados neste repositório.

### Pré-requisitos

- MySQL Server instalado e configurado.
- MySQL Workbench ou outra ferramenta compatível com MySQL.
- Arquivos SQL do projeto disponíveis localmente.

### Etapas de execução

1. Clone ou baixe o repositório para o computador.

   ```bash
   git clone https://github.com/LipinnDEV/Loja-de-Eletronicos.git
   ```

2. Abra o MySQL Workbench ou outra ferramenta compatível.

3. Conecte-se ao servidor MySQL.

4. Localize e abra o arquivo SQL responsável pela criação do banco de dados e das tabelas.

5. Execute o script de criação da estrutura do banco de dados.

6. Caso exista um script de inserção de dados, execute-o após a criação das tabelas.

7. Execute as consultas SQL disponibilizadas no projeto para verificar os registros e explorar os relacionamentos.

**Importante:** a ordem de execução depende dos arquivos efetivamente disponíveis no repositório. Caso os scripts tenham dependências específicas, siga a sequência necessária para criar as tabelas e inserir os dados corretamente.

## 9. Organização do repositório

Para facilitar a navegação e a manutenção do projeto, os arquivos podem ser organizados de acordo com suas responsabilidades.

Uma estrutura sugerida é apresentada abaixo:

```text
Loja-de-Eletronicos/
|
|-- README.md
|
|-- database/
|   |-- criacao_banco.sql
|   |-- criacao_tabelas.sql
|   |-- insercao_dados.sql
|   |-- consultas.sql
```

Essa organização é apenas uma sugestão. Os nomes e diretórios devem corresponder aos arquivos existentes no repositório.

## 10. Possibilidades de evolução

O projeto pode ser ampliado futuramente para explorar novos recursos de modelagem e consulta de dados.

Entre as possíveis melhorias, destacam-se:

- Desenvolvimento de um diagrama entidade-relacionamento completo.
- Ampliação do conjunto de consultas SQL.
- Criação de consultas para identificar os produtos mais vendidos.
- Elaboração de relatórios sobre pedidos e histórico de compras.
- Inclusão de dados de exemplo para testar diferentes cenários.
- Revisão das regras de integridade e das restrições do banco.
- Documentação detalhada das colunas e dos relacionamentos de cada tabela.

Essas melhorias representam possibilidades para futuras versões e não necessariamente funcionalidades já implementadas.

## 11. Aprendizados

O desenvolvimento deste projeto contribui para a compreensão da importância dos bancos de dados relacionais na organização das informações de um sistema comercial.

Entre os conhecimentos trabalhados, destacam-se:

- Modelagem e estruturação de bancos de dados.
- Criação e organização de tabelas.
- Definição de relacionamentos entre entidades.
- Utilização de chaves primárias e estrangeiras.
- Aplicação de conceitos de integridade referencial.
- Escrita e organização de comandos SQL.
- Consulta de dados distribuídos entre diferentes tabelas.
- Representação de operações comerciais utilizando estruturas relacionais.

## 12. Autor
**Felipe Mousinho**

Estudante do Ensino Médio Integrado em Desenvolvimento de Sistemas no SESI Blumenau, com interesse em programação, bancos de dados e desenvolvimento de software.

Este projeto faz parte da minha trajetória de aprendizado na área de tecnologia, com foco na aplicação prática dos conceitos de modelagem relacional e SQL.

**GitHub:** [LipinnDEV](https://github.com/LipinnDEV)

**Repositório do projeto:** [Loja de Eletrônicos](https://github.com/LipinnDEV/Loja-de-Eletronicos)

---

Projeto acadêmico desenvolvido para praticar conceitos de Banco de Dados utilizando MySQL e SQL.
