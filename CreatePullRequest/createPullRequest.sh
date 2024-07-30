#!/bin/bash

 #Incluir el archivo que exporta variables
 source ./../set_env.sh
 #Incluir el archivo funciones de validación
 source ./validations.sh

# Solicitar y validar el título del pull request
while true; do
    read -p "Título del pull request (debe contener al menos 5 palabras y terminar con un número precedido por un símbolo numeral): " pr_title
    
    if validate_title "$pr_title"; then
        break
    else
        echo "Título inválido. Asegúrate de que contenga al menos 5 palabras y termine con # seguido de un número."
    fi
done

# Solicitar y validar la descripción del pull request
while true; do
    read -p "Descripción del pull request (debe contener al menos 10 palabras): " pr_description
    
    if validate_description "$pr_description"; then
        break
    else
        echo "Descripción inválida. Debe contener al menos 10 palabras."
    fi
done

read -p "Rama origen: " source_branch
read -p "Rama destino: " target_branch

JSON_PAYLOAD='{
	"title": "'$pr_title'",
	"body": "'$pr_description'",
	"head": "'$source_branch'",
	"base": "'$target_branch'"
}'

# Crear el pull request usando la API de GitHub
response=$(curl -k -H "Authorization: $GITHUB_TOKEN" -d "$JSON_PAYLOAD" "$GITHUB_API_URL/repos/$GITHUB_USERNAME/$GITHUB_REPO/pulls")

# Mostrar mensaje de éxito o error
if echo "$response" | grep -q '"number":'; then
    echo "Pull request creado con éxito."
else
    echo "Error al crear el pull request: $(echo "$response" | grep -o '"message": *"[^"]*"' | sed 's/"message": "//' | sed 's/"//')"
    echo "$response"
fi