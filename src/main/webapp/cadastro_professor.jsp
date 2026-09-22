<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Professor</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Cadastro de Professor</h1>
        <form action="professores" method="post">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" maxlength="60" required placeholder="Nome completo do professor">
            </div>

            <div class="form-group">
                <label for="dataNascimento">Data de Nascimento:</label>
                <input type="date" id="dataNascimento" name="dataNascimento" required>
            </div>

            <div class="form-group">
                <label for="naturalidade">Naturalidade (Cidade onde nasceu):</label>
                <input type="text" id="naturalidade" name="naturalidade" maxlength="40" required placeholder="Ex.: São Paulo">
            </div>

            <div class="form-group">
                <label for="sexo">Sexo:</label>
                <select id="sexo" name="sexo" required>
                    <option value="">Selecione...</option>
                    <option value="M">Masculino (M)</option>
                    <option value="F">Feminino (F)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="linkLattes">Link Currículo Lattes:</label>
                <input type="text" id="linkLattes" name="linkLattes" maxlength="100" placeholder="http://lattes.cnpq.br/...">
            </div>

            <button type="submit" class="btn">Cadastrar Professor</button>
        </form>

        <div class="footer-nav">
            <a href="index.jsp" class="btn btn-secondary">Início</a>
            <a href="professores" class="btn btn-secondary">Listar Professores</a>
        </div>
    </div>
</body>
</html>
