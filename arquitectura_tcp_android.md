# Machete: Arquitectura TCP Android-Linux y Solución de Problemas

Este documento registra los conceptos técnicos y soluciones aplicadas al construir un puente de comunicación crudo (TCP/Sockets) entre un script de Bash en Linux (Cliente) y una App Android (Servidor) para la captura de firmas digitales.

## 1. Arquitectura "Ping-Pong" con Netcat (nc)
* **El Problema:** Sincronizar la captura gráfica de una firma en Android con un generador de PDF (pdflatex) en Linux.
* **La Solución:** Comunicación bidireccional por sockets.
    * **Ida (Puerto 8080):** Linux dispara un string de texto (`echo "Motivo" | nc IP_ANDROID 8080`). Android tiene un `ServerSocket` escuchando, atrapa el texto y despierta la interfaz de firma.
    * **Retorno (Puerto 9000):** Al firmar, Android abre un `Socket` hacia la IP de Linux (que atrapó en el paso anterior) y le inyecta el `Bitmap` comprimido en PNG. Linux lo recibe con `nc -w 5 -l -p 9000 > firma.png`.

## 2. El Infierno de los Procesos Zombie en Netcat
* **Síntoma:** El script bash se queda "congelado" esperando o el archivo PNG llega corrupto (`libpng error: Read Error`).
* **Causa:** `nc` no siempre cierra el puerto al terminar de recibir datos en Linux Mint, bloqueando ejecuciones futuras, o el script avanza antes de que el disco duro termine de escribir el PNG.
* **Solución (Script Blindado):**
    1.  Matar procesos previos: `fuser -k 9000/tcp` y `pkill -f nc`.
    2.  Timeout de inactividad: Usar `nc -w 5` en lugar de `-q 1`.
    3.  Forzar escritura en disco: Usar el comando `sync` después de recibir el archivo.

## 3. Sobreviviendo a Gradle y al JDK en Linux
* **Error:** `Toolchain installation does not provide the required capabilities: [JAVA_COMPILER]`
    * **Causa:** Linux Mint instala el JRE (solo ejecución) por defecto. Se necesita el JDK completo (`sudo apt install openjdk-21-jdk`).
* **Error Persistente tras instalar el JDK:** Gradle sigue diciendo que no hay compilador.
    * **Causa:** El Demonio de Gradle (`Gradle Daemon`) guarda en caché el entorno viejo.
    * **Solución:** Detener el demonio con `./gradlew --stop` y forzar la ruta `export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64`.
* **Error:** `Dependency requires libraries to compile against version 36 of Android APIs`.
    * **Solución:** Actualizar `compileSdk = 36` en `build.gradle.kts` porque las librerías modernas lo exigen.

## 4. Manipulación del Ciclo de Vida en Android (Rotación)
* **Problema:** Al girar el celular, la pantalla de firma desaparece y se pierde la conexión.
* **Causa:** Android destruye y recrea la `Activity` por defecto al cambiar la orientación.
* **Solución:** Delegar el manejo de la rotación a la aplicación añadiendo en el `AndroidManifest.xml`:
    `android:configChanges="orientation|screenSize|screenLayout|keyboardHidden"`

## 5. Optimización Gráfica: Recorte Transparente
En lugar de crear algoritmos manuales de escaneo de píxeles (bounding box) para quitar el exceso de lienzo blanco de la firma, se debe usar el poder nativo de la librería gráfica (JitPack SignaturePad):
`signaturePad.getTransparentSignatureBitmap(true)` -> Genera un PNG recortado al milímetro y sin fondo, ideal para incrustar en LaTeX.
