# shell.nix
let
  # Simplesmente importa o nixpkgs que o seu sistema está usando
  pkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  };

  # 2. Escolha uma versão do GHC. É bom ser explícito.
  #    Ex: pkgs.haskell.packages.ghc96, ghc94, etc.
  ghcVersion = pkgs.haskell.packages.ghc96;

  # 3. Crie o ambiente GHC com todas as bibliotecas Haskell necessárias.
  ghc = ghcVersion.ghcWithPackages (hp: [
    # Pacotes essenciais do XMonad
    hp.xmonad
    hp.xmonad-contrib
    hp.xmonad-extras

    # O LSP para o editor de texto
    hp.haskell-language-server

    # Bibliotecas comuns usadas em configurações do XMonad.
    # Adicione aqui qualquer outra que você importar no seu xmonad.hs!
    # Exemplo: se você usa 'import Data.Map', precisa do 'containers'.
    hp.containers
    hp.dbus
    hp.mtl
    # hp.some-other-library-you-need
  ]);

in
# 4. Cria o ambiente de shell final
pkgs.mkShell {
  # Nome que pode aparecer no seu prompt
  name = "xmonad-dev-shell";

  # Lista de todas as dependências (Haskell e de sistema)
  packages = [
    # Nosso ambiente GHC com tudo dentro
    ghc

    # Ferramentas e bibliotecas de sistema essenciais
    pkgs.xorg.libX11
    pkgs.xorg.libXinerama
    pkgs.xorg.libXrandr
    pkgs.xorg.libXft
    pkgs.xorg.xprop      # Para pegar informações de janelas
    pkgs.xorg.xrandr     # Para configurar monitores
    pkgs.xorg.xmessage        # Ótimo para debugar e mostrar mensagens
    
    # Utilitários que você provavelmente usa com o XMonad
    pkgs.dmenu           # Lançador de programas clássico
    pkgs.xmobar          # Barra de status popular
    pkgs.st              # Um terminal simples, bom para testes
    pkgs.feh             # Para definir o papel de parede
    pkgs.picom           # Compositor para transparência e efeitos
  ];

  # Hook executado quando o shell inicia
  shellHook = ''
    echo "✅ Ambiente XMonad pronto!"
    echo "   GHC e todas as libs estão no PATH."
    echo "   Experimente: xmonad --recompile"
    # A variável GHC_PACKAGE_PATH é configurada automaticamente pelo ghcWithPackages
    # Não precisamos mexer aqui, o que torna tudo mais limpo!
  '';
}
