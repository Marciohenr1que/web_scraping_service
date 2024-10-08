# Web Scraping Services

Este projeto é uma aplicação de web scraping desenvolvida em Ruby on Rails. Utiliza Selenium e Nokogiri para realizar scraping de dados de páginas da web e armazena as informações em um banco de dados PostgreSQL. O projeto segue a arquitetura hexagonal, com comunicação via gRPC e é executado dentro de um contêiner Docker.

Comando principal 
- bundle install
- Rodar
- rails s -p 3001 
- lembrando verificar cors  ele aceita requisiçoes vindas do origins 'http://localhost:5173' front-end

## Visão Geral

A aplicação é projetada para:

- Realizar scraping de dados de páginas web usando Selenium e Nokogiri.
- Armazenar dados extraídos em um banco de dados PostgreSQL.
- Enviar notificações via gRPC após a conclusão do scraping.
- Simular interações humanas para evitar bloqueios de scraping.

## Funcionalidades

- Configuração de User-Agent para simular bots de busca.
- Interações humanas simuladas com redimensionamento e movimento da janela do navegador.
- Extração e formatação de dados específicos da página.
- Envio de notificações após a conclusão do scraping.

## Pré-requisitos

- Ruby 3.1 ou superior
- Rails 7.x
- PostgreSQL
- Docker (opcional, para executar a aplicação em um contêiner)
- Selenium WebDriver
- Nokogiri
- gRPC gem

## Instalação

### Clonando o Repositório

```bash
git clone git clone https://github.com/seu_usuario/seu_repositorio.git](https://github.com/Marciohenr1que/web_scraping_service
cd seu_repositorio
Configuração do Ambiente
Instale as dependências do Ruby:

bash
Copiar código
bundle install
Configure o banco de dados PostgreSQL:

Edite o arquivo config/database.yml com suas configurações do PostgreSQL.

Crie e migre o banco de dados:

bash
Copiar código
rails db:create
rails db:migrate
Configuração do Docker (opcional):
docker-compose build
Se estiver usando Docker, você pode configurar e iniciar o contêiner com:

bash
Copiar código
docker-compose up
Execução da Aplicação
Para iniciar o servidor Rails, use o seguinte comando:

bash
Copiar código
rails s -p 3001
Certifique-se de que as configurações de CORS estão configuradas corretamente para permitir solicitações da sua aplicação.

Testes
Para rodar os testes, use:

bash
Copiar código
rails test
cd seu_repositorio
Configuração do Ambiente
Instale as dependências do Ruby:

bash
Copiar código
bundle install
Configure o banco de dados PostgreSQL:

Edite o arquivo config/database.yml com suas configurações do PostgreSQL.

Crie e migre o banco de dados:

bash
Copiar código
rails db:create
rails db:migrate
Configuração do Docker (opcional):

Se estiver usando Docker, você pode configurar e iniciar o contêiner com:

bash
Copiar código
docker-compose up
Execução da Aplicação
Para iniciar o servidor Rails, use o seguinte comando:

bash
Copiar código
rails s -p 3001
Certifique-se de que as configurações de CORS estão configuradas corretamente para permitir solicitações da sua aplicação.

Testes
Para rodar os testes, use:

bash
Copiar código
rails test
