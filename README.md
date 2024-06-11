# Projeto Docker para Gerenciamento de Serviços PHP

Este é um projeto Docker para facilitar o gerenciamento de vários serviços PHP em diferentes versões usando Docker Compose. Ele permite iniciar, parar e reiniciar serviços PHP com facilidade, além de oferecer opções para selecionar as versões do PHP desejadas.

## Como Funciona

### Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Estrutura do Projeto

```
├── docker-compose.yml
├── Dockerfile
├── start_services.sh
└── README.md
```

- **docker-compose.yml**: Arquivo de configuração do Docker Compose que define os serviços PHP e suas configurações.
- **Dockerfile**: Arquivo Dockerfile para construir a imagem do ambiente PHP.
- **start_services.sh**: Script Bash para iniciar e parar serviços PHP.

### Configuração

1. **Clone este repositório em sua máquina local**:

    ```bash
    git clone https://github.com/Maiconsmendonca/phpfull.git
    ```

2. **Navegue até o diretório do projeto**:

    ```bash
    cd phpfull
    ```

3. **Configure as versões do PHP desejadas** no arquivo `docker-compose.yml`.

### Utilização

1. **Para iniciar serviços PHP**:

    ```bash
    ./start_services.sh
    ```

2. Siga as instruções para selecionar as versões do PHP desejadas.

3. **Para parar serviços PHP**:

    ```bash
    ./start_services.sh
    ```

4. Selecione os serviços que deseja parar e siga as instruções.

## Personalização

Você pode personalizar este projeto de acordo com suas necessidades:

- **Adicionar novas versões do PHP**: Edite o arquivo `docker-compose.yml` para adicionar ou remover serviços PHP com diferentes versões.

- **Modificar opções de configuração**: Personalize o arquivo `start_services.sh` para adicionar novos recursos ou ajustar o comportamento conforme necessário.

## Contribuindo

Se você encontrar problemas ou tiver sugestões de melhorias, sinta-se à vontade para abrir uma [issue](https://github.com/seu-usuario/nome-do-repositorio/issues) ou enviar um [pull request](https://github.com/seu-usuario/nome-do-repositorio/pulls).

## Licença

Este projeto é licenciado sob a Licença [MIT](https://opensource.org/licenses/MIT).
