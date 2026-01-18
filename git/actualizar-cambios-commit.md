
**FLUJO DE COMANDOS:**

1. **Verificar el estado (Opcional pero recomendado)**
```bash
git status

```


* **Para qué sirve:** Muestra qué archivos han cambiado, cuáles son nuevos y cuáles han sido eliminados.
* **Consejo:** Úsalo siempre antes de avanzar para evitar subir archivos por accidente.


2. **Preparar los cambios (Stage)**
```bash
git add .

```


* **Acción:** Incluye en el próximo "punto de guardado" todos los cambios realizados: archivos nuevos, archivos modificados y archivos borrados.
* **Nota:** Si solo quieres agregar un archivo específico, usa `git add nombre-del-archivo.txt`.


3. **Crear el punto de guardado (Commit)**
```bash
git commit -m "Descripción breve del cambio"

```


* **Acción:** Empaqueta los archivos preparados en un "commit" con un mensaje descriptivo.
* **⚠️ Alerta:** Si no realizas este paso, el comando `push` no tendrá nada que enviar a la nube.


4. **Sincronizar con GitHub (Push)**
```bash
git push

```


* **Acción:** Sube el commit de tu computadora al repositorio online.
* **💡 Nota:** Gracias a que configuraste `gh auth login`, ya no deberías necesitar ingresar tu Token manualmente cada vez.



---

### Casos Especiales para tus notas

* **Si eliminaste un archivo manualmente:**
Al ejecutar `git add .`, Git detecta automáticamente que el archivo ya no existe y registra la eliminación en el próximo commit. No necesitas comandos extra.
* **Si el comando `git push` falla:**
Verifica que estés en la rama correcta ejecutando `git branch`. Recuerda que en nuestras sesiones establecimos que tu rama principal siempre debe ser `main`.

---

```

