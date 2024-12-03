<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="conexao.DatabaseConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Resultados da Pesquisa</title>
        <link rel="stylesheet" href="style.css?v=1.1">
    </head>
    <body>
        <div class="container">
            <h1>Resultados da Pesquisa</h1>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome do Produto</th>
                        <th>Código do Produto (SKU)</th>
                        <th>Categoria</th>
                        <th>Marca</th>
                        <th>Descrição</th>
                        <th>Compatibilidade</th>
                        <th>Estoque</th>
                        <th>Estoque Mínimo</th>
                        <th>Preço de Custo</th>
                        <th>Preço de Venda</th>
                        <th>Código de Barras</th>
                        <th>Fornecedor</th>
                        <th>Data de Cadastro</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String categoria = request.getParameter("categoria");
                        String nomeProduto = request.getParameter("nome_produto");
                        String codigoProduto = request.getParameter("codigo_produto");
                        String marca = request.getParameter("marca");
                        String precoMin = request.getParameter("preco_min");
                        String precoMax = request.getParameter("preco_max");

                        if (categoria != null && !categoria.isEmpty()) {
                            try {
                                Connection conecta = DatabaseConnection.getConnection();
                                String sql = "SELECT * FROM produtos WHERE categoria = ?";
                                if (nomeProduto != null && !nomeProduto.isEmpty()) {
                                    sql += " AND nome_produto LIKE ?";
                                }
                                if (codigoProduto != null && !codigoProduto.isEmpty()) {
                                    sql += " AND codigo_produto = ?";
                                }
                                if (marca != null && !marca.isEmpty()) {
                                    sql += " AND marca LIKE ?";
                                }
                                if (precoMin != null && !precoMin.isEmpty()) {
                                    sql += " AND preco_venda >= ?";
                                }
                                if (precoMax != null && !precoMax.isEmpty()) {
                                    sql += " AND preco_venda <= ?";
                                }

                                PreparedStatement st = conecta.prepareStatement(sql);
                                st.setString(1, categoria);
                                int index = 2;
                                if (nomeProduto != null && !nomeProduto.isEmpty()) {
                                    st.setString(index++, "%" + nomeProduto + "%");
                                }
                                if (codigoProduto != null && !codigoProduto.isEmpty()) {
                                    st.setString(index++, codigoProduto);
                                }
                                if (marca != null && !marca.isEmpty()) {
                                    st.setString(index++, "%" + marca + "%");
                                }
                                if (precoMin != null && !precoMin.isEmpty()) {
                                    st.setBigDecimal(index++, new BigDecimal(precoMin));
                                }
                                if (precoMax != null && !precoMax.isEmpty()) {
                                    st.setBigDecimal(index++, new BigDecimal(precoMax));
                                }

                                ResultSet rs = st.executeQuery();
                                boolean hasResults = false;

                                while (rs.next()) {
                                    hasResults = true;

                                    // Formata a data no padrão brasileiro
                                    Date dataCadastro = rs.getTimestamp("data_cadastro");
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String dataFormatada = sdf.format(dataCadastro);
                    %>
                    <tr>
                        <td><%= rs.getInt("id_produto") %></td>
                        <td><%= rs.getString("nome_produto") %></td>
                        <td><%= rs.getString("codigo_produto") %></td>
                        <td><%= rs.getString("categoria") %></td>
                        <td><%= rs.getString("marca") %></td>
                        <td><%= rs.getString("descricao") %></td>
                        <td><%= rs.getString("compatibilidade") %></td>
                        <td><%= rs.getInt("estoque") %></td>
                        <td><%= rs.getInt("estoque_minimo") %></td>
                        <td><%= rs.getBigDecimal("preco_custo") %></td>
                        <td><%= rs.getBigDecimal("preco_venda") %></td>
                        <td><%= rs.getString("codigo_barras") %></td>
                        <td><%= rs.getString("fornecedor") %></td>
                        <td><%= dataFormatada %></td>
                    </tr>
                    <%
                                }

                                if (!hasResults) {
                    %>
                    <tr>
                        <td colspan="14">Nenhum produto encontrado.</td>
                    </tr>
                    <%
                                }

                                rs.close();
                                st.close();
                                conecta.close();
                            } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="14">Erro: <%= e.getMessage() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="14">Selecione uma categoria para a pesquisa.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <div class="center-container">
                <div>
                    <!-- Botão para voltar à página de produtos -->
                    <a href="produtos.html" class="btn">Voltar para Pesquisa</a>

                </div>
            </div>
        </div>
    </body>
</html>
