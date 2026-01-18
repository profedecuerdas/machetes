#!/bin/bash

# Convertir el archivo LaTeX a EPUB
# Se usa --citeproc para procesar las citas del .bib
pandoc documento-ebook.tex \
  -o "Soberanía_Tecnológica_en_Educación.epub" \
  --bibliography=referencias.bib \
  --citeproc \
  --toc \
  --toc-depth=3 \
  --number-sections \
  --epub-cover-image=logo.png \
  --metadata title="De la Resiliencia a la Soberanía Tecnológica" \
  --metadata author="Yesmín Cantillo Brochero, Jefferson Johan Soto González" \
  --metadata language=es \
  --metadata publisher="Broward International University"

echo "✅ EPUB generado: Soberanía_Tecnológica_en_Educación.epub"
