
# JR Auto Center

Sistema de gestão para oficinas automotivas, desenvolvido para facilitar o cadastro de clientes e produtos, realizar pesquisas avançadas e exibir resultados organizados.

## Funcionalidades

- **Cadastro de Clientes:** Permite adicionar clientes com validação de dados e verificação de duplicidade.
- **Cadastro de Produtos:** Inclusão de produtos com categorias, descrição, estoque, preços, e fornecedor.
- **Pesquisa Avançada:** Filtros por categoria, preço, marca, e outros critérios, exibindo resultados em tabelas formatadas.
- **Integração com Banco de Dados:** Utiliza MySQL para armazenamento e recuperação de informações.
- **Interface Responsiva:** Desenvolvido com HTML e CSS para uma experiência fluida e profissional.

## Tecnologias Utilizadas

- **Linguagens:** JSP, Java, HTML, CSS
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

## Configuração do Ambiente

1. **Clonar o Repositório:**
   ```bash
   git clone https://github.com/cortonezi/jr-auto-center.git
   cd jr-auto-center
   ```

2. **Configuração do Banco de Dados:**
   - Crie um banco de dados MySQL chamado `autocenterdb` e importe o arquivo SQL:
     ```sql
     o arquivo está incluido na pasta do projeto dentro da pasta 'Script'
     ```

3. **Configuração do Servidor Tomcat no NetBeans:**
   - Certifique-se de que o Apache Tomcat está instalado e configurado no NetBeans.
   - Adicione o projeto ao servidor e configure as portas.

4. **Execução do Projeto:**
   - No NetBeans, clique em `Run` para iniciar o servidor e abrir o projeto no navegador.

5. **Credenciais do Banco de Dados:**
   - O projeto está configurado para conectar-se ao banco de dados local com as credenciais:
     ```
     Host: localhost
     Usuário: root
     Senha: ******
     ```
   - Ajuste as configurações em `DatabaseConnection.java` caso necessário.


## Plano de Testes

Consulte o plano de testes detalhado no arquivo `Plano_de_Testes.pdf` incluído na pasta do projeto. Ele contém os casos de teste realizados e os resultados obtidos.


## Autor

Rafael Cortonezi
