# 🎵 Create Post Skill

Skill automatizada para criar templates de posts para o blog "O Som do Silêncio".

## Como usar

```bash
./scripts/create-post.sh
```

## O que o script faz

✨ **Coleta as informações do post:**
- **Título**: Nome do post (obrigatório)
- **Descrição**: Resumo/descrição para SEO (obrigatório)
- **Autor**: Nome do autor (padrão: `igor`)
- **Categorias**: Uma ou mais categorias separadas por vírgula (obrigatório)
- **Featured**: Se é um post em destaque (padrão: não)
- **Imagem**: Caminho da imagem de capa (opcional)

🤖 **Gera automaticamente:**
- Nome do arquivo no formato correto: `YYYY-MM-DD-titulo-kebab-case.md`
- Data do post (hoje)
- Front matter YAML completo
- Slug slugified do título

📝 **Cria o arquivo:**
- Na pasta `_posts/` com toda a estrutura
- Oferece opção de abrir no editor para começar a escrever

## Exemplo de uso

```bash
$ ./scripts/create-post.sh
🎵 O Som do Silêncio - Post Template Generator

📝 Título do post (obrigatório): Pink Floyd - The Wall Analysis
📝 Descrição/resumo (obrigatório): Uma análise profunda do álbum clássico de 1979
👤 Autor (padrão: igor): igor
🏷️  Categorias separadas por vírgula (ex: rock, metal): progressive-rock, análise-de-álbum
⭐ Featured post? (s/n, padrão: não): s
🖼️  Caminho da imagem (ex: /assets/images/cover.jpg, opcional): /assets/images/pink-floyd-wall.jpg

✅ Post criado com sucesso!
📄 Arquivo: _posts/2026-06-19-pink-floyd-the-wall-analysis.md

Front matter:
---
layout: post
title: "Pink Floyd - The Wall Analysis"
description: "Uma análise profunda do álbum clássico de 1979"
date: 2026-06-19
author: igor
categories:
  - progressive-rock
  - análise-de-álbum
featured: true
image: /assets/images/pink-floyd-wall.jpg
---

✏️  Abrir no editor? (s/n): s
```

## Convenções respeitadas

- ✅ Nome do arquivo com prefixo de data: `YYYY-MM-DD-...`
- ✅ Slug em kebab-case
- ✅ Front matter YAML válido
- ✅ Categorias em lowercase
- ✅ Validação de campos obrigatórios
- ✅ Verificação de arquivo duplicado

## Próximos passos

Após criar o post:

1. O script abre o arquivo no seu editor padrão (ou `nano`)
2. Escreva o conteúdo do post abaixo do `---`
3. Salve o arquivo
4. Execute `bundle exec jekyll serve` para visualizar
5. Faça commit e push para publicar

## Variáveis de ambiente

- **EDITOR**: Define o editor padrão. Se não definir, usa `nano`
  
  ```bash
  export EDITOR=vim
  export EDITOR=code
  ```

## Troubleshooting

**Erro: "Arquivo já existe"**
- O arquivo para esse título neste dia já existe
- Verifique em `_posts/` ou escolha um título diferente

**Erro: "Título não pode estar vazio"**
- Todos os campos obrigatórios devem ser preenchidos

**Arquivo não abre no editor**
- Defina a variável `EDITOR`: `export EDITOR=vim`

