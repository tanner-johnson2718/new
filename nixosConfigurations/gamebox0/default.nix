{pkgs, inputs, ...}:
let
  sysID = "gamebox0";
in
{
  imports = with inputs.self.nixosModules; [
    asus-gu603
    common
    deviceManager
    gnome
    nvidiaPrime
    yubi
    mkdocs
  ];

  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    environment.systemPackages = with pkgs; [
      discord
      prusa-slicer
      google-chrome
      yubioath-flutter
      wireshark
      qbittorrent
      freecad
      drawio
    ];
    
    asus-gu603.enable = true;
    common.enable = true;
    common.userName = sysID;
    common.home-manager-enable = true;
    common.home-manager-config =
      ({inputs, ...}: {
	imports = with inputs.self.homeModules; [
	  bash
	  git
	  nvim
	  tmux
	];
	bash.enable = true;
        git.enable = true;
        git.email = "tanner.johnson2718@gmail.com";
        git.userName = sysID;
        nvim.enable = true;
        tmux.enable = true;
      });
    deviceManager.enable = true;
    gnome.enable = true;
    nvidiaPrime.enable = true;
    yubi.enable = true;
    yubi.id = "29490434";
    mkdocs.enable = true;
    mkdocs.docsDir = ../../docs;
    mkdocs.siteName = "Env";
  };
}
