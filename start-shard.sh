#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

clear
echo -e "${CYAN}"
echo "=========================================="
echo "    HOSH BOT - MODO SHARDING"
echo "=========================================="
echo -e "${NC}"

# Verificar si existe el archivo .env
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: El archivo .env no existe${NC}"
    echo -e "${YELLOW}Por favor, ejecuta primero ./setup.sh${NC}"
    exit 1
fi

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Error: Node.js no está instalado${NC}"
    echo -e "${YELLOW}Por favor, ejecuta primero ./setup.sh${NC}"
    exit 1
fi

echo ""
echo -e "${CYAN}Iniciando bot con sharding automático...${NC}"
echo -e "${GREEN}Este modo es recomendado para bots en 1000+ servidores${NC}"
echo ""

node shard.js

echo ""
echo -e "${RED}"
echo "=========================================="
echo "    BOT DETENIDO"
echo "=========================================="
echo -e "${NC}"
echo ""
