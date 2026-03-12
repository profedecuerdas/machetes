
# Machete: Supervivencia y Mantenimiento de Apps Android en Terminal

Este documento es un recordatorio de los comandos y conceptos clave para rescatar, compilar y mantener proyectos de Android Studio directamente desde la terminal de Linux, optimizando recursos y evitando los colapsos del IDE.

## 1. Compilación y Control de Gradle (La Vía Rápida)

Android Studio es pesado. Si ya tienes el código listo, usa Gradle desde la terminal para compilar el APK sin agotar la RAM de tu equipo.

* **Limpiar el proyecto (vital tras cambiar configuraciones o ramas):**
```bash
./gradlew clean

```


* **Compilar el APK limitando la RAM (Evita que la laptop se congele):**
```bash
./gradlew :app:assembleDebug -Dorg.gradle.jvmargs="-Xmx2048m"

```


* **¿Dónde queda el APK compilado?**
```bash
app/build/outputs/apk/debug/app-debug.apk

```


* **Instalar directamente al celular conectado por USB (con depuración):**
```bash
./gradlew installDebug

```


* **Botón de pánico (Si Gradle o Android Studio se congelan por completo):**
```bash
pkill -9 java

```



## 2. Búsqueda y Rescate de Código Perdido

Si el proyecto parece vacío o se perdió una versión, no entres en pánico. Linux lo sabe todo.

* **Buscar carpetas ocultas o respaldos en todo el sistema:**
```bash
sudo find / -iname "*NombreProyecto*" 2>/dev/null

```


* **Buscar una palabra específica (ej. nombre de una variable) dentro del código de cualquier archivo:**
```bash
grep -rnw ~ -e "PdfGenerator" --exclude-dir={.cache,.local,build} 2>/dev/null

```



## 3. Errores Silenciosos y Trampas del Sistema

* **El terror de la carpeta `res/`:**
La carpeta de recursos (`app/src/main/res/`) es extremadamente estricta. **No puede contener NINGÚN archivo que no sea `.xml` o imágenes válidas**. Si hay archivos basura, carpetas mal nombradas o archivos temporales, el error será: `The file name must end with .xml`.
*Solución:* Borrar recursivamente cualquier anomalía con `rm -rf` o usar `find` para limpiar archivos sin extensión.
* **El fantasma de Windows (`\r`):**
Si copias código desde un entorno web o un bloc de notas de Windows, los saltos de línea invisibles `\r` (CRLF) viajan con él. Esto hace que Linux cree archivos como `ActivityTres.kt\r`. El compilador no los reconocerá y lanzará error de `Unresolved reference`.
*Solución (Limpiar el archivo de texto antes de extraer):*
```bash
sed -i 's/\r$//' archivo_con_codigo.txt

```



## 4. Aislamiento de Apps (Instalar la original y la de pruebas)

Para tener dos versiones de la misma app instaladas en tu celular (Ej. Producción y Pruebas), debes engañar al sistema operativo cambiando su identidad.

1. Abre `app/build.gradle.kts`.
2. Cambia el **Application ID**:
```kotlin
applicationId = "com.ejemplo.app.test" // Añadir sufijo

```


3. (Opcional) Cambia el nombre visual en `app/src/main/res/values/strings.xml` para no confundir los iconos.
4. Compila un nuevo APK.

## 5. El Infierno del Almacenamiento (Scoped Storage)

A partir de Android 10+, **es imposible crear carpetas libremente en directorios públicos (como Descargas) usando el método tradicional de Java `File.mkdirs()**`. El sistema fallará silenciosamente aunque tengas permisos de almacenamiento.

* **La Solución:** Debes usar la **API MediaStore**. Le pasas los datos al sistema operativo, indicas la subcarpeta en el `RELATIVE_PATH`, y Android se encarga de crear la carpeta y guardar el archivo sin pedir permisos extra al usuario.
* **Fragmento clave para Android 10+:**
```kotlin
val contentValues = ContentValues().apply {
    put(MediaStore.MediaColumns.DISPLAY_NAME, "mi_archivo.pdf")
    put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/MiCarpetaDeseada")
}
val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)
// Luego usar resolver.openOutputStream(uri) para escribir el archivo

```



---
