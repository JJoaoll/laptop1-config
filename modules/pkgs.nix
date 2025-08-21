{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    gleam
    ghc
    haskellPackages.SDL
    haskellPackages.SDL-gfx
    haskellPackages.SDL-ttf
    haskellPackages.sdl2

    # beamMinimal28Packages.elixir_1_18
    # beamMinimal28Packages.elixir-ls
    # beamMinimal28Packages.erlang
    # beamMinimal28Packages.erlang-ls
    # beamMinimal28Packages.webdriver

    
  ];

}
