#!/bin/bash


# Función para validar el título del pull request
validate_title() {
    local title="$1"
    
    # Verificar que el título contenga al menos 5 palabras
    word_count=$(echo "$title" | wc -w)
    
    # Verificar que el título termine con un símbolo numeral seguido de un número
    valid_format=$(echo "$title" | grep -P '#\d+$')

    if [[ $word_count -ge 5 && -n "$valid_format" ]]; then
        return 0
    else
        return 1
    fi
}

# Función para validar la descripción del pull request
validate_description() {
    local description="$1"
    if [[ $(echo "$description" | wc -w) -ge 10 ]]; then
        return 0
    else
        return 1
    fi
}