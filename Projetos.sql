USE selectsimple1
GO

IF OBJECT_ID('userHasProjects', 'U') IS NOT NULL DROP TABLE userHasProjects;
IF OBJECT_ID('projects', 'U') IS NOT NULL DROP TABLE projects;
IF OBJECT_ID('users', 'U') IS NOT NULL DROP TABLE users;
GO

CREATE DATABASE selectsimple1 
GO 

USE selectsimple1 
GO 

CREATE TABLE projects (

id INT NOT NULL IDENTITY(10001, 1),
nome VARCHAR(45) NOT NULL, 
descricao VARCHAR(45) NULL, 
dataCriacao DATE NOT NULL CHECK(dataCriacao > '2014-09-01') 
PRIMARY KEY (id) 
)
GO

CREATE TABLE users ( 

id INT NOT NULL IDENTITY(1,1),
nome VARCHAR(45) NOT NULL DEFAULT('123mudar'),
username VARCHAR(45) NOT NULL UNIQUE,
senha VARCHAR(45) NOT NULL, 
email VARCHAR(45) NOT NULL 
PRIMARY KEY (id) 

) 
GO

CREATE TABLE userHasProjects (

usersId INT NOT NULL, 
projectsId INT NOT NULL 
PRIMARY KEY (usersId, projectsId) 
FOREIGN KEY (usersId) REFERENCES users(id),
FOREIGN KEY (projectsId) REFERENCES projects(id) 
)
GO

ALTER TABLE users
ALTER COLUMN username VARCHAR(10)

ALTER TABLE users
ALTER COLUMN senha VARCHAR(8)

INSERT INTO users (nome, username, senha, email) VALUES 
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@icido', 'aparecido@empresa.com')

INSERT INTO projects (nome, descricao, dataCriacao) VALUES 
('Re-folha', 'Refatoração das Folhas', '2014-09-05'), 
('Manutenção PCs', 'Manutenção PCs', '2014-09-06'),
('Auditoria', '', '2014-09-07') 

INSERT INTO userHasProjects VALUES 
('1', '10001'),
('5', '10001'),
('3', '10003'), 
('4', '10002'),
('2', '10002') 

UPDATE projects 
SET dataCriacao = '2014-09-12' 
WHERE nome = 'Manutenção PCs' 

UPDATE users 
SET username = 'Rh_cido' 
WHERE username = 'Rh_apareci' 

UPDATE users 
SET senha = '888@*' 
WHERE username = 'Rh_maria' 

DELETE FROM userHasProjects 
WHERE usersId = '2'

SELECT * FROM users 
SELECT * FROM projects 
SELECT * FROM userHasProjects 
