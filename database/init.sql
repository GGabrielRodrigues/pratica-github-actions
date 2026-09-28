-- Script de inicialização do banco de dados PostgreSQL
-- Criação das tabelas de Aluno e Professor

CREATE TABLE IF NOT EXISTS aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    curso VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS professor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    naturalidade VARCHAR(100),
    sexo VARCHAR(20),
    link_lattes VARCHAR(255)
);

-- Inserção de dados iniciais para testes/demonstração
INSERT INTO aluno (nome, email, curso) VALUES 
('Gabriel Rodrigues', 'gabriel@faculdade.edu.br', 'Engenharia de Software'),
('Ana Paula Souza', 'ana.souza@faculdade.edu.br', 'Ciência da Computação')
ON CONFLICT DO NOTHING;

INSERT INTO professor (nome, data_nascimento, naturalidade, sexo, link_lattes) VALUES 
('Carlos Eduardo', '1980-03-15', 'São Paulo', 'M', 'http://lattes.cnpq.br/1111222233334444'),
('Mariana Ferreira', '1985-07-22', 'Belo Horizonte', 'F', 'http://lattes.cnpq.br/5555666677778888')
ON CONFLICT DO NOTHING;
