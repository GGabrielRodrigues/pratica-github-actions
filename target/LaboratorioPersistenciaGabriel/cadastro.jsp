<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Aluno</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Cadastro de Aluno</h1>
        <form action="alunos" method="post">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required placeholder="Nome do aluno">
            </div>

            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" required placeholder="aluno@email.com">
            </div>

            <div class="form-group">
                <label for="curso">Curso:</label>
                <input type="text" id="curso" name="curso" required placeholder="Ex.: Engenharia de Software">
            </div>

            <button type="submit" class="btn">Cadastrar</button>
        </form>

        <div class="footer-nav">
            <a href="index.jsp" class="btn btn-secondary">Início</a>
            <a href="alunos" class="btn btn-secondary">Listar Alunos</a>
        </div>
    </div>
</body>
</html>
