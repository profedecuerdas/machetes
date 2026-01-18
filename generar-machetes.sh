#!/bin/bash

# 1. Crear directorios
mkdir -p git node linux

# 2. Archivos de GIT
cat << 'EOF' > git/push-token-acceso.txt
ACCION: Subir cambios usando Token (PAT)
----------------------------------------
1. git add .
2. git commit -m "mensaje"
3. git push -u origin main
4. Usuario: profedecuerdas
5. Password: [PEGAR_TOKEN_AQUÍ]
EOF

cat << 'EOF' > git/fix-refspec-main.txt
ACCION: Corregir error 'src refspec main'
-----------------------------------------
Causa: No hay commits o la rama no se llama main.
Solución:
1. git add .
2. git commit -m "primer commit"
3. git branch -M main
4. git push -u origin main
EOF

cat << 'EOF' > git/vincular-remoto-nuevo.txt
ACCION: Conectar carpeta local con GitHub
------------------------------------------
1. git init
2. git remote add origin https://github.com/profedecuerdas/NOMBRE_REPO.git
3. git remote -v (para verificar)
EOF

# 3. Archivos de NODE
cat << 'EOF' > node/limpiar-entorno-npm.txt
ACCION: Borrar archivos pesados (Limpieza)
------------------------------------------
Comando: rm -rf node_modules .next
Uso: Ejecutar antes de comprimir o respaldar para ahorrar espacio.
EOF

cat << 'EOF' > node/instalar-dependencias.txt
ACCION: Reinstalar el entorno de trabajo
----------------------------------------
Comando: npm install
Requisito: Tener el archivo package.json en la carpeta.
EOF

# 4. Archivos de LINUX
cat << 'EOF' > linux/zip-comprimir-fuente.txt
ACCION: Crear respaldo liviano (ZIP)
------------------------------------
Comando: zip -r nombre.zip . -x "*.git*" "node_modules/*" ".next/*"
Nota: Comprime solo el código fuente.
EOF

cat << 'EOF' > linux/comandos-basicos-mint.txt
ACCION: Navegación y Visualización
----------------------------------
- pwd: Ver ruta actual.
- ls -a: Ver archivos ocultos (como .git).
- tree: Ver estructura de carpetas.
EOF

# 5. README Principal
cat << 'EOF' > README.md
# 🧠 Machetes: Mi Diccionario de Comandos

Repositorio personal de consultas rápidas para procedimientos técnicos.

### 📂 Índice de Consultas

#### 🛠 Git & GitHub
- [Cómo usar el Token PAT](./git/push-token-acceso.txt)
- [Reparar error de rama main](./git/fix-refspec-main.txt)
- [Vincular repositorio nuevo](./git/vincular-remoto-nuevo.txt)

#### 📦 Node.js & NPM
- [Limpiar node_modules y caché](./node/limpiar-entorno-npm.txt)
- [Instalar dependencias](./node/instalar-dependencias.txt)

#### 🐧 Linux & Sistema
- [Comprimir código fuente (ZIP)](./linux/zip-comprimir-fuente.txt)
- [Comandos de terminal básicos](./linux/comandos-basicos-mint.txt)

---
*Organizado por: Jefferson Soto*
EOF

echo "✅ Estructura 'machetes' creada con éxito."
