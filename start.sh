#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

clear
echo -e "${CYAN}"
echo "=========================================="
echo "    HOSH BOT - INICIANDO..."
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

# Verificar si node_modules existe
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠️  Las dependencias no están instaladas${NC}"
    echo -e "${YELLOW}Ejecutando npm install...${NC}"
    npm install
fi

echo ""
echo -e "${BLUE}Selecciona el modo de inicio:${NC}"
echo -e "${GREEN}[1]${NC} Modo Normal (sin sharding - para bots con menos de 1000 servidores)"
echo -e "${GREEN}[2]${NC} Modo Sharding (con sharding - para bots con 1000+ servidores)"
echo ""
read -p "Ingresa tu elección (1 o 2): " mode

echo ""

if [ "$mode" = "1" ]; then
    echo -e "${CYAN}Iniciando en Modo Normal...${NC}"
    node index.js
elif [ "$mode" = "2" ]; then
    echo -e "${CYAN}Iniciando en Modo Sharding...${NC}"
    node shard.js
else
    echo -e "${YELLOW}Opción inválida. Iniciando en Modo Normal por defecto...${NC}"
    node index.js
fi

echo ""
echo -e "${RED}"
echo "=========================================="
echo "    BOT DETENIDO"
echo "=========================================="
echo -e "${NC}"
echo ""
