<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laboratório de Persistência</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Sistema Universitário — Persistência de Dados</h1>
        
        <div class="card-grid">
            <div class="card">
                <h2>Gestão de Alunos</h2>
                <p style="color: var(--text-muted); margin-bottom: 1.25rem;">
                    Cadastro, consulta e exclusão de alunos no PostgreSQL.
                </p>
                <div style="display: flex; gap: 0.75rem; justify-content: center;">
                    <a href="cadastro.jsp" class="btn">Cadastrar Aluno</a>
                    <a href="alunos" class="btn btn-secondary">Listar Alunos</a>
                </div>
            </div>

            <div class="card">
                <h2>Gestão de Professores</h2>
                <p style="color: var(--text-muted); margin-bottom: 1.25rem;">
                    Cadastro, consulta e exclusão de professores (Conceito 24).
                </p>
                <div style="display: flex; gap: 0.75rem; justify-content: center;">
                    <a href="cadastro_professor.jsp" class="btn">Cadastrar Professor</a>
                    <a href="professores" class="btn btn-secondary">Listar Professores</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
