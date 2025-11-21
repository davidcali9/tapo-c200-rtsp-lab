📡 Laboratorio RTSP/ONVIF – TP-Link Tapo C200
🔍 Auditoría, descubrimiento y validación de flujo RTSP en red local








📑 Índice

Descripción del Proyecto

Objetivos del Laboratorio

Arquitectura del Entorno

Requisitos

Procedimiento Completo

5.1 Escaneo y descubrimiento

5.2 Análisis ONVIF

5.3 Credenciales RTSP reales

5.4 Validación del stream

Resultados del Laboratorio

URLs RTSP Finales

Hallazgos y Aprendizajes

Capturas de Evidencia

Sobre este Proyecto

📘 Descripción del Proyecto

Este repositorio documenta un laboratorio de ciberseguridad orientado a:

Descubrir una cámara IP TP-Link Tapo C200 en la red.

Analizar su superficie ONVIF (puertos, servicios, restricciones).

Identificar la estructura real del flujo RTSP.

Probar, validar y documentar la obtención del video desde Kali Linux y Windows.

Este proyecto combina metodología de auditoría técnica con explicación pedagógica, ideal tanto para profesionales como para divulgación (LinkedIn, GitHub o YouTube).

🎯 Objetivos del Laboratorio

Identificar la cámara en la red mediante Nmap.

Descubrir servicios activos: RTSP, HTTPS, ONVIF.

Interactuar con ONVIF vía SOAP (curl).

Desbloquear la credencial correcta para RTSP (Camera Account).

Reproducir y validar el streaming desde herramientas CLI y GUI.

Documentar el procedimiento de forma profesional y segura.

🏗️ Arquitectura del Entorno
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

🔧 Requisitos
Hardware

TP-Link Tapo C200

Red local de laboratorio

Software

En Kali:

Nmap

Curl

FFmpeg / ffplay

MPV

Git

En Windows (validación):

VLC Media Player

🚀 Procedimiento Completo
🔎 5.1 Descubrimiento con Nmap
sudo nmap -sV -Pn -p- 192.168.100.0/24


Resultados clave:

Puerto	Servicio	Descripción
554/tcp	RTSP	Servidor de streaming
2020/tcp	ONVIF	Endpoint SOAP/Device
443/8443	HTTPS	Portal interno

👉 Esto confirma que el flujo RTSP y ONVIF están accesibles.

📦 5.2 Análisis ONVIF via SOAP/Curl
GetCapabilities
curl -v -u CamUser:P@ssw0rd! \
  -H "Content-Type: application/soap+xml; charset=utf-8" \
  -d '<SOAP XML GetCapabilities>' \
  http://192.168.100.50:2020/onvif/device_service


Respuesta:
✔ Dispositivo ONVIF accesible
✖ Media Profiles → NotAuthorized

👉 La Tapo C200 restringe Media Profiles, habitual en este modelo.

🔐 5.3 Credenciales RTSP reales

La Tapo C200 NO usa la cuenta de la app para RTSP.

Debes crear:

App Tapo → Configuración avanzada → Cuenta de cámara

Ejemplo de laboratorio:

Usuario: CamUser

Password: P@ssw0rd!

Sin esta cuenta, RTSP devuelve 401 Unauthorized.

🎥 5.4 Validación del Stream RTSP
En Kali (ffplay):
ffplay rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1


Salida:

Vídeo: H.264 (1080p)

Audio: pcm_alaw

“Session streamed by TP-Link RTSP Server”

En Windows (VLC):

Medio → Abrir ubicación de red

URL:

rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1

🟩 Resultados del Laboratorio
Test	Resultado
Detección de la cámara	✔ Detectada vía Nmap
ONVIF Device	✔ Accesible
ONVIF Media	✖ Restringido por firmware
RTSP Main Stream	✔ Exitoso
RTSP Sub Stream	✔ (si activado en app)
Reproducción en Kali	✔ CLI funcional
Reproducción en Windows	✔ GUI funcional
🔗 URLs RTSP Finales
🔹 Main Stream (1080p)
rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream1

🔹 Sub Stream (SD)
rtsp://CamUser:P@ssw0rd!@192.168.100.50:554/stream2

🧠 Hallazgos y Aprendizajes

La Tapo C200 implementa un ONVIF limitado, especialmente en Media Profiles.

La Camera Account es obligatoria para RTSP.

Algunos reproductores en Kali pueden requerir ajustes (backends, PulseAudio).

VLC en Windows opera sin problemas.

El flujo RTSP funciona de forma estable una vez autenticado correctamente.

📸 Capturas de Evidencia

Coloca tus capturas aquí dentro de /captures/:

captures/
 ├─ nmap_scan.png
 ├─ ffplay_output.png
 └─ vlc_windows.png


Y en el README:

![Nmap Scan](captures/nmap_scan.png)
![FFplay Output](captures/ffplay_output.png)
![VLC Windows](captures/vlc_windows.png)

🙋 Sobre este Proyecto

Este laboratorio forma parte de un entorno educativo y de investigación en análisis de dispositivos IoT, enfocado en:

prácticas de ciberseguridad,

auditoría de protocolos,

integración con NVR,

y documentación técnica para portfolio profesional.

Se comparten únicamente IPs y credenciales ficticias, respetando la seguridad del entorno real.
