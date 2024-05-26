{ stdenv, libcap }:
stdenv.mkDerivation rec {
  name = "libtlpi";
  src = fetchTarball {
    url = "https://www.man7.org/tlpi/code/download/tlpi-240311-dist.tar.gz";
    sha256 = "sha256:123fjajph22s02xlfxvb5y2z7w776sx7vkcb3hyfggry6l3zpldf";
  };
  patches = [ ./Makefile.patch ];
  makeFlags = [
    "--directory=lib"
    "TLPI_DIR=${src}"
    "TLPI_LIB=./libtlpi.a"
    "TLPI_INSTALL=$(out)"
  ];

  preInstall = "mkdir -p $out/lib $out/include";
  buildInputs = [ libcap ];
}
