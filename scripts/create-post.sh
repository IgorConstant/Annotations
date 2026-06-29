#!/bin/bash
#
# Skill: Create Jekyll Post Template
# Creates a new blog post with proper front matter and file naming
# Usage: ./scripts/create-post.sh
#

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
POSTS_DIR="$REPO_ROOT/_posts"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎵 O Som do Silêncio - Post Template Generator${NC}\n"

# Get post title
read -p "📝 Título do post (obrigatório): " title
if [ -z "$title" ]; then
    echo -e "${RED}❌ Título não pode estar vazio!${NC}"
    exit 1
fi

# Get description
read -p "📝 Descrição/resumo (obrigatório): " description
if [ -z "$description" ]; then
    echo -e "${RED}❌ Descrição não pode estar vazia!${NC}"
    exit 1
fi

# Get author (default: igor)
read -p "👤 Autor (padrão: igor): " author
author="${author:-igor}"

# Get categories
read -p "🏷️  Categorias separadas por vírgula (ex: rock, metal): " categories_input
if [ -z "$categories_input" ]; then
    echo -e "${RED}❌ Pelo menos uma categoria é obrigatória!${NC}"
    exit 1
fi

# Get featured status
read -p "⭐ Featured post? (s/n, padrão: não): " featured
featured="${featured:-n}"
if [ "$featured" = "s" ] || [ "$featured" = "S" ]; then
    featured_yaml="true"
else
    featured_yaml="false"
fi

# Get image path
read -p "🖼️  Caminho da imagem (ex: /assets/images/cover.jpg, opcional): " image

# Generate filename
DATE=$(date +"%Y-%m-%d")
SLUG=$(echo "$title" | \
    tr '[:upper:]' '[:lower:]' | \
    tr 'áàâãéèêíïóôõöúçñ' 'aaaaeeeiioooouncn' | \
    sed 's/[^a-z0-9]/-/g' | \
    sed 's/-\+/-/g' | \
    sed 's/^-\|-$//g')
FILENAME="$POSTS_DIR/$DATE-$SLUG.md"

# Check if file already exists
if [ -f "$FILENAME" ]; then
    echo -e "${RED}❌ Arquivo já existe: $FILENAME${NC}"
    exit 1
fi

# Convert categories to YAML format
CATEGORIES_YAML=""
for cat in $(echo "$categories_input" | sed 's/, */\n/g'); do
    cat_clean=$(echo "$cat" | sed 's/^ *//' | sed 's/ *$//' | tr '[:upper:]' '[:lower:]')
    CATEGORIES_YAML="${CATEGORIES_YAML}  - $cat_clean"$'\n'
done

# Build the front matter
FRONT_MATTER="---
layout: post
title: \"$title\"
description: \"$description\"
date: $DATE
author: $author
categories:
$CATEGORIES_YAML"

# Add featured if true
FRONT_MATTER="$FRONT_MATTER""featured: $featured_yaml"$'\n'

# Add image if provided
if [ -n "$image" ]; then
    FRONT_MATTER="$FRONT_MATTER""image: $image"$'\n'
fi

FRONT_MATTER="$FRONT_MATTER""---"$'\n\n'

# Create the file
echo -e "$FRONT_MATTER" > "$FILENAME"

echo -e "\n${GREEN}✅ Post criado com sucesso!${NC}"
echo -e "${BLUE}📄 Arquivo: ${YELLOW}$FILENAME${NC}"
echo -e "\n${BLUE}Front matter:${NC}"
head -n 12 "$FILENAME"

# Ask if user wants to open in editor
read -p $'\n\n✏️  Abrir no editor? (s/n): ' open_editor
if [ "$open_editor" = "s" ] || [ "$open_editor" = "S" ]; then
    ${EDITOR:-nano} "$FILENAME"
    echo -e "${GREEN}✅ Post salvo!${NC}"
fi

echo -e "\n${BLUE}💡 Próximos passos:${NC}"
echo "1. Edite o post em: $FILENAME"
echo "2. Adicione seu conteúdo abaixo do front matter"
echo "3. Execute 'bundle exec jekyll serve' para visualizar"
echo "4. Faça commit e push para publicar"
