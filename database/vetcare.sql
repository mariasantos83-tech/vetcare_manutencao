CREATE DATABASE IF NOT EXISTS vetcare_maria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vetcare_;

DROP TABLE IF EXISTS consultas;
DROP TABLE IF EXISTS animais;
DROP TABLE IF EXISTS tutores;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  perfil VARCHAR(20) DEFAULT 'admin'
);

INSERT INTO usuarios (nome, usuario, senha, perfil) VALUES
('Administrador VetCare', 'admin', 'admin123', 'admin');

CREATE TABLE tutores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  telefone VARCHAR(30),
  email VARCHAR(120),
  endereco VARCHAR(180),
  ativo TINYINT(1) DEFAULT 1,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animais (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tutor_id INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  especie VARCHAR(60),
  raca VARCHAR(80),
  nascimento DATE,
  sexo VARCHAR(20),
  observacoes TEXT,
  ativo TINYINT(1) DEFAULT 1,
  CONSTRAINT fk_animal_tutor FOREIGN KEY (tutor_id) REFERENCES tutores(id)
);

CREATE TABLE consultas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  animal_id INT NOT NULL,
  data_consulta DATETIME NOT NULL,
  veterinario VARCHAR(120) NOT NULL,
  motivo VARCHAR(180),
  status VARCHAR(30) DEFAULT 'Agendada',
  observacoes TEXT,
  CONSTRAINT fk_consulta_animal FOREIGN KEY (animal_id) REFERENCES animais(id)
);

INSERT INTO usuario (id, nome, usuario, senha) VALUES
(1, 'Mariana Costa', 'mariana@email.com', '12345'),
(2, 'Rafael Mendes', 'rafael@email.com', '12345',),
(3, 'Camila Oliveira', 'camila@email.com', '12345',),
(4, 'João Pedro Lima', 'joao@email.com', '1245',);

INSERT INTO tutores (nome, telefone, email, endereco, ativo) VALUES
('Mariana Costa', '(47) 99999-1001', 'mariana@email.com', 'Centro', 1),
('Rafael Mendes', '(47) 98888-2002', 'rafael@email.com', 'Bairro Cruzeiro', 1),
('Camila Oliveira', '(47) 97777-3003', 'camila@email.com', 'Serra Alta', 1),
('João Pedro Lima', 'abc123', 'joao@email.com', '25 de Julho', 0);

INSERT INTO animais (tutor_id, nome, especie, raca, nascimento, sexo, observacoes, ativo) VALUES
(1, 'Mel', 'Cão', 'Golden Retriever', '2021-05-10', 'Fêmea', 'Alergia alimentar', 1),
(2, 'Mingau', 'Gato', 'SRD', '2023-11-20', 'Macho', 'Vacinação em dia', 1),
(3, 'Thor', 'Cão', 'Labrador', '2025-10-30', 'Macho', '', 1),
(4, 'Pipoca', 'Coelho', 'Mini Lop', '2024-02-15', 'Fêmea', '', 0);

INSERT INTO consultas (animal_id, data_consulta, veterinario, motivo, status, observacoes) VALUES
(1, DATE_ADD(NOW(), INTERVAL 2 DAY), 'Dra. Paula', 'Retorno dermatológico', 'Agendada', ''),
(2, DATE_SUB(NOW(), INTERVAL 3 DAY), 'Dr. André', 'Avaliação de rotina', 'Realizada', ''),
(3, DATE_ADD(NOW(), INTERVAL 5 DAY), 'Dra. Paula', 'Vacinação', 'Agendada', '');


DROP TABLE IF EXISTS historico_chamados;
DROP TABLE IF EXISTS chamados;

CREATE TABLE chamados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(160) NOT NULL,
  modulo VARCHAR(60) NOT NULL,
  solicitante VARCHAR(120) NOT NULL,
  equipe VARCHAR(100),
  descricao TEXT NOT NULL,
  passos TEXT NOT NULL,
  resultado_esperado TEXT NOT NULL,
  resultado_obtido TEXT NOT NULL,
  severidade ENUM('Baixa','Média','Alta','Crítica') NOT NULL DEFAULT 'Média',
  prioridade ENUM('Baixa','Média','Alta','Urgente') NOT NULL DEFAULT 'Média',
  status ENUM('Aberto','Em análise','Aguardando informações','Resolvido','Fechado') NOT NULL DEFAULT 'Aberto',
  responsavel VARCHAR(120),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE historico_chamados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  chamado_id INT NOT NULL,
  autor VARCHAR(120) NOT NULL,
  comentario TEXT NOT NULL,
  status_anterior VARCHAR(40),
  status_novo VARCHAR(40),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_historico_chamado FOREIGN KEY (chamado_id) REFERENCES chamados(id) ON DELETE CASCADE
);
