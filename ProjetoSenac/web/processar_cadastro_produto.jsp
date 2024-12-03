<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="conexao.DatabaseConnection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Produto</title>
        <link rel="stylesheet" href="style.css?v=1.5">
    </head>
    <body>
        <%
            // Inicializa variáveis de controle
            boolean cadastroSucesso = false;
            String nomeProduto = request.getParameter("nome_produto");
            String codigoProduto = request.getParameter("codigo_produto");
            String categoria = request.getParameter("categoria");
            String marca = request.getParameter("marca");
            String descricao = request.getParameter("descricao");
            String compatibilidade = request.getParameter("compatibilidade");
            String estoqueStr = request.getParameter("estoque");
            String estoqueMinimoStr = request.getParameter("estoque_minimo");
            String precoCustoStr = request.getParameter("preco_custo");
            String precoVendaStr = request.getParameter("preco_venda");
            String codigoBarras = request.getParameter("codigo_barras");
            String fornecedor = request.getParameter("fornecedor");

            String codigoProdutoError = null;
            String codigoBarrasError = null;

            if (nomeProduto != null && codigoProduto != null && categoria != null) {
                try {
                    Connection conecta = DatabaseConnection.getConnection();

                    // Verifica duplicidade
                    String checkSql = "SELECT * FROM produtos WHERE codigo_produto = ? OR codigo_barras = ?";
                    PreparedStatement checkSt = conecta.prepareStatement(checkSql);
                    checkSt.setString(1, codigoProduto);
                    checkSt.setString(2, codigoBarras);
                    ResultSet rs = checkSt.executeQuery();

                    boolean isDuplicate = false;

                    while (rs.next()) {
                        if (rs.getString("codigo_produto").equals(codigoProduto)) {
                            codigoProdutoError = "Código do Produto já cadastrado.";
                            isDuplicate = true;
                        }
                        if (codigoBarras != null && rs.getString("codigo_barras").equals(codigoBarras)) {
                            codigoBarrasError = "Código de Barras já cadastrado.";
                            isDuplicate = true;
                        }
                    }

                    if (!isDuplicate) {
                        String sql = "INSERT INTO produtos (nome_produto, codigo_produto, categoria, marca, descricao, compatibilidade, estoque, estoque_minimo, preco_custo, preco_venda, codigo_barras, fornecedor) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        PreparedStatement st = conecta.prepareStatement(sql);
                        st.setString(1, nomeProduto);
                        st.setString(2, codigoProduto);
                        st.setString(3, categoria);
                        st.setString(4, marca);
                        st.setString(5, descricao);
                        st.setString(6, compatibilidade);
                        st.setInt(7, Integer.parseInt(estoqueStr));
                        st.setInt(8, Integer.parseInt(estoqueMinimoStr));
                        st.setBigDecimal(9, new java.math.BigDecimal(precoCustoStr));
                        st.setBigDecimal(10, new java.math.BigDecimal(precoVendaStr));
                        st.setString(11, codigoBarras);
                        st.setString(12, fornecedor);

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
        <!-- Mensagem de sucesso -->
        
        <div class="center-container">
            <h1>Produto cadastrado com sucesso!</h1>
            <div>
                <a href="cadastroProduto.html" class="btn">Cadastrar Novo Produto</a>
                <a href="paginaInicial.html" class="btn">Voltar à página inicial</a>
            </div>
        </div>
        
        
        
        
        <% } else { %>
        <!-- Exibe formulário com erros -->
        <form action="processar_cadastro_produto.jsp" method="post">
    <h1>Cadastro de Produtos</h1>

    <!-- Nome do Produto -->
    <div>
        <label for="nome_produto">Nome do Produto</label>
        <input type="text" id="nome_produto" name="nome_produto" value="<%= nomeProduto != null ? nomeProduto : "" %>" required>
    </div>

    <!-- Código do Produto -->
    <div>
        <label for="codigo_produto">Código do Produto (SKU)</label>
        <input type="text" id="codigo_produto" name="codigo_produto" value="<%= codigoProduto != null ? codigoProduto : "" %>" required>
        <% if (codigoProdutoError != null) { %>
        <div class="error"><%= codigoProdutoError %></div>
        <% } %>
    </div>

    <!-- Categoria -->
    <div>
        <label for="categoria">Categoria</label>
        <select id="categoria" name="categoria" required>
            <option value="">Selecione uma categoria</option>
            <option value="oleos" <%= "oleos".equals(categoria) ? "selected" : "" %>>Óleos e Lubrificantes</option>
            <option value="pneus" <%= "pneus".equals(categoria) ? "selected" : "" %>>Pneus</option>
            <option value="baterias" <%= "baterias".equals(categoria) ? "selected" : "" %>>Baterias</option>
            <option value="filtros" <%= "filtros".equals(categoria) ? "selected" : "" %>>Filtros</option>
            <option value="acessorios" <%= "acessorios".equals(categoria) ? "selected" : "" %>>Acessórios</option>
        </select>
    </div>

    <!-- Marca -->
    <div>
        <label for="marca">Marca</label>
        <input type="text" id="marca" name="marca" value="<%= marca != null ? marca : "" %>" required>
    </div>

    <!-- Descrição -->
    <div style="grid-column: 1 / -1;">
        <label for="descricao">Descrição</label>
        <textarea id="descricao" name="descricao" required><%= descricao != null ? descricao : "" %></textarea>
    </div>

    <!-- Compatibilidade -->
    <div style="grid-column: 1 / -1;">
        <label for="compatibilidade">Compatibilidade</label>
        <textarea id="compatibilidade" name="compatibilidade"><%= compatibilidade != null ? compatibilidade : "" %></textarea>
    </div>

    <!-- Quantidade em Estoque -->
    <div>
        <label for="estoque">Quantidade em Estoque</label>
        <input type="number" id="estoque" name="estoque" value="<%= estoqueStr != null ? estoqueStr : "" %>" required>
    </div>

    <!-- Estoque Mínimo -->
    <div>
        <label for="estoque_minimo">Estoque Mínimo</label>
        <input type="number" id="estoque_minimo" name="estoque_minimo" value="<%= estoqueMinimoStr != null ? estoqueMinimoStr : "" %>" required>
    </div>

    <!-- Preço de Custo -->
    <div>
        <label for="preco_custo">Preço de Custo (R$)</label>
        <input type="number" id="preco_custo" name="preco_custo" value="<%= precoCustoStr != null ? precoCustoStr : "" %>" step="0.01" required>
    </div>

    <!-- Preço de Venda -->
    <div>
        <label for="preco_venda">Preço de Venda (R$)</label>
        <input type="number" id="preco_venda" name="preco_venda" value="<%= precoVendaStr != null ? precoVendaStr : "" %>" step="0.01" required>
    </div>

    <!-- Código de Barras -->
    <div>
        <label for="codigo_barras">Código de Barras</label>
        <input type="text" id="codigo_barras" name="codigo_barras" value="<%= codigoBarras != null ? codigoBarras : "" %>">
        <% if (codigoBarrasError != null) { %>
        <div class="error"><%= codigoBarrasError %></div>
        <% } %>
    </div>

    <!-- Fornecedor -->
    <div>
        <label for="fornecedor">Fornecedor</label>
        <input type="text" id="fornecedor" name="fornecedor" value="<%= fornecedor != null ? fornecedor : "" %>">
    </div>

    <!-- Botão de Enviar -->
    <button type="submit">Cadastrar Produto</button>
</form>

        <% } %>
    </body>
</html>
