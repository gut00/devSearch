# 📱 Dev Search

&#x20;

## 📌 Sobre o Projeto

O **Dev Search** é um aplicativo desenvolvido em **Flutter**, seguindo a arquitetura **MVC**, e utilizando **Modular** para injeção de dependência e navegação. Atualmente, o gerenciamento de estado é feito com **ChangeNotifier**, porém, há planos para a migração para **Bloc** futuramente.

## 🚀 Funcionalidades

- 🔎 Pesquisar qualquer usuário disponível na API do **GitHub**.
- 📷 **Extrair texto de imagens** usando OCR (Reconhecimento Óptico de Caracteres).
- 📂 Listar todos os repositórios do usuário pesquisado.
- 🔍 Filtrar repositórios por critérios específicos.
- 🔗 Acessar diretamente os repositórios pelo aplicativo.

## 🛠️ Tecnologias Utilizadas

- **Flutter** para o desenvolvimento da interface e suas funcionalidades.
- **Modular** para gerenciamento de rotas e injeção de dependências.
- **ChangeNotifier** (futuramente será substituído por **Bloc**).
- **GitHub API** para busca de usuários e repositórios.
- **Google ML Kit** para reconhecimento de texto em imagens (OCR).
- **Image Picker** para captura e seleção de imagens.

## 📦 Instalação e Uso

1. Clone este repositório:
   ```sh
   git clone https://github.com/seu-usuario/dev_search.git
   ```
2. Acesse a pasta do projeto:
   ```sh
   cd dev_search
   ```
3. Instale as dependências:
   ```sh
   flutter pub get
   ```
4. Execute o aplicativo:
   ```sh
   flutter run
   ```

## 📸 Como Usar a Funcionalidade OCR

1. **Na tela de pesquisa**, você verá dois novos botões: "Câmera" e "Galeria"
2. **Câmera**: Toque para capturar uma foto diretamente e extrair o texto dela
3. **Galeria**: Toque para selecionar uma imagem existente da galeria do dispositivo
4. **Após selecionar/capturar**: O app processará a imagem automaticamente
5. **Texto extraído**: Será preenchido automaticamente no campo de pesquisa
6. **Buscar**: Toque em "Buscar" para procurar usuários com o texto extraído

**Dica**: Funciona melhor com imagens que contêm texto claro e legível, como capturas de tela, documentos ou fotos de texto.

## 📄 Licença

Este projeto está sob a licença **MIT**. Sinta-se à vontade para utilizá-lo e contribuir! 🚀

---

Made with by Augusto Vaz


