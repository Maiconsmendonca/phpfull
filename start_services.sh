#!/bin/bash

# Função para iniciar o serviço PHP com a versão fornecida
start_php_service() {
    php_version="$1"
    # Comando para iniciar o serviço PHP usando o Docker Compose
    docker compose up -d "php${php_version//.}"
}

# Função para finalizar os serviços ativos
stop_active_services() {
    while true; do
        # Verifica se há serviços ativos
        active_containers=$(docker ps --format "{{.Names}}" | sort -u)
        
        if [[ -n $active_containers ]]; then
            echo "Os seguintes serviços estão ativos:"
            # Lista os serviços ativos numerados
            IFS=$'\n' read -rd '' -a services <<< "$active_containers"
            for ((i = 0; i < ${#services[@]}; i++)); do
                echo "$((i+1)). ${services[$i]}"
            done

            # Pergunta ao usuário se deseja finalizar os serviços ativos
            read -rp "Deseja finalizar os serviços ativos? (s/n): " confirm
            if [[ $confirm == "s" ]]; then
                echo "Selecione uma ou mais opções separadas por espaços:"
                echo "0. Finalizar todos os serviços"
                for ((i = 0; i < ${#services[@]}; i++)); do
                    echo "$((i+1)). Finalizar ${services[$i]}"
                done
                echo "x. Cancelar"
                read -rp "Opções: " choices

                # Converte as escolhas em um array
                read -ra choices_array <<< "$choices"

                for choice in "${choices_array[@]}"; do
                    case $choice in
                        0)
                            echo "Finalizando todos os serviços..."
                            docker compose down
                            ;;
                        [1-9])
                            if [[ $choice -le ${#services[@]} ]]; then
                                service_name=${services[$((choice-1))]}
                                echo "Finalizando o serviço $service_name..."
                                docker compose stop "$service_name"
                            else
                                echo "Número de serviço inválido: $choice. Ignorando."
                            fi
                            ;;
                        x|X)
                            echo "Operação cancelada."
                            return 1
                            ;;
                        *) 
                            echo "Opção inválida: $choice. Ignorando."
                            ;;
                    esac
                done
            fi
            break
        else
            echo "Não há serviços ativos."
            break
        fi
    done
}

# Verifica se há serviços ativos antes de iniciar
stop_active_services

# Pergunta se o usuário deseja iniciar um serviço
read -rp "Deseja iniciar um serviço PHP? (s/n): " start_confirm
if [[ $start_confirm != "s" ]]; then
    echo "Obrigado, até em breve."
    exit 0
fi

# Lista de todas as versões do PHP disponíveis
all_php_versions=("5.6" "7.1" "7.3" "8.1" "8.2" "8.3")

# Obtém as versões do PHP que já estão ativas
active_php_versions=($(docker ps --format "{{.Names}}" | grep -oP 'php\d+\.\d+' | grep -oP '\d+\.\d+'))

# Remove as versões ativas da lista de todas as versões disponíveis
available_php_versions=()
for version in "${all_php_versions[@]}"; do
    if [[ ! " ${active_php_versions[@]} " =~ " ${version} " ]]; then
        available_php_versions+=("$version")
    fi
done

# Se não houver versões disponíveis, exibe uma mensagem e sai
if [ ${#available_php_versions[@]} -eq 0 ]; then
    echo "Todas as versões do PHP já estão ativas."
    exit 0
fi

# Loop para exibir o menu até que o usuário forneça uma entrada válida
while true; do
    # Exibe o menu para selecionar as versões do PHP para iniciar
    echo "Escolha as versões do PHP para iniciar (separadas por espaço):"
    for ((i = 0; i < ${#available_php_versions[@]}; i++)); do
        echo "$((i+1)). PHP ${available_php_versions[$i]}"
    done
    echo "x. Cancelar"
    read -rp "Digite os números correspondentes às versões desejadas: " php_choices

    # Converte as escolhas em um array
    read -ra php_choices_array <<< "$php_choices"

    valid_choice=false

    # Mapeia as opções selecionadas para as versões correspondentes do PHP e inicia os serviços
    for php_choice in "${php_choices_array[@]}"; do
        case $php_choice in
            [1-9])
                if [[ $php_choice -le ${#available_php_versions[@]} ]]; then
                    php_version=${available_php_versions[$((php_choice-1))]}
                    start_php_service "$php_version"
                    valid_choice=true
                else
                    echo "Opção inválida: $php_choice. Tente novamente."
                fi
                ;;
            x|X)
                echo "Obrigado, até em breve."
                exit 0
                ;;
            *)
                echo "Opção inválida: $php_choice. Tente novamente."
                ;;
        esac
    done

    if $valid_choice; then
        break
    fi
done

