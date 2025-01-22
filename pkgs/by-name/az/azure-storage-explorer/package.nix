{
  stdenv,
  fetchzip,
  makeWrapper,
  lib,
  autoPatchelfHook,
  pkgs,
  glib,
  nss,
  dbus,
  atk,
  cups,
  libdrm,
  gtk3,
  alsa-lib,
  libsecret,
  xorg,
  mesa,
  libGL,

  # Common additional Electron dependencies
  at-spi2-core,
  pango,
  cairo
}:

stdenv.mkDerivation rec {
  pname = "azure-storage-explorer";
  version = "v1.36.2";

  src = fetchzip {
    url = "https://github.com/microsoft/AzureStorageExplorer/releases/download/${version}/StorageExplorer-linux-x64.tar.gz";
    sha256 = "iyzT7H+w2wPpKHhSg/Y32fWePCNeFw/6zWBhdz/Xzr8=";
    stripRoot = false;
  };

  buildInputs = [
    glib # libgobject
    nss
    dbus
    atk
    cups
    libdrm
    gtk3
    alsa-lib
    libsecret
    xorg.libX11
    mesa

    libGL

    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXrandr
    at-spi2-core
    pango
    cairo
  ];

  runtimeDependencies = [ libGL ];

  appendRunpaths = ["${libGL}/lib"];

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin
  '';

  meta = with lib; {
    description = "Azure Storage Explorer";
    homepage = "https://github.com/microsoft/AzureStorageExplorer";
    # license = licenses.unfree;
    maintainers = with maintainers; [ OtavioCozer ];
    platforms = ["x86_64-linux"];
  };
}
