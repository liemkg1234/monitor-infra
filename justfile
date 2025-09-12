set dotenv-load
export PROJECT_NAME := env("PROJECT_NAME", "monitor-infra")
export ENV := env("ENV", "dev")

export GF_SECURITY_ADMIN_USER := env("GF_SECURITY_ADMIN_USER", "admin")
export GF_SECURITY_ADMIN_PASSWORD := env("GF_SECURITY_ADMIN_PASSWORD", "admin")


## Docker Environment
DOCKER_NETWORK_NAME := "$PROJECT_NAME-$ENV-net"

default:
    just help

# Export env.docker
export-env-docker:
    rm -rf .env.docker
    echo "# Networks" >> .env.docker
    echo "DOCKER_NETWORK_NAME={{DOCKER_NETWORK_NAME}}" >> .env.docker

# Export to .env
environment: export-env-docker
    cp .env.example .env

htpasswd:
    sudo apt install -y apache2-utils
    htpasswd -c -b -B ./config/.htpasswd {{GF_SECURITY_ADMIN_USER}} {{GF_SECURITY_ADMIN_PASSWORD}}

stop: export-env-docker htpasswd
    docker compose --env-file .env.docker --env-file .env \
        -p {{PROJECT_NAME}}-{{ENV}} \
        -f docker-compose.yml \
        down

start: stop
    @echo "Starting PROJECT '{{PROJECT_NAME}}' with ENVIRONMENT: {{ENV}}"
    docker compose --env-file .env.docker --env-file .env \
        -p {{PROJECT_NAME}}-{{ENV}} \
        -f docker-compose.yml \
        up -d \
        --build --force-recreate

## Helper
help:
    @echo "just environment     Setup .env file"
    @echo "just start           Start servers with docker"
    @echo "just stop            Stop servers"
