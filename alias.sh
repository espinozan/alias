#!/bin/bash

# Archivo donde se almacenan los alias
ALIAS_FILE="$HOME/.bashrc"
BACKUP_FILE="$HOME/.alias_backup"

# Función para crear un alias
create_alias() {
    read -p "Ingresa el nombre del alias: " alias_name
    read -p "Ingresa el comando para el alias: " alias_command

    if grep -q "alias $alias_name=" "$ALIAS_FILE"; then
        echo "⚠️ El alias '$alias_name' ya existe."
        return
    fi

    echo "alias $alias_name='$alias_command'" >> "$ALIAS_FILE"
    echo "✅ Alias '$alias_name' creado correctamente."
    source "$ALIAS_FILE"
}

# Función para listar todos los alias
list_aliases() {
    echo "📋 Lista de alias actuales:"
    grep "^alias " "$ALIAS_FILE" || echo "⚠️ No hay alias definidos actualmente."
}

# Función para actualizar un alias
update_alias() {
    read -p "Ingresa el nombre del alias que deseas actualizar: " alias_name

    if ! grep -q "alias $alias_name=" "$ALIAS_FILE"; then
        echo "⚠️ El alias '$alias_name' no existe."
        return
    fi

    read -p "Ingresa el nuevo comando para el alias '$alias_name': " new_command
    sed -i "/alias $alias_name=/c\alias $alias_name='$new_command'" "$ALIAS_FILE"
    echo "✅ Alias '$alias_name' actualizado correctamente."
    source "$ALIAS_FILE"
}

# Función para eliminar un alias
delete_alias() {
    read -p "Ingresa el nombre del alias que deseas eliminar: " alias_name

    if ! grep -q "alias $alias_name=" "$ALIAS_FILE"; then
        echo "⚠️ El alias '$alias_name' no existe."
        return
    fi

    sed -i "/alias $alias_name=/d" "$ALIAS_FILE"
    echo "🗑️ Alias '$alias_name' eliminado correctamente."
    source "$ALIAS_FILE"
}

# 📦 Función para exportar alias a un archivo
export_aliases() {
    grep "^alias " "$ALIAS_FILE" > "$BACKUP_FILE"
    echo "✅ Todos los alias han sido exportados a $BACKUP_FILE"
}

# 📤 Función para importar alias desde un archivo
import_aliases() {
    if [ -f "$BACKUP_FILE" ]; then
        grep "^alias " "$BACKUP_FILE" >> "$ALIAS_FILE"
        echo "✅ Los alias se han importado desde $BACKUP_FILE"
        source "$ALIAS_FILE"
    else
        echo "⚠️ No se encontró el archivo $BACKUP_FILE."
    fi
}

# 🔍 Función para buscar alias
search_alias() {
    read -p "Ingresa la palabra clave para buscar en los alias (nombre o comando): " keyword
    echo "🔍 Resultados de la búsqueda:"
    grep -i "$keyword" "$ALIAS_FILE" || echo "⚠️ No se encontraron alias que coincidan con '$keyword'."
}

# 💾 Función para restaurar el archivo .bashrc desde la copia de seguridad
restore_backup() {
    if [ -f "$ALIAS_FILE.bak" ]; then
        cp "$ALIAS_FILE.bak" "$ALIAS_FILE"
        echo "✅ Se ha restaurado el archivo .bashrc desde la copia de seguridad."
        source "$ALIAS_FILE"
    else
        echo "⚠️ No se encontró la copia de seguridad ($ALIAS_FILE.bak)."
    fi
}

# 📋 Crear una copia de seguridad automática de ~/.bashrc antes de cualquier operación
backup_bashrc() {
    cp "$ALIAS_FILE" "$ALIAS_FILE.bak"
    echo "🔒 Se ha creado una copia de seguridad de $ALIAS_FILE en $ALIAS_FILE.bak"
}

# Nueva función: Mostrar alias duplicados
find_duplicate_aliases() {
    echo "🔍 Buscando alias duplicados:"
    grep "^alias " "$ALIAS_FILE" | awk -F= '{print $1}' | sort | uniq -d || echo "✅ No se encontraron alias duplicados."
}

# Nueva función: Validar alias
validate_alias() {
    read -p "Ingresa el nombre del alias para validar: " alias_name
    if alias $alias_name &> /dev/null; then
        echo "✅ El alias '$alias_name' está funcionando correctamente."
    else
        echo "⚠️ El alias '$alias_name' no es válido o tiene errores."
    fi
}

# Menú principal
while true; do
    echo -e "\n🛠️  **Gestor de Alias en Bash** 🛠️"
    echo "1) Crear un alias"
    echo "2) Listar alias"
    echo "3) Actualizar un alias"
    echo "4) Eliminar un alias"
    echo "5) Exportar alias a un archivo"
    echo "6) Importar alias desde un archivo"
    echo "7) Buscar alias por nombre o comando"
    echo "8) Restaurar copia de seguridad de ~/.bashrc"
    echo "9) Mostrar alias duplicados"
    echo "10) Validar un alias"
    echo "11) Salir"

    read -p "Selecciona una opción [1-11]: " option

    backup_bashrc  # Crear una copia de seguridad antes de cualquier operación

    case $option in
        1) create_alias ;;
        2) list_aliases ;;
        3) update_alias ;;
        4) delete_alias ;;
        5) export_aliases ;;
        6) import_aliases ;;
        7) search_alias ;;
        8) restore_backup ;;
        9) find_duplicate_aliases ;;
        10) validate_alias ;;
        11) echo "👋 ¡Hasta pronto!"; break ;;
        *) echo "❌ Opción no válida. Inténtalo de nuevo." ;;
    esac
done
