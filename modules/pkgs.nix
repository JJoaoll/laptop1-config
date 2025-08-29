{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    gleam

    ghc
    cabal-install
    haskell-language-server

    haskellPackages.cabal2nix
    haskellPackages.Cabal_3_14_2_0   
    # haskellPackages.cabal-install
    haskellPackages.SDL
    haskellPackages.SDL-gfx
    haskellPackages.SDL-ttf
    haskellPackages.sdl2
    haskellPackages.lsp

    # beamMinimal28Packages.elixir_1_18
    # beamMinimal28Packages.elixir-ls
    # beamMinimal28Packages.erlang
    # beamMinimal28Packages.erlang-ls
    # beamMinimal28Packages.webdriver
  ];

}
