¡Qué bien que ya lograste conectar! Es un alivio cuando el hardware interno finalmente "despierta". Como bien aprendiste hoy, gestionar redes por SSH es como realizar una cirugía a distancia: un movimiento en falso y se corta la comunicación.

Aquí tienes la documentación técnica en formato **Markdown**, estructurada para que te sirva como manual de referencia o "hoja de trucos" de emergencia para tu **LubanCat 4**.

---

# 📑 Guía de Emergencia: Configuración de WiFi PCIe (Intel AX210/7265) en LubanCat 4

Esta guía documenta el proceso de diagnóstico, habilitación y gestión de interfaces inalámbricas mediante terminal (SSH) para sustituir adaptadores USB por hardware interno.

## 1. Diagnóstico de Hardware y Bus

Antes de intentar cualquier configuración, se debe verificar que el sistema "vea" la tarjeta físicamente.

* **Identificar tarjeta en el bus PCIe:**
```bash
lspci | grep -i intel

```


*Si no aparece nada, la tarjeta está mal sentada o la ranura Mini PCIe está desactivada.*
* **Verificar carga de módulos (Drivers):**
```bash
lsmod | grep iwl

```


*Debe mostrar `iwlwifi` e `iwlmvm`.*
* **Cargar driver manualmente (si no aparece en el comando anterior):**
```bash
sudo modprobe iwlwifi

```



---

## 2. Gestión de Firmware

El driver Intel requiere microcódigo específico ubicado en `/lib/firmware`.

* **Verificar existencia de archivos de firmware:**
```bash
ls /lib/firmware | grep 7265

```


* **Actualizar/Instalar base de firmwares:**
```bash
sudo apt update && sudo apt install linux-firmware

```


* **Revisar errores de inicialización (Logs del Kernel):**
```bash
sudo dmesg | grep -E "iwl|80211"

```


*Busca líneas que digan `failed to load` o `Direct firmware load for ... failed`.*

---

## 3. Gestión de Interfaces con NetworkManager (`nmcli`)

Esta es la herramienta principal para operar sin interfaz gráfica.

* **Listar todas las interfaces y su estado:**
```bash
nmcli device

```


* **Escanear redes disponibles con una interfaz específica:**
```bash
nmcli device wifi list ifname [NOMBRE_INTERFAZ]

```


* **Conectarse a una red WiFi:**
```bash
sudo nmcli device wifi connect "NombreDeRed" password "TuClave" ifname [NOMBRE_INTERFAZ]

```



---

## 4. Comandos de Bloqueo y Desbloqueo (RF-KILL)

A veces el hardware está detectado pero "apagado" por software.

* **Ver estado de bloqueos:**
```bash
rfkill list

```


* **Desbloquear todas las radios (WiFi/BT):**
```bash
sudo rfkill unblock all

```



---

## 5. El "Paso Crítico": Cambio de Interfaz por SSH

Para evitar perder la conexión permanentemente al desconectar un adaptador USB:

1. **Verificar la nueva IP:** Una vez conectada la tarjeta interna, obtén su IP con `ip addr` o `hostname -I`.
2. **Iniciar nueva sesión SSH:** Abre una **segunda terminal** y conéctate a la *nueva IP* antes de cerrar la primera.
3. **Desactivar interfaz antigua (USB):**
```bash
sudo nmcli device disconnect [INTERFAZ_USB]

```



> [!CAUTION]
> **Recordatorio de Hardware:** La tarjeta Intel interna depende críticamente de las antenas **U.FL/IPEX**. Sin ellas, aunque el software diga "conectado", la pérdida de paquetes será masiva y el SSH será inestable.

---

### Comandos de mantenimiento rápido

| Acción | Comando |
| --- | --- |
| **Apagar WiFi** | `nmcli radio wifi off` |
| **Encender WiFi** | `nmcli radio wifi on` |
| **Olvidar una red** | `nmcli connection delete [NombreRed]` |
| **Ver IPs actuales** | `ip -brief address show` |

