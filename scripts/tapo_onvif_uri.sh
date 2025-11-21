#!/usr/bin/env bash

# Script de ejemplo para consultar ONVIF GetCapabilities
# en una cámara TP-Link Tapo C200 de laboratorio.

IP="192.168.100.50"      # IP de laboratorio
USER="CamUser"           # Usuario de la Camera Account (ejemplo)
PASS="P@ssw0rd!"         # Password de ejemplo
ONVIF_URL="http://${IP}:2020/onvif/device_service"

echo "[*] Consultando GetCapabilities en ${ONVIF_URL}..."

curl -s -u "$USER:$PASS" \
  -H "Content-Type: application/soap+xml; charset=utf-8" \
  -d '<?xml version="1.0" encoding="utf-8"?>
      <s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope">
        <s:Body>
          <GetCapabilities xmlns="http://www.onvif.org/ver10/device/wsdl">
            <Category>All</Category>
          </GetCapabilities>
        </s:Body>
      </s:Envelope>' \
  "$ONVIF_URL"
