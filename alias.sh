#!/usr/bin/env bash

# ============================
# Alias Manager with SQLite
# ============================
# A robust alias management tool that uses SQLite for storage and supports Bash, Zsh, and other POSIX-compliant shells.

DB_FILE="$HOME/.alias_manager.db"

# Verify SQLite installation
check_sqlite() {
  if ! command -v sqlite3 &> /dev/null; then
    echo "❌ Error: SQLite3 no está instalado. Instálalo para continuar."
    exit 1
  fi
}

# Initialize SQLite database
initialize_db() {
  if [ ! -f "$DB_FILE" ]; then
    sqlite3 "$DB_FILE" <<EOF
CREATE TABLE aliases (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  command TEXT NOT NULL
);
EOF
    echo "🗄️ SQLite database initialized: $DB_FILE"
  fi
}
# Secure the database
chmod 600 "$DB_FILE"

# Add a new alias with validation
add_alias() {
  local alias_name=$1
  local alias_command=$2

  if [[ ! "$alias_name" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "❌ Alias inválido. Usa solo letras, números y guiones bajos."
    return 1
  fi

  if sqlite3 "$DB_FILE" "SELECT 1 FROM aliases WHERE name='$alias_name'" | grep -q 1; then
    echo "⚠️ Alias '$alias_name' already exists."
    return 1
  fi

  sqlite3 "$DB_FILE" "INSERT INTO aliases (name, command) VALUES ('$alias_name', '$alias_command')" || {
    echo "❌ Error al agregar el alias."
    return 1
  }
  echo "✅ Alias '$alias_name' added successfully."
}

# Remove an alias
remove_alias() {
  local alias_name=$1

  if ! sqlite3 "$DB_FILE" "SELECT 1 FROM aliases WHERE name='$alias_name'" | grep -q 1; then
    echo "⚠️ Alias '$alias_name' does not exist."
    return 1
  fi

  sqlite3 "$DB_FILE" "DELETE FROM aliases WHERE name='$alias_name'"
  echo "🗑️ Alias '$alias_name' removed successfully."
}

# List all aliases with pagination and search by name or command
list_aliases() {
  echo -e "📋 \e[1;34mCurrent Aliases\e[0m"
  
  # Ask for search term
  read -rp "Buscar alias por nombre o comando: " search_term

  # Initialize offset and limit for pagination
  local offset=0
  local limit=5

  # Build the search query if there's a search term
  local query="SELECT name, command FROM aliases"
  if [ -n "$search_term" ]; then
    query="$query WHERE name LIKE '%$search_term%' OR command LIKE '%$search_term%'"
  fi

  while true; do
    # Fetch the results with pagination
    local results
    results=$(sqlite3 "$DB_FILE" "$query LIMIT $limit OFFSET $offset")

    if [ -z "$results" ]; then
      echo "⚠️ No more aliases to display."
      break
    fi

    # Display results
    echo -e "Alias\t\tCommand"
    echo "-------------------------------"
    echo "$results" | awk -F '|' '{printf "%-10s  %-50s\n", $1, $2}'

    # Ask if the user wants to see more
    read -rp "Mostrar más? (s/n): " choice
    if [[ "$choice" != "s" ]]; then
      break
    fi
    offset=$((offset + limit))
  done
}

# Update an alias
update_alias() {
  local alias_name=$1
  local new_command=$2

  if ! sqlite3 "$DB_FILE" "SELECT 1 FROM aliases WHERE name='$alias_name'" | grep -q 1; then
    echo "⚠️ Alias '$alias_name' does not exist."
    return 1
  fi

  sqlite3 "$DB_FILE" "UPDATE aliases SET command='$new_command' WHERE name='$alias_name'"
  echo "✅ Alias '$alias_name' updated successfully."
}

# Export aliases to a file
export_aliases() {
  local export_file=$1
  sqlite3 "$DB_FILE" "SELECT name, command FROM aliases" > "$export_file" || {
    echo "❌ Error al exportar alias."
    return 1
  }
  echo "✅ Aliases exported to $export_file."
}

# Import aliases from a file with option to replace existing aliases
import_aliases() {
  local import_file=$1
  if [ ! -f "$import_file" ]; then
    echo "⚠️ Import file not found: $import_file"
    return 1
  fi

  # Ask user if they want to replace existing aliases
  read -rp "¿Deseas reemplazar los alias existentes? (s/n): " replace
  if [[ "$replace" == "s" || "$replace" == "S" ]]; then
    echo "⚠️ Replacing existing aliases..."
    # Remove existing aliases from the database before import
    sqlite3 "$DB_FILE" "DELETE FROM aliases WHERE name IN (SELECT name FROM aliases)" || {
      echo "❌ Error al eliminar alias existentes."
      return 1
    }
    echo "✅ Existing aliases replaced."
  fi

  # Import new aliases
  while IFS='|' read -r name command; do
    # Validate alias format
    if [[ ! "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
      echo "⚠️ Invalid alias name: '$name'. Skipping..."
      continue
    fi

    # Check if alias already exists
    if sqlite3 "$DB_FILE" "SELECT 1 FROM aliases WHERE name='$name'" | grep -q 1; then
      echo "⚠️ Alias '$name' already exists. Skipping..."
    else
      # Insert new alias
      sqlite3 "$DB_FILE" "INSERT INTO aliases (name, command) VALUES ('$name', '$command')" || {
        echo "❌ Error al importar alias '$name'."
      }
    fi
  done < "$import_file"

  echo "✅ Aliases imported from $import_file."
}

# Función para respaldar la base de datos
backup_db() {
  local backup_file="$DB_FILE-$(date +%Y%m%d%H%M%S).bak"
  cp "$DB_FILE" "$backup_file"
  if [[ $? -eq 0 ]]; then
    echo "✅ Respaldo de la base de datos realizado correctamente: $backup_file"
  else
    echo "❌ Error al realizar el respaldo de la base de datos."
  fi
}

# Función para restaurar la base de datos desde un archivo de respaldo
restore_db() {
  local backup_file="$1"
  if [[ -f "$backup_file" ]]; then
    cp "$backup_file" "$DB_FILE"
    if [[ $? -eq 0 ]]; then
      echo "✅ Restauración de la base de datos completada desde: $backup_file"
    else
      echo "❌ Error al restaurar la base de datos."
    fi
  else
    echo "❌ El archivo de respaldo no existe."
  fi
}

# Apply aliases to the current shell
apply_aliases() {
  sqlite3 "$DB_FILE" "SELECT name, command FROM aliases" | while IFS='|' read -r name command; do
    alias "$name"="$command"
  done
  echo "✅ Aliases applied to the current shell session."
}

persist_alias() {
  local shell_config
  
  # Detecta el shell y selecciona el archivo de configuración
  case "$SHELL" in
    */bash)
      shell_config="$HOME/.bashrc" ;;
    */zsh)
      shell_config="$HOME/.zshrc" ;;
    *)
      shell_config="$HOME/.profile" ;;  # Para shells genéricos
  esac

  # Escribir alias en el archivo de configuración
  sqlite3 "$DB_FILE" "SELECT name, command FROM aliases" | while IFS='|' read -r name command; do
    # Elimina alias preexistentes para evitar duplicados
    sed -i "/^alias $name=/d" "$shell_config"
    
    # Escribir alias en el archivo de configuración, rodeado de comillas dobles
    echo "alias \"$name\"=\"$command\"" >> "$shell_config"
  done

  echo "✅ Aliases guardados de forma permanente en $shell_config."

  # Recargar automáticamente el archivo de configuración
  source "$shell_config"
}


# Reset the database
reset_db() {
    echo -e "\n⚠️ ¡Advertencia! Esta acción eliminará permanentemente la base de datos de alias."
    echo -e "🚨 Esta operación no se puede deshacer y podría afectar el funcionamiento de los alias guardados."
    read -rp "¿Estás seguro de que deseas continuar con la eliminación de la base de datos? (si/no): " confirm

    case "$confirm" in
        [sS]|[sS][iI][yY])  # Acepta "sí", "si", "Sí", "sí" , "yes", "YES", "Yes", "y", "Y"
            rm -f "$DB_FILE"
            echo -e "✅ La base de datos ha sido eliminada correctamente.\n"
            ;;
        *)
            echo -e "❌ Operación cancelada. La base de datos no ha sido modificada.\n"
            ;;
    esac
}

# Main Menu
main_menu() {
  while true; do
    echo "=================================="
    echo -e "\e[1;32m🛠️ Alias Manager\e[0m"
    echo "=================================="
    echo "1) Add Alias"
    echo "2) Remove Alias"
    echo "3) List Aliases"
    echo "4) Update Alias"
    echo "5) Export Aliases"
    echo "6) Import Aliases"
    echo "7) Apply Aliases to Shell"
    echo "8) Reset Database"
    echo "9) Backup Database"
    echo "10) Restore Database"
    echo "11) Exit"

    read -rp "Select an option: " choice
    case $choice in
      1)
        read -rp "Enter alias name: " alias_name
        read -rp "Enter alias command: " alias_command
        add_alias "$alias_name" "$alias_command" ;;
      2)
        read -rp "Enter alias name to remove: " alias_name
        remove_alias "$alias_name" ;;
      3)
        list_aliases ;;
      4)
        read -rp "Enter alias name to update: " alias_name
        read -rp "Enter new alias command: " alias_command
        update_alias "$alias_name" "$alias_command" ;;
      5)
        read -rp "Enter export file path: " export_file
        export_aliases "$export_file" ;;
      6)
        read -rp "Enter import file path: " import_file
        import_aliases "$import_file" ;;
      7)
        apply_aliases
        persist_alias ;;
      8)
        reset_db ;;
      9)
        backup_db ;;
      10)
        echo -n "Ingrese el nombre del archivo de respaldo a restaurar: "
        read -r backup_file
        restore_db "$backup_file"  # Llamada para restaurar la base de datos desde un respaldo
        ;;
      11)
        echo "👋 Exiting. Goodbye!"
        exit 0 ;;
      *)
        echo "❌ Invalid option. Try again." ;;
    esac
    read -n 1 -s -r -p "Presione cualquier tecla para continuar..."
  done
}

# Initialize and Run
check_sqlite
initialize_db
main_menu

main() {
  menu
}
