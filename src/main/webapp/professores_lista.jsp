<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professores Cadastrados</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 950px;">
        <h1>Professores Cadastrados</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Nascimento</th>
                    <th>Naturalidade</th>
                    <th>Sexo</th>
                    <th>Lattes</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prof" items="${professores}">
                    <tr>
                        <td>${prof.id}</td>
                        <td><strong>${prof.nome}</strong></td>
                        <td>${prof.dataNascimento}</td>
                        <td>${prof.naturalidade}</td>
                        <td>${prof.sexo}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty prof.linkLattes}">
                                    <a href="${prof.linkLattes}" target="_blank" class="btn btn-sm btn-secondary">Ver Lattes</a>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="professores?action=excluir&id=${prof.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Deseja realmente excluir o(a) professor(a) ${prof.nome}?');">
                               Excluir
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="footer-nav">
            <a href="cadastro_professor.jsp" class="btn">Novo Professor</a>
            <a href="index.jsp" class="btn btn-secondary">Início</a>
            <a href="alunos" class="btn btn-secondary">Ir para Alunos</a>
        </div>
    </div>
</body>
</html>
