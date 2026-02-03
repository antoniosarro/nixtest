{
  lib,
  pkgs,
  ...
}:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      package = lib.mkForce pkgs.mesa;
      package32 = lib.mkForce pkgs.pkgsi686Linux.mesa;

      # Critical for Iris Xe (Tiger Lake)
      extraPackages = with pkgs; [
        intel-media-driver # VAAPI for Tiger Lake and newer
        intel-compute-runtime # OpenCL support
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    };
  };

  programs.gpu-screen-recorder = {
    enable = true;
    package = lib.mkForce pkgs.unstable.gpu-screen-recorder;
  };

  # Force the correct Intel driver for Tiger Lake
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD"; # Use iHD for Gen 11+ (Tiger Lake)
    VDPAU_DRIVER = "va_gl";
  };

  # Ensure i915 module loads early with correct parameters
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_guc=3" # Enable GuC and HuC for Tiger Lake
  ];

}
