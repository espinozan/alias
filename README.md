# alias
Esta herramienta facilita la administración de alias de comandos en la shell, permite exportarlos, importarlos, buscar por nombre o comando y restaurar la configuración original de tu archivo.


¡Claro! Aquí te dejo un **README.md completo y bien documentado** para que puedas subir tu proyecto **"aliasion"** a GitHub. Este archivo incluye una introducción, características, requisitos, instalación, uso, ejemplos, contribuciones y la licencia.

---

## 📘 **README.md para el repositorio "aliasion"**

```md
# 🔥 aliasion

**aliasion** es una herramienta de línea de comandos escrita en **Bash** que permite realizar operaciones **CRUD (Crear, Leer, Actualizar, Eliminar)** de alias en sistemas Linux. Esta herramienta facilita la administración de alias, permite exportarlos, importarlos, buscar por nombre o comando y restaurar la configuración original de tu archivo `~/.bashrc`. ¡Todo desde un solo script interactivo! 🚀

---

## 📌 **Características principales**

- ✅ **Crear alias**: Crea nuevos alias de forma sencilla.
- ✅ **Listar alias**: Muestra todos los alias actuales.
- ✅ **Actualizar alias**: Modifica comandos de alias existentes.
- ✅ **Eliminar alias**: Elimina alias de forma segura.
- ✅ **Exportar alias**: Exporta todos los alias a un archivo de respaldo (`.alias_backup`).
- ✅ **Importar alias**: Importa alias desde un archivo previamente exportado.
- ✅ **Buscar alias**: Busca alias por nombre o por fragmento de comando.
- ✅ **Restaurar archivo `~/.bashrc`**: Restaura el archivo de alias desde una copia de seguridad automática.

---

## 🚀 **Requisitos previos**

Para usar **aliasion**, solo necesitas un sistema **Linux** con un shell Bash. Está diseñado para funcionar de forma nativa en Ubuntu, Debian y otros sistemas Linux basados en Unix.

- **Sistema operativo**: Linux / Unix  
- **Shell**: bash (v4 o superior)  
- **Permisos**: Necesitas permisos de escritura en el archivo `~/.bashrc`

---

## 📥 **Instalación**

1. **Clona el repositorio** de GitHub:
   ```bash
   git clone https://github.com/espinozan/aliasion.git
   ```

2. **Accede al directorio del proyecto**:
   ```bash
   cd aliasion
   ```

3. **Dale permisos de ejecución al script**:
   ```bash
   chmod +x crud_alias.sh
   ```

¡Listo! Ahora puedes ejecutar el script directamente.

---

## 🚀 **Uso**

Para iniciar la herramienta, simplemente ejecuta:
```bash
./crud_alias.sh
```

Verás el siguiente menú interactivo:  
```
🛠️  **Gestor de Alias en Bash** 🛠️
1) Crear un alias
2) Listar alias
3) Actualizar un alias
4) Eliminar un alias
5) Exportar alias a un archivo
6) Importar alias desde un archivo
7) Buscar alias por nombre o comando
8) Restaurar copia de seguridad de ~/.bashrc
9) Salir
```

---

## 📋 **Funciones disponibles**

### 1️⃣ **Crear alias**
Crea un nuevo alias con un nombre y un comando.

**Pasos**:  
1. Selecciona la opción `1` en el menú.  
2. Ingresa el nombre del alias.  
3. Ingresa el comando que se ejecutará con el alias.  

**Ejemplo**:  
Nombre del alias: `update`  
Comando para el alias: `sudo apt-get update && sudo apt-get upgrade -y`

---

### 2️⃣ **Listar alias**
Muestra una lista de todos los alias actualmente definidos en tu archivo `~/.bashrc`.  
**Pasos**:  
1. Selecciona la opción `2` en el menú.

---

### 3️⃣ **Actualizar alias**
Modifica un alias existente.  
**Pasos**:  
1. Selecciona la opción `3` en el menú.  
2. Introduce el nombre del alias que deseas modificar.  
3. Introduce el nuevo comando para el alias.  

**Ejemplo**:  
Alias a actualizar: `update`  
Nuevo comando: `sudo apt-get update && sudo apt-get dist-upgrade -y`

---

### 4️⃣ **Eliminar alias**
Elimina un alias existente de forma permanente.  
**Pasos**:  
1. Selecciona la opción `4` en el menú.  
2. Introduce el nombre del alias que deseas eliminar.  

**Ejemplo**:  
Alias a eliminar: `update`

---

### 5️⃣ **Exportar alias a un archivo**
Guarda todos los alias actuales en un archivo de respaldo llamado `.alias_backup`.  
**Pasos**:  
1. Selecciona la opción `5` en el menú.  
2. El archivo de respaldo se crea en la ruta `~/.alias_backup`.  

---

### 6️⃣ **Importar alias desde un archivo**
Restaura los alias desde un archivo de respaldo `.alias_backup`.  
**Pasos**:  
1. Selecciona la opción `6` en el menú.  
2. El contenido de `.alias_backup` se añade al archivo `~/.bashrc`.  

---

### 7️⃣ **Buscar alias por nombre o comando**
Busca un alias usando una palabra clave (nombre o comando).  
**Pasos**:  
1. Selecciona la opción `7` en el menú.  
2. Introduce la palabra clave a buscar.  

**Ejemplo**:  
Palabra clave: `update`  
El sistema mostrará todos los alias relacionados.

---

### 8️⃣ **Restaurar copia de seguridad de ~/.bashrc**
Restaura tu archivo `~/.bashrc` desde la copia automática creada antes de cualquier operación.  
**Pasos**:  
1. Selecciona la opción `8` en el menú.  
2. El archivo `~/.bashrc.bak` se restaurará y sobrescribirá `~/.bashrc`.  

---

## 🔥 **Ejemplo de uso rápido**
1. **Crear un alias** llamado `hola` para que imprima "Hola Mundo":  
   ```bash
   Nombre del alias: hola
   Comando para el alias: echo 'Hola Mundo'
   ```

2. **Listar los alias actuales**:  
   ```bash
   ./crud_alias.sh
   ```

3. **Actualizar el alias** `hola` para que imprima "¡Hola de nuevo!":  
   ```bash
   Alias a actualizar: hola
   Nuevo comando: echo '¡Hola de nuevo!'
   ```

4. **Eliminar el alias** `hola`:  
   ```bash
   Alias a eliminar: hola
   ```

5. **Exportar todos los alias a un archivo**:  
   ```bash
   ./crud_alias.sh
   ```

6. **Restaurar tu archivo ~/.bashrc desde la copia de seguridad**:  
   ```bash
   ./crud_alias.sh
   ```

---

## 🤝 **Contribuciones**

¡Las contribuciones son bienvenidas!  
Si deseas contribuir, sigue estos pasos:

1. **Fork** este repositorio.  
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).  
3. Realiza tus cambios y haz un commit (`git commit -m 'Añadida nueva funcionalidad'`).  
4. Sube los cambios (`git push origin feature/nueva-funcionalidad`).  
5. Abre un **Pull Request**.  

---

## 🐛 **Reporte de errores**

Si encuentras un error o bug, abre un [issue](https://github.com/espinozan/aliasion/issues) y proporciona información detallada para que podamos ayudarte lo antes posible.  

---

## 📜 **Licencia**

Este proyecto está bajo la licencia MIT.  
Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## 🧑‍💻 **Autor**

Creado con ❤️ por **espinozan**.  
¡Sígueme en [GitHub](https://github.com/espinozan) para más proyectos interesantes!

```

---

### 🚀 **Instrucciones para subirlo a GitHub**

1. **Inicia tu repositorio** en GitHub.  
   - Ve a [GitHub](https://github.com) y crea un repositorio llamado `aliasion`.  

2. **Sube tu proyecto** a GitHub:  
   ```bash
   git init
   git remote add origin https://github.com/espinozan/aliasion.git
   git add .
   git commit -m "🚀 Primera versión de aliasion"
   git branch -M main
   git push -u origin main
   ```

---
😎
