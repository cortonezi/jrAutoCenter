# JR Auto Center

Sistema de gestão para oficinas automotivas, desenvolvido para facilitar o cadastro de clientes e produtos, realizar pesquisas avançadas e exibir resultados organizados.

## Funcionalidades
- **Cadastro de Clientes:** Permite adicionar clientes com validação de dados e verificação de duplicidade.
- **Cadastro de Produtos:** Inclusão de produtos com categorias, descrição, estoque, preços, e fornecedor.
- **Pesquisa Avançada:** Filtros por categoria, preço, marca, e outros critérios, exibindo resultados em tabelas formatadas.
- **Integração com Banco de Dados:** Utiliza MySQL para armazenamento e recuperação de informações.
- **Interface Responsiva:** Desenvolvido com HTML e CSS para uma experiência fluida e profissional.

## Tecnologias Utilizadas
- **Linguagens:** JSP, Java, HTML5, CSS3
- **Banco de Dados:** MySQL
- **Servidor Web:** Apache Tomcat
- **Ferramentas:** NetBeans IDE, MySQL Workbench

## Estrutura do Projeto
- **`index.html`:** Página inicial com navegação principal.
- **`cadastroCliente.html`:** Formulário para cadastro de clientes.
- **`cadastroProduto.html`:** Formulário para cadastro de produtos.
- **`processar_cadastro.jsp`:** Lógica de backend para o cadastro de clientes.
- **`processar_cadastro_produto.jsp`:** Lógica de backend para o cadastro de produtos.
- **`produtos.jsp`:** Página para pesquisa e exibição de produtos.
- **`DatabaseConnection.java`:** Classe para conexão com o banco de dados.

## Configuração
1. Clone o repositório:
   ```bash
   git clone https://github.com/cortonezi/jr-auto-center.git
