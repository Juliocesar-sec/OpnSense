#!/bin/bash

# --- Cores para melhor visualização ---
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}--- Iniciando a preparação para o repositório OpnSense ---${NC}"

# --- 1. Verificar e instalar pré-requisitos (Git) ---
echo -e "${YELLOW}Verificando e instalando pré-requisitos (Git)...${NC}"

# Atualiza e faz upgrade dos pacotes
sudo apt update && sudo apt upgrade -y || { echo -e "${RED}Erro ao atualizar/fazer upgrade dos pacotes.${NC}"; exit 1; }

# Instala Git
if ! command -v git &> /dev/null
then
    echo -e "${YELLOW}Git não encontrado. Instalando Git...${NC}"
    sudo apt install git -y || { echo -e "${RED}Erro ao instalar Git.${NC}"; exit 1; }
else
    echo -e "${GREEN}Git já está instalado.${NC}"
fi

echo -e "${GREEN}Pré-requisitos verificados e instalados.${NC}"

# --- 2. Clonar o repositório OpnSense ---
echo -e "${YELLOW}Clonando o repositório OpnSense do Juliocesar-sec...${NC}"

PROJECT_DIR="opnsense-configs-lab"
REPO_URL="https://github.com/Juliocesar-sec/OpnSense.git"
REPO_NAME="OpnSense" # Nome exato do diretório clonado pelo git

if [ -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}Diretório '$PROJECT_DIR' já existe. Removendo para garantir uma instalação limpa...${NC}"
    rm -rf "$PROJECT_DIR" || { echo -e "${RED}Erro ao remover diretório existente.${NC}"; exit 1; }
fi

mkdir "$PROJECT_DIR" || { echo -e "${RED}Erro ao criar diretório do projeto.${NC}"; exit 1; }
cd "$PROJECT_DIR" || { echo -e "${RED}Erro ao entrar no diretório do projeto.${NC}"; exit 1; }

git clone "$REPO_URL" || { echo -e "${RED}Erro ao clonar o repositório '$REPO_URL'.${NC}"; exit 1; }

echo -e "${GREEN}Repositório '$REPO_NAME' clonado com sucesso em '${PWD}/${REPO_NAME}'.${NC}"

# --- 3. Explicação e Próximos Passos ---
echo -e "${GREEN}--- Configuração do Ambiente Concluída ---${NC}"
echo -e "${GREEN}O repositório '$REPO_NAME' foi clonado com sucesso em: ${YELLOW}${PWD}/${REPO_NAME}${NC}"
echo ""
echo -e "${BLUE}### Entendendo o Projeto OpnSense e Como Usá-lo ###${NC}"
echo ""
echo -e "É importante entender que o OPNsense é um ${YELLOW}sistema operacional de firewall/roteador${NC}, não uma aplicação que você pode 'executar' diretamente em um container Docker como uma aplicação web."
echo -e "O repositório ${YELLOW}${REPO_URL}${NC} provavelmente contém ${GREEN}configurações, scripts ou exemplos${NC} para serem usados com uma instância do OPNsense já em funcionamento."
echo ""
echo -e "${BLUE}Passos Recomendados para um Laboratório OPNsense:${NC}"
echo "1.  ${YELLOW}Instale um software de virtualização:${NC} (ex: VirtualBox, VMware Workstation Player, Proxmox, KVM/QEMU)."
echo "2.  ${YELLOW}Baixe a ISO do OPNsense:${NC} Obtenha a imagem oficial do OPNsense em ${BLUE}https://opnsense.org/download/${NC}"
echo "3.  ${YELLOW}Crie uma nova Máquina Virtual (VM):${NC}"
echo "    * Configure-a com pelo menos 2 vCPUs, 2GB RAM e 2 interfaces de rede (uma WAN, uma LAN)."
echo "    * Use a ISO do OPNsense que você baixou para instalar o sistema operacional na VM."
echo "4.  ${YELLOW}Explore o conteúdo do repositório clonado:${NC}"
echo "    * Navegue até: ${YELLOW}${PWD}/${REPO_NAME}${NC}"
echo "    * Dentro dessa pasta, você encontrará os arquivos de configuração (.xml), scripts ou outros recursos do autor."
echo "    * Consulte a documentação ou os comentários nos scripts do repositório para entender como aplicar essas configurações à sua VM OPNsense."
echo "        Muitas configurações XML podem ser importadas através da interface web do OPNsense em 'System -> Configuration -> Backups'."
echo ""
echo -e "${BLUE}Para acessar o diretório clonado, use:${NC}"
echo -e "${YELLOW}cd ${PWD}/${REPO_NAME}${NC}"
echo ""
echo -e "Para remover completamente o diretório do projeto e seus arquivos (opcional):"
echo -e "${YELLOW}cd .. && rm -rf ${PROJECT_DIR}${NC}"
echo ""
echo -e "${GREEN}Comece a explorar e aprender!${NC}"
