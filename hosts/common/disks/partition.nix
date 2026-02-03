{ pkgs ? import <nixpkgs> {} }:
let
  lib = pkgs.lib;
  
  # 1. Define your variables here
  targetDisk = "/dev/nvme0n1";  # Change to your actual disk
  enableSwap = true;
  swapSizeGB = "16";            # Pass as string because of "${swapSize}G" interpolation
  persistDir = "/persist";
  
in
import ./disko.nix {
  inherit lib pkgs;
  
  # 2. Pass the arguments your file expects
  disk = targetDisk;
  withSwap = enableSwap;
  swapSize = swapSizeGB;
  
  # 3. Mock the 'config' object
  config = {
    hostSpec = {
      persistFolder = persistDir;
    };
  };
}