#!/bin/bash

# Nombre de la carpeta principal
FOLDER="latex-epub-biber"

# Crear la estructura de directorios
mkdir -p "$FOLDER"
cd "$FOLDER" || exit

echo "🚀 Iniciando creación de machete en: $FOLDER"

# 1. Crear el README.md (Notas y Guía)
cat <<EOF > README.md
# Machete: LaTeX + Biber + Pandoc (EPUB)

Este repositorio contiene la configuración para compilar documentos académicos con normas APA (vía Biber) y su posterior conversión a formato accesible EPUB.

## 🛠 Compilación de PDF (pdfLaTeX + Biber)
Para procesar la bibliografía correctamente, sigue este orden:

1. \`pdflatex documento.tex\` (Genera auxiliares)
2. \`biber documento\` (Procesa referencias)
3. \`pdflatex documento.tex\` (Incluye bibliografía)
4. \`pdflatex documento.tex\` (Ajusta índices y citas)

## 📖 Conversión a EPUB (Pandoc)
Para generar el libro digital, usa el script adjunto:
\`./convertir.sh\`

### Requisitos:
- Pandoc
- Calibre (para visualización y conversión avanzada)
EOF

# 2. Crear el script de conversión (convertir.sh)
cat <<EOF > convertir.sh
#!/bin/bash

# Convertir el archivo LaTeX a EPUB
# Se usa --citeproc para procesar las citas del .bib
pandoc documento-ebook.tex \\
  -o "Soberanía_Tecnológica_en_Educación.epub" \\
  --bibliography=referencias.bib \\
  --citeproc \\
  --toc \\
  --toc-depth=3 \\
  --number-sections \\
  --epub-cover-image=logo.png \\
  --metadata title="De la Resiliencia a la Soberanía Tecnológica" \\
  --metadata author="Yesmín Cantillo Brochero, Jefferson Johan Soto González" \\
  --metadata language=es \\
  --metadata publisher="Broward International University"

echo "✅ EPUB generado: Soberanía_Tecnológica_en_Educación.epub"
EOF

# Dar permisos de ejecución al script
chmod +x convertir.sh

# 3. Crear archivo de bibliografía de ejemplo (referencias.bib)
cat <<EOF > referencias.bib
@book{jodorowsky2004,
  author = {Alejandro Jodorowsky},
  title = {La vía del Tarot},
  publisher = {Siruela},
  year = {2004},
  address = {Madrid}
}

@online{fsf2024,
  author = {Free Software Foundation},
  title = {Philosophy of the GNU Project},
  url = {https://www.gnu.org/philosophy/},
  year = {2024}
}
EOF

# 4. Crear plantilla LaTeX base (documento.tex)
cat <<EOF > documento.tex
\documentclass[12pt]{article}
\usepackage[utf8]{inputenc}
\usepackage[spanish]{babel}
\usepackage[style=apa, backend=biber]{biblatex}
\addbibresource{referencias.bib}

\title{De la Resiliencia a la Soberanía Tecnológica}
\author{Jefferson Soto}

\begin{document}
\maketitle

\section{Introducción}
Este es un documento de prueba para verificar el flujo de Biber y Pandoc. 
Como menciona \textcite{jodorowsky2004}, el simbolismo es clave.

\section{Desarrollo}
La soberanía tecnológica es fundamental en la educación virtual moderna.

\printbibliography
\end{document}
EOF

# 5. Crear versión simplificada para eBook (documento-ebook.tex)
cat <<EOF > documento-ebook.tex
# De la Resiliencia a la Soberanía Tecnológica

Este archivo es una versión simplificada para Pandoc.

## Introducción
Contenido optimizado para lectura en dispositivos móviles.

## Referencias
Las citas se generarán automáticamente desde el archivo .bib.
EOF

echo "✨ Estructura creada con éxito."
echo "Carpeta: $FOLDER"
ls -F
