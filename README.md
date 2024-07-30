# Proyecto de Gestión de Ramas y Pull Requests en GitHub

Este proyecto incluye scripts para listar y eliminar ramas antiguas de un repositorio de GitHub, así como para crear pull requests automáticamente.

## Configuración Inicial

Antes de ejecutar los scripts, asegúrate de configurar tus credenciales de GitHub en el archivo `set_env.sh`.

### Paso 1: Configurar `set_env.sh`

Abre el archivo `set_env.sh` y completa los datos necesarios:

```sh
# set_env.sh

# Token de acceso personal de GitHub
export GITHUB_TOKEN="tu_token_de_github"

# Nombre de usuario de GitHub
export GITHUB_USERNAME="tu_usuario_de_github"

# Nombre del repositorio en GitHub
export GITHUB_REPO="nombre_de_tu_repositorio"

# URL de la API de GitHub
export GITHUB_API_URL="https://api.github.com"
