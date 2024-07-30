#!/bin/bash

# Incluir el archivo que exporta variables
source ./set_env.sh

# Configuración
OUTPUT_FILE="branch_info.txt"

# Realizar la solicitud para obtener las ramas
branches=$(curl -k -s -H "Authorization: $GITHUB_TOKEN" "$GITHUB_API_URL/repos/$GITHUB_USERNAME/$GITHUB_REPO/branches")

# Limpiar el archivo de salida
> $OUTPUT_FILE

# Obtener la fecha actual en formato Unix timestamp
current_date=$(date +%s)

# Iterar sobre las ramas
echo "$branches" | jq -c '.[]' | while read branch; do
  branch_name=$(echo $branch | jq -r '.name')
  encoded_branch_name=$(echo "$branch_name" | sed 's/{/%7B/g; s/}/%7D/g; s/#/%23/g')
  protected=$(echo $branch | jq -r '.protected')

  # Obtener el último commit de la rama
  commit=$(curl -k -s -H "Authorization: $GITHUB_TOKEN" "$GITHUB_API_URL/repos/$GITHUB_USERNAME/$GITHUB_REPO/branches/$encoded_branch_name")

  commit_date=$(echo $commit | jq -r '.commit.commit.author.date')
  commit_author=$(echo $commit | jq -r '.commit.commit.author.name')
  
  # Convertir la fecha del commit a formato Unix timestamp
  commit_date_unix=$(date -d "$commit_date" +%s)

  # Calcular la diferencia en días entre la fecha actual y la fecha del commit
  difference_days=$(( (current_date - commit_date_unix) / 86400 ))

  # Escribir la información en el archivo de salida
  echo "$branch_name - $commit_date - $commit_author - $difference_days" >> $OUTPUT_FILE

  # Eliminar la rama si no está protegida y no ha recibido cambios en los últimos 2 días
   #if [ "$protected" == "false" ] && [ $difference_days -gt 500 ] && [ $branch_name == "develop_us_{#0020}" ]; then
   if [ "$protected" == "false" ] && [ $difference_days -gt 500 ]; then
     curl -k -s -X DELETE -H "Authorization: $GITHUB_TOKEN" "$GITHUB_API_URL/repos/$GITHUB_USERNAME/$GITHUB_REPO/git/refs/heads/$encoded_branch_name"
     echo "Deleted branch: $branch_name"
   fi
done

echo "Script execution completed."
