{ lib
, stdenv
, fetchFromGitHub
, vcpkg
, httplib
, openssl
, nlohmann_json
, curl
, cmake
,
}:
stdenv.mkDerivation rec {
  pname = "beammp-launcher";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "BeamMP";
    repo = "BeamMP-Launcher";
    rev = "v${version}";
    hash = "";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    vcpkg
    httplib
    openssl
    nlohmann_json
    curl
    cmake
  ];

  cmakeBuildType = "Release";

  installPhase = ''
    mkdir -p $out/bin
    cp -v BeamMP-Launcher $out/bin
  '';

  meta = {
    description = "Official BeamMP-launcher";
    homepage = "";
    license = lib.licenses.unfree;
    mainProgram = "beammp-launcher";
    platforms = lib.platforms.all;
  };
}
