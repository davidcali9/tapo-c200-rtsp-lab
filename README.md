# Laboratorio RTSP/ONVIF – TP-Link Tapo C200

Este repositorio documenta un laboratorio práctico para descubrir, analizar y consumir el stream **RTSP** de una cámara TP-Link **Tapo C200** en una red de pruebas.

> ⚠️ **Aviso**: Todos los usuarios, contraseñas e IPs de este documento son de laboratorio (no reales).  
> No usar estas credenciales en entornos de producción.

---

## 1. Objetivo

- Descubrir la cámara en la red local.
- Identificar puertos y servicios relevantes (RTSP, ONVIF).
- Analizar el comportamiento de ONVIF (GetCapabilities / GetProfiles).
- Obtener y validar la URL RTSP real.
- Reproducir el stream desde un cliente externo (Kali / Windows).

---

## 2. Topología de laboratorio

- Red: `192.168.100.0/24` (laboratorio)
- Cámara Tapo C200: `192.168.100.50`
- Cliente Kali Linux
- Cliente Windows 10/11 (para validación adicional)

Cuenta de cámara (de ejemplo):

- Usuario: `CamUser`
- Password: `P@ssw0rd!`

---

## 3. Descubrimiento con Nmap

```bash
sudo nmap -sV -Pn -p- 192.168.100.0/24
