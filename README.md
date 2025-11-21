
# 📡 Laboratorio RTSP/ONVIF – TP-Link Tapo C200
### 🔍 Auditoría, descubrimiento y validación de flujo RTSP en red local

![Status](https://img.shields.io/badge/Status-Completed-brightgreen)  
![Category](https://img.shields.io/badge/Category-Network%20Security-blue)  
![Device](https://img.shields.io/badge/Device-TP--Link%20Tapo%20C200-orange)  
![Protocol](https://img.shields.io/badge/Protocol-RTSP%20%2F%20ONVIF-yellow)

---

## 📑 **Índice**
1. [Descripción del Proyecto](#descripción-del-proyecto)  
2. [Objetivos del Laboratorio](#objetivos-del-laboratorio)  
3. [Arquitectura del Entorno](#arquitectura-del-entorno)  
4. [Requisitos](#requisitos)  
5. [Procedimiento Completo](#procedimiento-completo)  
6. [Resultados del Laboratorio](#resultados-del-laboratorio)  
7. [URLs RTSP Finales](#urls-rtsp-finales)  
8. [Hallazgos y Aprendizajes](#hallazgos-y-aprendizajes)  
9. [Capturas de Evidencia](#capturas-de-evidencia)  
10. [Sobre este Proyecto](#sobre-este-proyecto)

---

## 📘 **Descripción del Proyecto**

Este repositorio documenta un laboratorio de ciberseguridad orientado a:

- Descubrir una cámara IP TP-Link Tapo C200 en la red.  
- Analizar su superficie ONVIF (puertos, servicios, restricciones).  
- Identificar la estructura real del flujo RTSP.  
- Probar, validar y documentar la obtención del video desde Kali Linux y Windows.  

Este proyecto combina **metodología de auditoría técnica** con **explicación pedagógica**, ideal tanto para profesionales como para divulgación (LinkedIn, GitHub o YouTube).

---

## 🎯 **Objetivos del Laboratorio**

- Identificar la cámara en la red mediante **Nmap**.  
- Descubrir servicios activos: RTSP, HTTPS, ONVIF.  
- Interactuar con ONVIF vía SOAP (curl).  
- Desbloquear la credencial correcta para RTSP (Camera Account).  
- Reproducir y validar el streaming desde herramientas CLI y GUI.  
- Documentar el procedimiento de forma profesional y segura.

---

## 🏗️ **Arquitectura del Entorno**

```
┌─────────────────────────┐           ┌──────────────────────────┐
│        Kali Linux        │           │        Windows 10/11      │
│ - Nmap                   │           │ - VLC Player              │
│ - Curl (SOAP/ONVIF)      │           │                            │
│ - FFplay / MPV           │           │                            │
└───────────┬─────────────┘           └────────────┬──────────────┘
            │                                             │
            └────────────── Redes 192.168.100.0/24 ───────┘
                        │
                 ┌────────────┐
                 │ TP-Link     │
                 │ Tapo C200   │
                 │ (RTSP/ONVIF)│
                 └────────────┘
```

---

## 🔧 **Requisitos**

### Hardware
- TP-Link **Tapo C200**  
- Red local de laboratorio

### Software
**En Kali:**
- Nmap  
- Curl  
- FFmpeg / ffplay  
- MPV  
- Git

**En Windows (validación):**
- VLC Media Player

---

## 🚀 **Procedimiento Completo**

### 🔎 5.1 Descubrimiento con Nmap

```bash
sudo nmap -sV -Pn -p- 192.168.100.0/24
```

Puertos relevantes:

| Puerto | Servicio | Descripción |
|--------|----------|-------------|
| 554/tcp | RTSP     | Streaming |
| 2020/tcp | ONVIF    | SOAP/Device |
| 443/8443 | HTTPS   | Portal interno |

---

### 📦 5.2 Análisis ONVIF via SOAP/Curl

#### GetCapabilities:

```bash
curl -v -u CamUser:P@ssw0rd! \
  -H "Content-Type: application/soap+xml; charset=utf-8" \
  -d '<SOAP XML GetCapabilities>' \
  http://192.168.100.50:2020/onvif/device_service
```

La cámara responde con 200 OK, pero **Media Profiles devuelve NotAuthorized**.

---

### 🔐 5.3 Credenciales RTSP reales

La Tapo C200 requiere una **Camera Account** distinta de la cuenta de la app.

Ejemplo:

- Usuario: `CamUser`  
- Password: `P@ssw0rd!`

---

### 🎥 5.4 Validación del Stream RTSP

#### En Kali:

```bash
ffplay rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1
```

Resultado:

- H.264 1080p  
- pcm_alaw  
- “Session streamed by TP-Link RTSP Server”

#### En Windows (VLC):

Usar la misma URL:

```
rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1
```

---

## 🟩 **Resultados del Laboratorio**

| Test | Resultado |
|------|-----------|
| Detección vía Nmap | ✔ |
| ONVIF Device | ✔ |
| ONVIF Media | ✖ Restringido |
| RTSP Main Stream | ✔ |
| RTSP Sub Stream | ✔ (si habilitado) |
| Reproducción Kali | ✔ CLI |
| Reproducción Windows | ✔ GUI |

---

## 🔗 **URLs RTSP Finales**

### Main Stream (1080p)
```
rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1
```

### Sub Stream (SD)
```
rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream2
```

---

## 🧠 **Hallazgos y Aprendizajes**

- ONVIF Media está limitado en este firmware.  
- RTSP solo funciona con Camera Account.  
- Algunos reproductores en Kali requieren configuraciones de backend.  
- Windows VLC reproduce sin problemas.

---

## 📸 **Capturas de Evidencia**

Crear archivos dentro de `/captures/`:

```
captures/
 ├─ nmap_scan.png
 ├─ ffplay_output.png
 └─ vlc_windows.png
```

Para mostrarlos:

```md
![Nmap Scan](captures/nmap_scan.png)
![FFplay Output](captures/ffplay_output.png)
![VLC Windows](captures/vlc_windows.png)
```

---

## 🙋 **Sobre este Proyecto**

Laboratorio educativo y de investigación sobre IoT, ONVIF y RTSP.  
Todas las IPs y credenciales son ficticias.  
Apto para portfolio, LinkedIn y demostraciones técnicas.

---

