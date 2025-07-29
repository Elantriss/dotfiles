#!/usr/bin/env python3
import requests, json

# 🌍 Configuração: latitude/longitude do Rio de Janeiro
LAT, LON = -22.91, -43.17
# Idioma e unidades
UNITS = "metric"
LANG = "pt"

URL = (
    f"https://api.open-meteo.com/v1/forecast?"
    f"latitude={LAT}&longitude={LON}"
    f"&current_weather=true&timezone=auto"
)

def icon_for(code):
    if code == 0: return "󰖨"         # Céu limpo
    if code in (1, 2): return ""    # Poucas/algumas nuvens
    if code in (3,): return ""      # Nublado
    if code in (45, 48): return ""  # Névoa
    if code in (51, 53, 55, 56, 57): return ""  # Chuvisco
    if code in (61, 63, 65): return ""        # Chuva
    if code in (66, 67, 80, 81, 82): return ""
    if code in (71, 73, 75, 77, 85, 86): return "❄️"  # Neve
    if code in (95, 96, 99): return ""           # Tempestade
    return ""  # Genérico

try:
    resp = requests.get(URL, timeout=5)
    resp.raise_for_status()
    d = resp.json().get("current_weather", {})

    temp = round(d.get("temperature", 0))
    code = d.get("weathercode", 0)
    icon = icon_for(code)

    output = {
      "text": f"{icon} {temp}°C",
      "tooltip": f"Clima atual: {icon}\nTemperatura: {temp}°C"
    }
except Exception as e:
    output = {"text": "Erro ☁️", "tooltip": str(e)}

print(json.dumps(output))
