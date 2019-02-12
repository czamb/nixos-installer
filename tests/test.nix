import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }: let

  test = pkgs.writeScript "test" ''
  #!/bin/sh
  echo "Done!"

  '';

in {
  name = "nixos-installer";

  machine =
    { config, pkgs, ... }:

    {
      imports = [
        <nixpkgs/nixos/modules/profiles/installation-device.nix>
        <nixpkgs/nixos/modules/profiles/base.nix>
      ];

      environment.systemPackages = with pkgs; [
        dialog
        (writeScriptBin "nixos-installer" ../nixos-installer.sh)
      ];

      virtualisation.emptyDiskImages = [ 512 ];
    };

  testScript =
    ''
      $machine->succeed("echo 'test'");
      $machine->succeed(${../nixos-installer.sh});
    '';

})
