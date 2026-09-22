<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alunos Cadastrados</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Alunos Cadastrados</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>E-mail</th>
                    <th>Curso</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="aluno" items="${alunos}">
                    <tr>
                        <td>${aluno.id}</td>
                        <td><strong>${aluno.nome}</strong></td>
                        <td>${aluno.email}</td>
                        <td>${aluno.curso}</td>
                        <td>
                            <a href="alunos?action=excluir&id=${aluno.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Tem certeza que deseja excluir o aluno ${aluno.nome}?');">
                               Excluir
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="footer-nav">
            <a href="cadastro.jsp" class="btn">Novo Aluno</a>
            <a href="index.jsp" class="btn btn-secondary">Início</a>
            <a href="professores" class="btn btn-secondary">Ir para Professores</a>
        </div>
    </div>
</body>
</html>
