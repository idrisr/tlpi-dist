{ stdenv, libcap, lib }:
stdenv.mkDerivation rec {
  name = "libtlpi";
  src = fetchTarball {
    url = "https://www.man7.org/tlpi/code/download/tlpi-240311-dist.tar.gz";
    sha256 = "sha256:123fjajph22s02xlfxvb5y2z7w776sx7vkcb3hyfggry6l3zpldf";
  };
  patches = [ ./Makefile.patch ];
  flags = lib.strings.concatStringsSep " " [
    "--directory=lib"
    "TLPI_DIR=${src}"
    "TLPI_LIB=./libtlpi.a"
    "TLPI_INSTALL=$out"
  ];

  buildPhase = "make ${flags}";
  buildInputs = [ libcap ];
  installPhase = ''
    mkdir -p $out/lib $out/include;
    make install ${flags}'';
}
