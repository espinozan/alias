# alias
Esta herramienta facilita la administración de alias de comandos en la shell, permite exportarlos, importarlos, buscar por nombre o comando y restaurar la configuración original de tu archivo.

---

## 📘 **"ALIAS"**

```md
# 🔥 alias
Claro, te hago una versión más completa y estilizada del README, manteniendo todo el contenido actualizado y organizado, además con una mejor estructura y formato visual:

---

# **ALIAS Manager** - *Gestiona tus Alias de forma rápida y segura con SQLite*

## 📝 **Descripción**
**ALIAS Manager** es una herramienta de línea de comandos (CLI) diseñada para facilitar la gestión de alias en tu sistema utilizando una base de datos SQLite. Compatible con shells como **Bash**, **Zsh** y otros compatibles con POSIX, **ALIAS Manager** te permite crear, listar, actualizar y eliminar alias de forma eficiente y persistente, garantizando que tu flujo de trabajo sea más ágil y ordenado.

## 🚀 **Características Principales**
- **Base de Datos SQLite**: Almacena tus alias de forma organizada y segura.
- **Interfaz CLI Intuitiva**: Una interfaz fácil de usar para gestionar todos tus alias.
- **Validación Automática**: Verificación de unicidad y formato correcto al agregar alias.
- **Soporte para Múltiples Shells**: Funciona con Bash, Zsh y otros shells compatibles con POSIX.
- **Paginación**: Listado paginado para visualizar grandes cantidades de alias.
- **Persistencia de Alias**: Guarda los alias en tu configuración de shell para uso permanente.
- **Importación y Exportación**: Importa y exporta alias desde y hacia archivos de texto.
- **Respaldo y Restauración**: Realiza copias de seguridad y restaura tu base de datos de alias.

## 📥 **Requisitos**
Antes de ejecutar **ALIAS Manager**, asegúrate de tener instalados los siguientes componentes:

- **SQLite3**: Necesario para la base de datos.
  
### Instalación de SQLite3:

#### En Ubuntu/Debian:
```bash
sudo apt update
sudo apt install sqlite3
```

#### En macOS:
```bash
brew install sqlite
```

#### En Windows:
Puedes descargar SQLite desde su [sitio web oficial](https://www.sqlite.org/download.html) y seguir las instrucciones de instalación.

## 🔧 **Instalación de ALIAS Manager**

1. **Descargar el Script:**

```bash
git clone https://github.com/tu_usuario/alias_manager.git
cd alias_manager
```

2. **Hacer el Script Ejecutable**:

```bash
chmod +x alias_manager.sh
```

3. **Ejecutar el Script**:

```bash
./alias_manager.sh
```

## 📚 **Menú Principal**
Al ejecutar el script, se te presentará un menú interactivo con las siguientes opciones:

```bash
==================================
🛠️ **Alias Manager**
==================================
1) Agregar Alias
2) Eliminar Alias
3) Listar Aliases
4) Actualizar Alias
5) Exportar Aliases
6) Importar Aliases
7) Aplicar Aliases al Shell
8) Restablecer Base de Datos
9) Respaldar Base de Datos
10) Restaurar Base de Datos
11) Salir
```

## 🛠️ **Funcionalidades Detalladas**

### 1. **Agregar Alias**
   - Permite agregar nuevos alias a la base de datos, asegurando que no existan alias duplicados y que el comando asociado sea válido.

### 2. **Eliminar Alias**
   - Elimina un alias previamente registrado. Solo debes ingresar el nombre del alias que deseas eliminar.

### 3. **Listar Aliases**
   - Muestra todos los alias existentes. Puedes buscar por nombre o comando, y navegar a través de los resultados en páginas si la lista es extensa.

### 4. **Actualizar Alias**
   - Modifica el comando de un alias existente. Solo necesitas ingresar el nombre del alias y el nuevo comando.

### 5. **Exportar Aliases**
   - Exporta todos los alias almacenados a un archivo de texto para realizar copias de seguridad o compartir tus configuraciones con otros usuarios.

### 6. **Importar Aliases**
   - Importa alias desde un archivo de texto en el formato adecuado. Puedes elegir entre agregar nuevos alias o reemplazar los existentes.

### 7. **Aplicar Aliases al Shell**
   - Aplica los alias al shell activo, de forma que estén disponibles inmediatamente sin necesidad de reiniciar el terminal.

### 8. **Restablecer Base de Datos**
   - Elimina todos los alias almacenados y reinicia la base de datos SQLite, dejándola vacía.

### 9. **Respaldar Base de Datos**
   - Crea un respaldo de la base de datos de alias, generando un archivo con la fecha y hora del respaldo.

### 10. **Restaurar Base de Datos**
   - Permite restaurar un respaldo anterior de la base de datos para recuperar los alias.

### 11. **Salir**
   - Finaliza el programa y regresa al terminal.

## ⚙️ **Funciones Avanzadas**

### **Respaldo y Restauración de la Base de Datos**
- **Respaldar Base de Datos**: Realiza una copia de seguridad de la base de datos de alias. El archivo de respaldo se guardará con la fecha y hora actuales para facilitar su identificación.
- **Restaurar desde Respaldo**: Permite restaurar un respaldo anterior de la base de datos, recuperando todos los alias previamente guardados.

### **Importar y Exportar Aliases**
- **Importar**: Importa un archivo de texto con alias, asegurando que se sigan el formato adecuado (`nombre_alias|comando`).
- **Exportar**: Exporta todos los alias a un archivo para compartir configuraciones o realizar copias de seguridad.

### **Persistencia de Alias**
- **Aplicar al Shell**: Aplica los alias al shell activo sin necesidad de reiniciar el terminal, haciéndolos disponibles para la sesión actual.
- **Persistir en la Configuración de Shell**: Guarda los alias permanentemente en tu archivo de configuración del shell (`.bashrc`, `.zshrc`, etc.), para que se carguen automáticamente en futuras sesiones.

## 🔒 **Seguridad**
**ALIAS Manager** implementa medidas de seguridad para asegurar que la base de datos de alias se mantenga privada y accesible solo por el usuario autorizado. El archivo de base de datos se protege mediante permisos adecuados (`chmod 600`).

## 🛠️ **Cómo Contribuir**
Si deseas contribuir al proyecto, siéntete libre de abrir un pull request. Asegúrate de seguir las mejores prácticas de código y de realizar pruebas antes de enviar tus cambios.

1. **Haz un Fork** del repositorio.
2. **Clona tu Fork** en tu máquina local.
3. **Crea una rama** para tu cambio.
4. **Haz un commit** y **push** a tu rama.
5. **Envía un Pull Request**.

---

## 🐛 **Reporte de errores**

Si encuentras un error o bug, abre un [issue](https://github.com/espinozan/aliasion/issues) y proporciona información detallada para que podamos ayudarte lo antes posible.  

---

## 🌐 **Enlaces útiles**
- [Repositorio en GitHub](https://github.com/tu_usuario/alias_manager)
- [Documentación Oficial de SQLite](https://www.sqlite.org/docs.html)

---

## 📜 **Licencia**

Este proyecto está bajo la licencia GNU v3.
Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## 🧑‍💻 **Autor**

Creado con ❤️ por **Nahuel Espinoza**.  
Sígueme en [GitHub](https://github.com/espinozan) para más proyectos interesantes!

```
### 🚀😎
