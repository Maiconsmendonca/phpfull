# Use uma imagem base que contenha os requisitos necessários para instalar as versões específicas do PHP
FROM debian:buster

# Instale dependências necessárias para o PHP e Xdebug
RUN apt-get update && \
    apt-get install -y \
    gnupg2 \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    wget \
    curl \
    software-properties-common \
    autoconf \
    gcc \
    make \
    g++ \
    pkg-config \
    libc-dev \
    zlib1g-dev \
    libxml2-dev \
    libssl-dev \
    libonig-dev \
    libzip-dev \
    php-pear \
    && rm -rf /var/lib/apt/lists/*

# Adicione o repositório para instalar o PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# Instale várias versões do PHP
RUN apt-get update && \
    apt-get install -y \
    php5.6 \
    php7.1 \
    php7.3 \
    php8.1 \
    php8.2 \
    php8.3 \
    && rm -rf /var/lib/apt/lists/*

# Instale o Xdebug apenas para o PHP 5.6
# RUN if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
#     pecl install xdebug-2.5.5; \
#     else \
#     pecl install xdebug; \
#     fi && \
#     docker-php-ext-enable xdebug

# Copie o script de inicialização do PHP
COPY start_services.sh /usr/local/bin/

# Defina qualquer configuração adicional necessária para o PHP

# Defina qualquer outro comando de inicialização ou configuração necessária para seus contêineres

# Exemplo de comando CMD para manter o contêiner em execução (substitua conforme necessário)
CMD ["tail", "-f", "/dev/null"]

