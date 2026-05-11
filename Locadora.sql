USE master
CREATE DATABASE cinema
USE cinema
GO

DROP TABLE IF EXISTS filme
CREATE TABLE filme (

id INT NOT NULL,
titulo VARCHAR(40) NOT NULL,
ano INT NULL CHECK(ano <= 2021)

PRIMARY KEY (id)

)
GO

DROP TABLE IF EXISTS dvd 
CREATE TABLE dvd (

num INT NOT NULL,
dataFabric DATE NOT NULL CHECK(dataFabric < GETDATE()),
filmeId INT NOT NULL

PRIMARY KEY (num)
FOREIGN KEY (filmeId) REFERENCES filme (id)

)
GO

DROP TABLE IF EXISTS estrela 
CREATE TABLE cliente (

numCadastro INT NOT NULL,
nome VARCHAR(70) NOT NULL,
logradouro VARCHAR(150) NOT NULL,
num INT NOT NULL CHECK(num > 0),
cep CHAR(8) NULL,
CONSTRAINT chk_cep CHECK(LEN(cep) = 8),

PRIMARY KEY (numCadastro)

)
GO

DROP TABLE IF EXISTS estrela 
CREATE TABLE estrela (

id INT NOT NULL,
nome VARCHAR(50) NOT NULL

PRIMARY KEY (id)

)
GO

DROP TABLE IF EXISTS filmeEstrela
CREATE TABLE filmeEstrela (

filmeId INT NOT NULL,
estrelaId INT NOT NULL

PRIMARY KEY (filmeId, estrelaId),
FOREIGN KEY (filmeId) REFERENCES filme (id),
FOREIGN KEY (estrelaId) REFERENCES estrela (id)

)
GO

DROP TABLE IF EXISTS locacao 
CREATE TABLE locacao (

dvdNum INT NOT NULL,
clienteNumCadastro INT NOT NULL,
dataLocacao DATE NOT NULL DEFAULT(GETDATE()),
dataDevolucao DATE NOT NULL,
CONSTRAINT chk_datas CHECK(dataDevolucao > dataLocacao),
valor DECIMAL(7,2) NOT NULL CHECK(valor > 0)

PRIMARY KEY (dvdNum, clienteNumCadastro, dataLocacao),
FOREIGN KEY (dvdNum) REFERENCES dvd (num),
FOREIGN KEY (clienteNumCadastro) REFERENCES cliente (numCadastro)

)
GO

ALTER TABLE estrela
ADD nomeReal VARCHAR(50) NULL

ALTER TABLE filme
ALTER COLUMN titulo VARCHAR(80)

INSERT INTO filme VALUES
(1001, 'Whiplash', 2015),
(1002, 'Birdman', 2015),
(1003, 'Interstellar', 2014),
(1004, 'A Culpa é das Estrelas', 2014),
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
(1006, 'Sing', 2016)

INSERT INTO estrela VALUES
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', NULL),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO filmeEstrela VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

INSERT INTO dvd VALUES
(10001, '2020-12-02', 1001),
(10002, '2020-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1001),
(10005, '2020-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1005),
(10008, '2020-10-18', 1002),
(10009, '2020-04-03', 1003)

INSERT INTO cliente VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

INSERT INTO locacao VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

UPDATE cliente
SET cep = '08411150'
WHERE numCadastro = 5503

UPDATE cliente
SET cep = '02918190'
WHERE numCadastro = 5504

UPDATE locacao
SET valor = 3.25
WHERE dataLocacao = '2021-02-18' AND clienteNumCadastro = 5502

UPDATE locacao
SET valor = 3.10
WHERE dataLocacao = '2021-02-24' AND clienteNumCadastro = 5501

UPDATE dvd
SET dataFabric = '2019-07-14'
WHERE num = 10005

UPDATE estrela
SET nomeReal = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

DELETE dvd
WHERE filmeId = '1006'

SELECT titulo FROM filme
WHERE ano = 2014

SELECT id, titulo FROM filme
WHERE titulo = 'Birdman'

SELECT id, titulo FROM filme
WHERE titulo LIKE '%plash%'

SELECT * FROM estrela
WHERE nome LIKE '%Steve%'

SELECT filmeId, dataFabric FROM dvd
WHERE dataFabric = '01-01-2020'

SELECT dvdNum, dataLocacao, dataDevolucao, valor,
CAST(valor + 2.00 AS DECIMAL(7,2)) AS valorMulta FROM locacao
WHERE clienteNumCadastro = 5505

SELECT logradouro, num, cep FROM cliente
WHERE nome = 'Matilde Luz'

SELECT nome FROM estrela
WHERE nome = 'Michael Keaton'

SELECT numCadastro, nome, logradouro + ' ' + CAST(num AS VARCHAR) + ' ' + cep AS endComplemento
FROM cliente
WHERE numCadastro >= 5503