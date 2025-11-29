#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

clear
echo -e "${BLUE}"
echo "=========================================="
echo "    HOSH BOT - INSTALACIÓN"
echo "=========================================="
echo -e "${NC}"

# Verificar si Node.js está instalado y es la versión correcta
echo -e "${YELLOW}Verificando Node.js...${NC}"
NODE_INSTALLED=false
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -ge 22 ]; then
        NODE_INSTALLED=true
        echo -e "${GREEN}✓ Node.js ya está instalado y es compatible: $(node -v)${NC}"
    else
        echo -e "${YELLOW}Node.js está instalado pero es una versión antigua ($(node -v)). Se requiere v22+.${NC}"
    fi
fi

if [ "$NODE_INSTALLED" = false ]; then
    echo -e "${RED}Instalando/Actualizando a Node.js 22.x...${NC}"
    
    # Actualizar repositorios
    sudo apt update
    
    # Instalar curl y herramientas de compilación si no están instaladas
    echo -e "${YELLOW}Instalando dependencias del sistema...${NC}"
    sudo apt install -y curl build-essential python3
    
    # Instalar Node.js 22.x (Requerido por discord.js voice)
    echo -e "${YELLOW}Configurando repositorio de Node.js 22.x...${NC}"
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt install -y nodejs
    
    echo -e "${GREEN}✓ Node.js instalado correctamente${NC}"
fi

# Verificar npm
echo -e "${YELLOW}Verificando npm...${NC}"
if ! command -v npm &> /dev/null; then
    echo -e "${RED}npm no está instalado. Instalando npm...${NC}"
    sudo apt install -y npm
    echo -e "${GREEN}✓ npm instalado correctamente${NC}"
else
    NPM_VERSION=$(npm -v)
    echo -e "${GREEN}✓ npm ya está instalado: ${NPM_VERSION}${NC}"
fi

# Instalar ffmpeg si no está instalado
echo -e "${YELLOW}Verificando ffmpeg...${NC}"
if ! command -v ffmpeg &> /dev/null; then
    echo -e "${YELLOW}ffmpeg no está instalado. Instalando ffmpeg...${NC}"
    sudo apt install -y ffmpeg
    echo -e "${GREEN}✓ ffmpeg instalado correctamente${NC}"
else
    echo -e "${GREEN}✓ ffmpeg ya está instalado${NC}"
fi

# Instalar dependencias del proyecto
echo ""
echo -e "${YELLOW}Instalando dependencias del proyecto...${NC}"
npm install

# Verificar si existe el archivo .env
if [ ! -f .env ]; then
    echo ""
    echo -e "${YELLOW}Creando archivo .env...${NC}"
    cat > .env << 'EOF'
# Configuración del Bot de Discord
DISCORD_TOKEN=
CLIENT_ID=
GUILD_ID=

# Configuración de la API de Spotify
SPOTIFY_CLIENT_ID=
SPOTIFY_CLIENT_SECRET=

# Configuración de la API de Genius
GENIUS_CLIENT_ID=
GENIUS_CLIENT_SECRET=

# Configuración del Bot (Opcional - se usarán valores predeterminados si no se establece)
EMBED_COLOR=#FF6B6B
SUPPORT_SERVER=https://discord.gg/ACJQzJuckW
WEBSITE=https://hosh.app
STATUS=🎵 Hosh | /play

# Configuración de Sharding (Para bots con más de 1000 servidores)
# Dejar como 'auto' para configuración automática
TOTAL_SHARDS=auto
SHARD_LIST=auto
SHARD_MODE=process
SHARD_RESPAWN=true
SHARD_SPAWN_DELAY=5500
SHARD_SPAWN_TIMEOUT=30000

# Configuración de Cookies de YouTube (Solución para errores de detección de bots)
# Método 1: Usar cookies del navegador (recomendado - más fácil de mantener actualizado)
# Opciones: chrome, firefox, edge, safari
# Ejemplo: COOKIES_FROM_BROWSER=chrome
COOKIES_FROM_BROWSER=

# Método 2: Usar archivo cookies.txt
# Exportar cookies desde la extensión del navegador y guardar como cookies.txt
# Ejemplo: COOKIES_FILE=./cookies.txt
COOKIES_FILE=
EOF
    echo -e "${GREEN}✓ Archivo .env creado${NC}"
fi

# Crear directorio de base de datos si no existe
if [ ! -d "database" ]; then
    mkdir -p database
    echo -e "${GREEN}✓ Directorio de base de datos creado${NC}"
fi

# Crear directorio de caché de audio si no existe
if [ ! -d "audio_cache" ]; then
    mkdir -p audio_cache
    echo -e "${GREEN}✓ Directorio de caché de audio creado${NC}"
fi

echo ""
echo -e "${GREEN}"
echo "=========================================="
echo "    ✓ INSTALACIÓN COMPLETADA"
echo "=========================================="
echo -e "${NC}"
echo ""
echo -e "${YELLOW}PRÓXIMOS PASOS:${NC}"
echo "1. Edita el archivo .env con tus credenciales:"
echo "   nano .env"
echo ""
echo "2. Inicia el bot con:"
echo "   ./start.sh"
echo ""
echo -e "${BLUE}Presiona Enter para continuar...${NC}"
read
