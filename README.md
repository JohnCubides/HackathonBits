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

```

### Paso 2: Asignar Permisos de Ejecución a los Scripts

Es necesario otorgar permisos de ejecución a los scripts para que puedan ser ejecutados correctamente. Utiliza los siguientes comandos para asignar los permisos:

```sh
chmod +x listDeleteBranch.sh
chmod +x CreatePullRequest/createPullRequest.sh
chmod +x CreatePullRequest/validations.sh
```

## Uso de los Scripts

### 1. Listar y Eliminar Ramas Antiguas

Este script lista todas las ramas del repositorio y elimina las que no están protegidas y no han recibido cambios en los últimos 2 días.

```sh

./listDeleteBranch.sh

```

### 2. Crear un Pull Request Automáticamente

Este script solicita información sobre el pull request y lo crea automáticamente en GitHub.

```sh

./listDeleteBranch.sh

```

Asegúrate de seguir las instrucciones del script para proporcionar un título y una descripción válidos para el pull request.

