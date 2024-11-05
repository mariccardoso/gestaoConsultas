
CREATE DATABASE gestao-consultas;

-- Criação da tabelas pacientes. Com os campos id_paciente, nome, cpf, data_nascimento e email para armazenar as informações dos pacientes.
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL
)

-- Criação da tabela medicos. Com os campos id_medico, nome, crm e especialidade para armazenar as informações dos médicos.
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(7) UNIQUE NOT NULL, -- Conselho Regional de Medicina
    especialidade VARCHAR(100) NOT NULL
);

-- Criação da tabela auxiliar consultas. Com os campos id_consulta, id_paciente, id_medico, data_consulta e hora_consulta para armazenar as informações das consultas e relacionar os pacientes e médicos.
CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    data_consulta DATE  NOT NULL,
    hora_consulta TIME NOT NULL,

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
)

-- Inserções de dados nas tabelas pacientes e medicos.
INSERT INTO pacientes (nome, cpf, data_nascimento, email) VALUES
('Ana Silva', '12345678901', '1980-01-01', 'ana.silva@gmail.com'),
('Bruno Souza', '23456789012', '1985-02-02', 'bruno.souza@gmail.com'),
('Carlos Pereira', '34567890123', '1990-03-03', 'carlos.pereira@gmail.com'),
('Daniela Costa', '45678901234', '1995-04-04', 'daniela.costa@gmail.com'),
('Mariana Cardoso', '56789012345', '2000-05-05', 'mariana.cardoso@gmail.com'),
('Thiago Ferreira', '67890123456', '2005-06-06', 'thiago.ferreira@gmail.com'),
('Vanessa Oliveira', '78901234567', '2010-07-07', 'vanessa@gmail.com'),
('Maria Eduarda Reis', '89012345678', '2015-08-08', 'maria.reis@gmail.com'),
('Anna Fiochi', '90123456789', '2020-09-09', 'annafiochi@gmail.com');

SELECT * FROM pacientes; -- Verificar se os dados foram inseridos corretamente.

INSERT INTO medicos (nome, crm, especialidade) VALUES
('Dr. Carlos', '1234567', 'Cardiologista'),
('Dr. João', '2345678', 'Ortopedista'),
('Dr. Maria', '3456789', 'Pediatra'),
('Dr. Ana', '4567890', 'Ginecologista'),
('Dr. José', '5678901', 'Dermatologista'),
('Dr. Luiz', '6789012', 'Oftalmologista'),
('Dr. Paula', '7890123', 'Endocrinologista'),
('Dr. Renata', '8901234', 'Neurologista'),
('Dr. Felipe Dev', '9012345', 'Urologista');

SELECT * FROM medicos; -- Verificar se os dados foram inseridos corretamente.

--Consultas com médicos e pacientes
INSERT INTO consultas (id_paciente, id_medico, data_consulta, hora_consulta) VALUES
(1, 2, '2024-01-01', '08:00'),
(3, 4, '2024-02-02', '09:00'),
(5, 6, '2024-05-03', '10:00'),
(6, 5, '2024-07-07', '14:00'),
(4, 3, '2024-08-08', '16:00');


SELECT * FROM consultas; -- Verificar se os dados foram inseridos corretamente.

-- Atividade 01 - Consultas com médicos e pacientes
SELECT p.id_paciente, p.nome, p.cpf, c.data_consulta, c.hora_consulta, m.nome, m.especialidade
FROM pacientes p
JOIN consultas c ON p.id_paciente = c.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;

-- Atividade 02 - Consultas pacientes sem consulta
SELECT p.id_paciente, p.nome, p.cpf, c.data_consulta
FROM pacientes p
LEFT JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE data_consulta IS NULL;

-- Atividade 03 - Consultas médicos sem consulta
SELECT m.nome, m.especialidade, c.data_consulta
FROM medicos m
LEFT JOIN consultas c ON m.id_medico = c.id_medico
WHERE data_consulta IS NULL;

