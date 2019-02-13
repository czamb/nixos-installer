import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }: let

  test = pkgs.writeScript "test" ''
  #!/bin/sh
  echo "Done!"

  '';

in {
  name = "nixos-installer2";

  machine =
    { config, pkgs, ... }:

    {
      imports = [
        <nixpkgs/nixos/modules/profiles/installation-device.nix>
        <nixpkgs/nixos/modules/profiles/base.nix>
      ];

      environment.systemPackages = with pkgs; [
        dialog
        fzf
        findutils
        (writeScriptBin "nixos-installer" ../nixos-installer.sh)
      ];

      virtualisation.writableStore = true;

      virtualisation.emptyDiskImages = [ 512 ];
    };

  testScript =
    ''
      $machine->succeed("echo 'test'");
      $machine->succeed(${../nixos-installer.sh});
    '';

})
