DROP DATABASE IF EXISTS loja_eletronicos;

CREATE DATABASE loja_eletronicos
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE loja_eletronicos;

CREATE TABLE categoria (
    id_categoria INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome         VARCHAR(60)  NOT NULL,
    descricao    VARCHAR(255) NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categoria_nome UNIQUE (nome)
) ENGINE = InnoDB;

CREATE TABLE fornecedor (
    id_fornecedor INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    email         VARCHAR(120) NOT NULL,
    telefone      VARCHAR(20)  NOT NULL,
    cidade        VARCHAR(80)  NOT NULL,
    CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor),
    CONSTRAINT uq_fornecedor_email UNIQUE (email)
) ENGINE = InnoDB;

CREATE TABLE produto (
    id_produto    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(120)  NOT NULL,
    descricao     VARCHAR(255)  NULL,
    preco         DECIMAL(10,2) NOT NULL,
    estoque       INT UNSIGNED  NOT NULL DEFAULT 0,
    id_categoria  INT UNSIGNED  NOT NULL,
    id_fornecedor INT UNSIGNED  NOT NULL,
    CONSTRAINT pk_produto PRIMARY KEY (id_produto),
    CONSTRAINT ck_produto_preco CHECK (preco > 0),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria (id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor (id_fornecedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE cliente (
    id_cliente INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome       VARCHAR(100) NOT NULL,
    email      VARCHAR(120) NOT NULL,
    telefone   VARCHAR(20)  NOT NULL,
    cidade     VARCHAR(80)  NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_email UNIQUE (email)
) ENGINE = InnoDB;

CREATE TABLE pedido (
    id_pedido   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    data_pedido DATE         NOT NULL,
    status      ENUM('PENDENTE', 'PAGO', 'ENVIADO', 'ENTREGUE', 'CANCELADO')
                NOT NULL DEFAULT 'PENDENTE',
    id_cliente  INT UNSIGNED NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE item_pedido (
    id_item        INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    quantidade     INT UNSIGNED  NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    id_pedido      INT UNSIGNED  NOT NULL,
    id_produto     INT UNSIGNED  NOT NULL,
    CONSTRAINT pk_item_pedido PRIMARY KEY (id_item),
    CONSTRAINT uq_item_pedido_produto UNIQUE (id_pedido, id_produto),
    CONSTRAINT ck_item_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_item_preco CHECK (preco_unitario > 0),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE pagamento (
    id_pagamento   INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    data_pagamento DATE          NOT NULL,
    valor          DECIMAL(10,2) NOT NULL,
    metodo         ENUM('PIX', 'CARTAO', 'BOLETO') NOT NULL,
    status         ENUM('PENDENTE', 'APROVADO', 'RECUSADO')
                   NOT NULL DEFAULT 'PENDENTE',
    id_pedido      INT UNSIGNED  NOT NULL,
    CONSTRAINT pk_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT uq_pagamento_pedido UNIQUE (id_pedido),
    CONSTRAINT ck_pagamento_valor CHECK (valor > 0),
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE entrega (
    id_entrega      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    codigo_rastreio VARCHAR(30)  NULL,
    data_envio      DATE         NULL,
    data_entrega    DATE         NULL,
    status          ENUM('AGUARDANDO_ENVIO', 'EM_TRANSITO', 'ENTREGUE', 'ATRASADA')
                    NOT NULL DEFAULT 'AGUARDANDO_ENVIO',
    id_pedido       INT UNSIGNED NOT NULL,
    CONSTRAINT pk_entrega PRIMARY KEY (id_entrega),
    CONSTRAINT uq_entrega_pedido UNIQUE (id_pedido),
    CONSTRAINT uq_entrega_rastreio UNIQUE (codigo_rastreio),
    CONSTRAINT ck_entrega_datas CHECK (
        data_entrega IS NULL
        OR (data_envio IS NOT NULL AND data_entrega >= data_envio)
    ),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE avaliacao (
    id_avaliacao   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nota           TINYINT UNSIGNED NOT NULL,
    comentario     VARCHAR(255) NULL,
    data_avaliacao DATE         NOT NULL,
    id_cliente     INT UNSIGNED NOT NULL,
    id_produto     INT UNSIGNED NOT NULL,
    CONSTRAINT pk_avaliacao PRIMARY KEY (id_avaliacao),
    CONSTRAINT uq_avaliacao_cliente_produto UNIQUE (id_cliente, id_produto),
    CONSTRAINT ck_avaliacao_nota CHECK (nota BETWEEN 1 AND 5),
    CONSTRAINT fk_avaliacao_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_avaliacao_produto FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

INSERT INTO categoria (nome, descricao) VALUES
('Notebooks',   'Notebooks para trabalho, estudo e jogos'),
('Periféricos', 'Mouses, teclados, headsets e webcams'),
('Componentes', 'Placas de vídeo, memórias e armazenamento'),
('Monitores',   'Monitores para escritório, jogos e design'),
('Acessórios',  'Hubs, cabos e adaptadores para informática');

INSERT INTO fornecedor (nome, email, telefone, cidade) VALUES
('TechBrasil Distribuidora', 'contato@techbrasil.com.br',            '(47) 3321-4100', 'Blumenau'),
('InfoParts Comércio',       'vendas@infoparts.com.br',              '(11) 4002-8922', 'São Paulo'),
('Periféricos Sul',          'comercial@perifericossul.com.br',      '(47) 3422-7788', 'Joinville'),
('Global Eletrônicos',       'atendimento@globaleletronicos.com.br', '(41) 3030-1500', 'Curitiba'),
('Visão Digital Monitores',  'contato@visaodigital.com.br',          '(48) 3224-6100', 'Florianópolis'),
('Nova Era Importadora',     'importacao@novaera.com.br',            '(51) 3312-9090', 'Porto Alegre');

INSERT INTO produto (nome, descricao, preco, estoque, id_categoria, id_fornecedor) VALUES
('Notebook Gamer Titan 15',   'Intel Core i7, 16 GB RAM, SSD 512 GB, tela 15,6" 144 Hz',     7499.90, 12, 1, 1),
('Notebook UltraSlim 14',     'Intel Core i5, 16 GB RAM, SSD 512 GB, tela 14" Full HD',      4899.00, 20, 1, 2),
('Mouse Gamer RGB 12000 DPI', 'Mouse óptico com 6 botões programáveis e iluminação RGB',      129.90, 80, 2, 3),
('Teclado Mecânico ABNT2',    'Teclado mecânico com switch azul e layout ABNT2',              289.90, 45, 2, 3),
('Headset Gamer USB 7.1',     'Headset com som surround virtual e microfone removível',       219.90, 35, 2, 4),
('Webcam Full HD 1080p',      'Webcam com microfone embutido e foco automático',              179.90, 40, 2, 4),
('Placa de Vídeo 8 GB GDDR6', 'Placa de vídeo dedicada com 8 GB de memória GDDR6',           2399.00, 10, 3, 1),
('Memória RAM 16 GB DDR4',    'Módulo de memória DDR4 3200 MHz',                              349.90, 60, 3, 2),
('SSD NVMe 1 TB',             'SSD M.2 NVMe com leitura de até 3500 MB/s',                    459.90, 50, 3, 2),
('Monitor 24" Full HD',       'Monitor LED 24 polegadas, 75 Hz, painel IPS',                  899.00, 25, 4, 5),
('Monitor Curvo 27" QHD',     'Monitor curvo 27 polegadas, 2560x1440, 144 Hz',               1699.00,  8, 4, 5),
('Hub USB-C 7 em 1',          'Hub com HDMI, USB 3.0, leitor de cartão e entrada USB-C',      149.90, 70, 5, 4);

INSERT INTO cliente (nome, email, telefone, cidade) VALUES
('Ana Beatriz Souza',   'ana.souza@email.com',      '(47) 99101-1001', 'Blumenau'),
('Carlos Eduardo Lima', 'carlos.lima@email.com',    '(47) 99102-1002', 'Joinville'),
('Mariana Ferreira',    'mariana.ferreira@email.com','(48) 99103-1003', 'Florianópolis'),
('João Pedro Alves',    'joao.alves@email.com',     '(41) 99104-1004', 'Curitiba'),
('Fernanda Costa',      'fernanda.costa@email.com', '(11) 99105-1005', 'São Paulo'),
('Rafael Martins',      'rafael.martins@email.com', '(51) 99106-1006', 'Porto Alegre'),
('Juliana Rocha',       'juliana.rocha@email.com',  '(47) 99107-1007', 'Itajaí'),
('Lucas Oliveira',      'lucas.oliveira@email.com', '(47) 99108-1008', 'Blumenau'),
('Patrícia Gomes',      'patricia.gomes@email.com', '(47) 99109-1009', 'Brusque'),
('Bruno Henrique Dias', 'bruno.dias@email.com',     '(47) 99110-1010', 'Joinville'),
('Camila Nunes',        'camila.nunes@email.com',   '(47) 99111-1011', 'Jaraguá do Sul'),
('Gustavo Ribeiro',     'gustavo.ribeiro@email.com','(48) 99112-1012', 'Florianópolis'),
('Larissa Mendes',      'larissa.mendes@email.com', '(41) 99113-1013', 'Curitiba'),
('Thiago Barbosa',      'thiago.barbosa@email.com', '(47) 99114-1014', 'Gaspar'),
('Renata Carvalho',     'renata.carvalho@email.com','(47) 99115-1015', 'Blumenau');

INSERT INTO pedido (data_pedido, status, id_cliente) VALUES
('2026-07-02', 'ENTREGUE',  1),
('2026-07-08', 'ENTREGUE',  2),
('2026-07-14', 'ENTREGUE',  3),
('2026-07-20', 'ENTREGUE',  1),
('2026-07-27', 'ENTREGUE',  4),
('2026-08-03', 'ENTREGUE',  5),
('2026-08-10', 'ENVIADO',   2),
('2026-08-14', 'ENTREGUE',  6),
('2026-08-21', 'ENTREGUE',  8),
('2026-09-05', 'CANCELADO', 11),
('2026-09-08', 'CANCELADO', 2),
('2026-09-14', 'PENDENTE',  4),
('2026-09-19', 'PENDENTE',  12),
('2026-09-23', 'ENVIADO',   7),
('2026-09-25', 'ENVIADO',   9),
('2026-09-27', 'PAGO',      3),
('2026-09-29', 'PAGO',      1),
('2026-10-01', 'PAGO',      10),
('2026-10-02', 'PAGO',      1),
('2026-10-03', 'PENDENTE',  13);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1,  2,  1, 4899.00),
(1,  3,  1,  129.90),
(2,  10, 2,  899.00),
(2,  4,  1,  289.90),
(3,  5,  1,  219.90),
(3,  3,  1,  129.90),
(4,  8,  2,  349.90),
(4,  9,  1,  459.90),
(4,  12, 1,  149.90),
(5,  1,  1, 7499.90),
(5,  12, 1,  149.90),
(6,  7,  1, 2399.00),
(6,  8,  1,  349.90),
(7,  3,  2,  129.90),
(7,  6,  1,  179.90),
(7,  12, 1,  149.90),
(8,  4,  1,  289.90),
(8,  5,  1,  219.90),
(9,  10, 1,  899.00),
(9,  12, 1,  149.90),
(10, 12, 1,  149.90),
(10, 6,  1,  179.90),
(11, 7,  1, 2399.00),
(12, 5,  1,  219.90),
(12, 6,  1,  179.90),
(13, 8,  1,  349.90),
(13, 3,  1,  129.90),
(14, 9,  1,  459.90),
(14, 8,  1,  349.90),
(15, 2,  1, 4899.00),
(16, 7,  1, 2399.00),
(16, 9,  1,  459.90),
(17, 6,  2,  179.90),
(17, 3,  1,  129.90),
(18, 3,  1,  129.90),
(18, 4,  1,  289.90),
(18, 5,  1,  219.90),
(19, 5,  1,  219.90),
(19, 12, 2,  149.90),
(19, 4,  1,  289.90),
(20, 10, 1,  899.00),
(20, 3,  1,  129.90);

INSERT INTO pagamento (data_pagamento, valor, metodo, status, id_pedido) VALUES
('2026-07-02', 5028.90, 'CARTAO', 'APROVADO', 1),
('2026-07-08', 2087.90, 'PIX',    'APROVADO', 2),
('2026-07-14',  349.80, 'PIX',    'APROVADO', 3),
('2026-07-20', 1309.60, 'CARTAO', 'APROVADO', 4),
('2026-07-27', 7649.80, 'CARTAO', 'APROVADO', 5),
('2026-08-05', 2748.90, 'BOLETO', 'APROVADO', 6),
('2026-08-10',  589.60, 'PIX',    'APROVADO', 7),
('2026-08-16',  509.80, 'BOLETO', 'APROVADO', 8),
('2026-08-21', 1048.90, 'CARTAO', 'APROVADO', 9),
('2026-09-08', 2399.00, 'CARTAO', 'RECUSADO', 11),
('2026-09-14',  399.80, 'BOLETO', 'PENDENTE', 12),
('2026-09-23',  809.80, 'PIX',    'APROVADO', 14),
('2026-09-25', 4899.00, 'CARTAO', 'APROVADO', 15),
('2026-09-27', 2858.90, 'PIX',    'APROVADO', 16),
('2026-09-29',  489.70, 'PIX',    'APROVADO', 17),
('2026-10-01',  639.70, 'CARTAO', 'APROVADO', 18),
('2026-10-02',  809.60, 'PIX',    'APROVADO', 19);

INSERT INTO entrega (codigo_rastreio, data_envio, data_entrega, status, id_pedido) VALUES
('BR100000001', '2026-07-03', '2026-07-08', 'ENTREGUE',         1),
('BR100000002', '2026-07-09', '2026-07-14', 'ENTREGUE',         2),
('BR100000003', '2026-07-15', '2026-07-21', 'ENTREGUE',         3),
('BR100000004', '2026-07-21', '2026-07-26', 'ENTREGUE',         4),
('BR100000005', '2026-07-28', '2026-08-04', 'ENTREGUE',         5),
('BR100000006', '2026-08-06', '2026-08-12', 'ENTREGUE',         6),
('BR100000007', '2026-08-12', NULL,         'ATRASADA',         7),
('BR100000008', '2026-08-17', '2026-08-22', 'ENTREGUE',         8),
('BR100000009', '2026-08-22', '2026-08-26', 'ENTREGUE',         9),
('BR100000010', '2026-09-26', NULL,         'EM_TRANSITO',      14),
('BR100000011', '2026-09-28', NULL,         'EM_TRANSITO',      15),
(NULL,          NULL,         NULL,         'AGUARDANDO_ENVIO', 16),
(NULL,          NULL,         NULL,         'AGUARDANDO_ENVIO', 17),
(NULL,          NULL,         NULL,         'AGUARDANDO_ENVIO', 18),
(NULL,          NULL,         NULL,         'AGUARDANDO_ENVIO', 19);

INSERT INTO avaliacao (nota, comentario, data_avaliacao, id_cliente, id_produto) VALUES
(5, 'Notebook leve e com bateria que dura o dia todo.',          '2026-07-15', 1, 2),
(4, 'Mouse preciso, mas o cabo poderia ser mais longo.',         '2026-07-16', 1, 3),
(4, 'Boa qualidade de imagem pelo preço.',                       '2026-07-20', 2, 10),
(5, 'Teclado com ótimo acabamento e digitação silenciosa.',      '2026-07-21', 2, 4),
(3, 'Som bom, porém o microfone capta muito ruído.',             '2026-07-28', 3, 5),
(4, 'Bom custo-benefício.',                                      '2026-07-29', 3, 3),
(5, 'Velocidade excelente, o sistema inicia em segundos.',       '2026-08-02', 1, 8),
(5, 'Desempenho incrível em jogos pesados.',                     '2026-08-12', 4, 1),
(2, 'Esquenta bastante e uma das portas USB falhou.',            '2026-08-13', 4, 12),
(5, 'Roda tudo em alta sem engasgar.',                           '2026-08-20', 5, 7),
(4, 'Instalação simples e desempenho consistente.',              '2026-08-21', 5, 8),
(4, 'Digitação confortável e teclas firmes.',                    '2026-08-29', 6, 4),
(2, 'Confortável, mas a conexão USB oscila.',                    '2026-08-30', 6, 5),
(5, 'Cores vivas e ótimo ângulo de visão.',                      '2026-09-02', 8, 10),
(4, 'Compacto e resolve bem o dia a dia.',                       '2026-09-03', 8, 12);

SELECT p.nome AS produto,
       p.preco,
       p.estoque,
       c.nome AS categoria
FROM produto p
JOIN categoria c ON c.id_categoria = p.id_categoria
ORDER BY p.nome;

SELECT p.nome AS produto,
       p.preco,
       f.nome AS fornecedor,
       f.cidade AS cidade_fornecedor
FROM produto p
JOIN fornecedor f ON f.id_fornecedor = p.id_fornecedor
ORDER BY p.nome;

SELECT pe.id_pedido AS numero_pedido,
       pe.data_pedido,
       pe.status,
       c.nome AS cliente,
       c.cidade AS cidade_cliente
FROM pedido pe
JOIN cliente c ON c.id_cliente = pe.id_cliente
ORDER BY pe.id_pedido;

SELECT pe.id_pedido AS numero_pedido,
       pr.nome AS produto,
       ip.quantidade,
       ip.preco_unitario
FROM pedido pe
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
JOIN produto pr ON pr.id_produto = ip.id_produto
ORDER BY pe.id_pedido, pr.nome;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       pr.nome AS produto,
       ip.quantidade,
       ip.preco_unitario,
       pe.status AS status_pedido
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
JOIN produto pr ON pr.id_produto = ip.id_produto
ORDER BY pe.id_pedido, pr.nome;

SELECT c.nome AS cliente,
       COUNT(pe.id_pedido) AS quantidade_pedidos
FROM cliente c
LEFT JOIN pedido pe ON pe.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY quantidade_pedidos DESC, c.nome;

SELECT c.nome,
       c.email,
       c.cidade
FROM cliente c
LEFT JOIN pedido pe ON pe.id_cliente = c.id_cliente
WHERE pe.id_pedido IS NULL
ORDER BY c.nome;

SELECT c.nome AS categoria,
       COUNT(p.id_produto) AS quantidade_produtos
FROM categoria c
LEFT JOIN produto p ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY quantidade_produtos DESC, c.nome;

SELECT c.nome AS categoria,
       COUNT(p.id_produto) AS quantidade_produtos
FROM categoria c
JOIN produto p ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) = (
    SELECT MAX(t.quantidade)
    FROM (
        SELECT COUNT(*) AS quantidade
        FROM produto
        GROUP BY id_categoria
    ) AS t
);

SELECT f.nome AS fornecedor,
       COUNT(p.id_produto) AS quantidade_produtos
FROM fornecedor f
LEFT JOIN produto p ON p.id_fornecedor = f.id_fornecedor
GROUP BY f.id_fornecedor, f.nome
ORDER BY quantidade_produtos DESC, f.nome;

SELECT f.id_fornecedor,
       f.nome,
       f.email,
       f.cidade
FROM fornecedor f
LEFT JOIN produto p ON p.id_fornecedor = f.id_fornecedor
WHERE p.id_produto IS NULL
ORDER BY f.nome;

SELECT p.nome,
       p.preco,
       c.nome AS categoria
FROM produto p
JOIN categoria c ON c.id_categoria = p.id_categoria
WHERE p.preco = (SELECT MAX(preco) FROM produto);

SELECT p.nome,
       c.nome AS categoria,
       p.preco
FROM produto p
JOIN categoria c ON c.id_categoria = p.id_categoria
LEFT JOIN item_pedido ip ON ip.id_produto = p.id_produto
WHERE ip.id_item IS NULL
ORDER BY p.nome;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       COUNT(ip.id_item) AS quantidade_itens
FROM pedido pe
JOIN cliente c ON c.id_cliente = pe.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY pe.id_pedido, c.nome
ORDER BY quantidade_itens DESC, pe.id_pedido;

SELECT pr.nome AS produto,
       COUNT(ip.id_item) AS vezes_vendido
FROM produto pr
JOIN item_pedido ip ON ip.id_produto = pr.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY vezes_vendido DESC, pr.nome;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       pe.status AS status_pedido,
       pg.valor AS valor_pagamento,
       pg.metodo,
       pg.status AS status_pagamento
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN pagamento pg ON pg.id_pedido = pe.id_pedido
ORDER BY pe.id_pedido;

SELECT pe.id_pedido AS numero_pedido,
       pe.data_pedido,
       c.nome AS cliente,
       pe.status
FROM pedido pe
JOIN cliente c ON c.id_cliente = pe.id_cliente
LEFT JOIN pagamento pg ON pg.id_pedido = pe.id_pedido
WHERE pg.id_pagamento IS NULL
ORDER BY pe.id_pedido;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       pe.status AS status_pedido,
       en.codigo_rastreio,
       en.status AS status_entrega
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN entrega en ON en.id_pedido = pe.id_pedido
ORDER BY pe.id_pedido;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       pe.data_pedido,
       pe.status
FROM pedido pe
JOIN cliente c ON c.id_cliente = pe.id_cliente
LEFT JOIN entrega en ON en.id_pedido = pe.id_pedido
WHERE en.id_entrega IS NULL
ORDER BY pe.id_pedido;

SELECT pr.nome AS produto,
       c.nome AS cliente,
       a.nota,
       a.comentario
FROM avaliacao a
JOIN produto pr ON pr.id_produto = a.id_produto
JOIN cliente c ON c.id_cliente = a.id_cliente
ORDER BY pr.nome, a.nota DESC;

SELECT pr.nome AS produto,
       ROUND(AVG(a.nota), 2) AS media_avaliacao
FROM produto pr
JOIN avaliacao a ON a.id_produto = pr.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY media_avaliacao DESC, pr.nome;

SELECT pr.nome AS produto,
       COUNT(a.id_avaliacao) AS quantidade_avaliacoes
FROM produto pr
LEFT JOIN avaliacao a ON a.id_produto = pr.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY quantidade_avaliacoes DESC, pr.nome;

SELECT pe.id_pedido AS numero_pedido,
       c.nome AS cliente,
       SUM(ip.quantidade * ip.preco_unitario) AS valor_total
FROM pedido pe
JOIN cliente c ON c.id_cliente = pe.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY pe.id_pedido, c.nome
ORDER BY valor_total DESC;

SELECT c.nome AS cliente,
       COUNT(DISTINCT pe.id_pedido) AS quantidade_pedidos,
       SUM(ip.quantidade * ip.preco_unitario) AS valor_total
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY c.id_cliente, c.nome
ORDER BY valor_total DESC;

SELECT c.nome AS cliente,
       c.cidade,
       COUNT(DISTINCT pe.id_pedido) AS quantidade_pedidos,
       COALESCE(SUM(ip.quantidade), 0) AS quantidade_itens
FROM cliente c
LEFT JOIN pedido pe ON pe.id_cliente = c.id_cliente
LEFT JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY c.id_cliente, c.nome, c.cidade
ORDER BY quantidade_pedidos DESC, c.nome;

SELECT c.nome AS cliente,
       COUNT(pe.id_pedido) AS quantidade_pedidos
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(pe.id_pedido) > 2
ORDER BY quantidade_pedidos DESC, c.nome;

SELECT c.nome AS categoria,
       COUNT(p.id_produto) AS quantidade_produtos
FROM categoria c
JOIN produto p ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) > 2
ORDER BY quantidade_produtos DESC, c.nome;

SELECT pr.nome AS produto,
       ROUND(AVG(a.nota), 2) AS media_avaliacao,
       COUNT(a.id_avaliacao) AS quantidade_avaliacoes
FROM produto pr
JOIN avaliacao a ON a.id_produto = pr.id_produto
GROUP BY pr.id_produto, pr.nome
HAVING AVG(a.nota) >= 4
ORDER BY media_avaliacao DESC, pr.nome;

SELECT c.nome AS cliente,
       COUNT(DISTINCT pe.id_pedido) AS quantidade_pedidos,
       SUM(ip.quantidade * ip.preco_unitario) AS valor_total
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY c.id_cliente, c.nome
HAVING SUM(ip.quantidade * ip.preco_unitario) > 1000
ORDER BY valor_total DESC;

SELECT c.nome AS cliente,
       c.cidade,
       COUNT(DISTINCT pe.id_pedido) AS quantidade_pedidos,
       SUM(ip.quantidade) AS quantidade_itens,
       SUM(ip.quantidade * ip.preco_unitario) AS valor_total
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = pe.id_pedido
GROUP BY c.id_cliente, c.nome, c.cidade
ORDER BY valor_total DESC;
