# Machete: LaTeX + Biber + Pandoc (EPUB)

Este repositorio contiene la configuración para compilar documentos académicos con normas APA (vía Biber) y su posterior conversión a formato accesible EPUB.

## 🛠 Compilación de PDF (pdfLaTeX + Biber)
Para procesar la bibliografía correctamente, sigue este orden:

1. `pdflatex documento.tex` (Genera auxiliares)
2. `biber documento` (Procesa referencias)
3. `pdflatex documento.tex` (Incluye bibliografía)
4. `pdflatex documento.tex` (Ajusta índices y citas)

## 📖 Conversión a EPUB (Pandoc)
Para generar el libro digital, usa el script adjunto:
`./convertir.sh`

### Requisitos:
- Pandoc
- Calibre (para visualización y conversión avanzada)
