<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="conexao.DatabaseConnection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Clientes</title>
        <!-- Link para o arquivo CSS externo -->
        <link rel="stylesheet" href="style.css?v=1.4">
    </head>
    <body>
        <%
            // Inicializa as variáveis de controle
            boolean cadastroSucesso = false;
            String nome = request.getParameter("nome");
            
            String cpf = request.getParameter("cpf");
            cpf = cpf.replaceAll("(\\d{3})(\\d{3})(\\d{3})(\\d{2})", "$1.$2.$3-$4");

            
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            String endereco = request.getParameter("endereco");
            String observacao = request.getParameter("observacao");

            String cpfError = null;
            String emailError = null;

            if (nome != null && cpf != null && email != null) {
                try {
                    Connection conecta = DatabaseConnection.getConnection();

                    // Verifica duplicidade
                    String checkSql = "SELECT * FROM clientes WHERE cpf = ? OR email = ?";
                    PreparedStatement checkSt = conecta.prepareStatement(checkSql);
                    checkSt.setString(1, cpf);
                    checkSt.setString(2, email);
                    ResultSet rs = checkSt.executeQuery();

                    boolean isDuplicate = false;

                    while (rs.next()) {
                        if (rs.getString("cpf").equals(cpf)) {
                            cpfError = "CPF já cadastrado.";
                            isDuplicate = true;
                        }
                        if (rs.getString("email").equals(email)) {
                            emailError = "Email já cadastrado.";
                            isDuplicate = true;
                        }
                    }

                    if (!isDuplicate) {
                        String sql = "INSERT INTO clientes (nome, cpf, telefone, email, endereco, observacao) VALUES (?, ?, ?, ?, ?, ?)";
                        PreparedStatement st = conecta.prepareStatement(sql);
                        st.setString(1, nome);
                        st.setString(2, cpf);
                        st.setString(3, telefone);
                        st.setString(4, email);
                        st.setString(5, endereco);
                        st.setString(6, observacao);

                        int rowsInserted = st.executeUpdate();
                        if (rowsInserted > 0) {
                            cadastroSucesso = true;
                        }
                        st.close();
                    }

                    checkSt.close();
                    conecta.close();
                } catch (Exception e) {
                    e.printStackTrace();
        %>
        <h3>Erro: <%= e.getMessage() %></h3>
        <%
                }
            }
        %>

        <% if (cadastroSucesso) { %>
        <div class="center-container">
            <h1>Cliente cadastrado com sucesso!</h1>
            <div>
                <a href="cadastroCliente.html" class="btn">Cadastrar novo cliente</a>
                <a href="paginaInicial.html" class="btn">Voltar à página inicial</a>
            </div>
        </div>

        <% } else { %>
        <!-- Formulário de cadastro -->
        <form method="post" action="">
            <h1>Cadastro de Clientes</h1>
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" name="nome" id="nome" value="<%= nome != null ? nome : "" %>">
            </div>
            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" name="cpf" id="cpf" value="<%= cpf != null ? cpf : "" %>">
                <% if (cpfError != null) { %>
                <div class="error"><%= cpfError %></div>
                <% } %>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" value="<%= email != null ? email : "" %>">
                <% if (emailError != null) { %>
                <div class="error"><%= emailError %></div>
                <% } %>
            </div>
            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" name="telefone" id="telefone" value="<%= telefone != null ? telefone : "" %>">
            </div>
            <div class="form-group" style="grid-column: 1 / -1;">
                <label for="endereco">Endereço:</label>
                <input type="text" name="endereco" id="endereco" value="<%= endereco != null ? endereco : "" %>">
                <div class="error"></div> <!-- Mensagem de erro reservada -->
            </div>
            <div class="form-group" style="grid-column: 1 / -1;">
                <label for="observacao">Observação:</label>
                <input type="text" name="observacao" id="observacao" value="<%= observacao != null ? observacao : "" %>">
                <div class="error"></div> <!-- Mensagem de erro reservada -->
            </div>



            <button type="submit" class="btn">Cadastrar</button>
        </form>
        <% } %>
    </body>
</html>
