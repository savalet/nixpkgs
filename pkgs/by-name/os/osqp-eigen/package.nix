{
  catch2,
  cmake,
  eigen,
  fetchFromGitHub,
  lib,
  osqp,
  stdenv,
  valgrind,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "osqp-eigen";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "robotology";
    repo = "osqp-eigen";
    rev = "v${finalAttrs.version}";
    hash = "sha256-vmHGOG+duR8R5KSC0yaXkjB5KaotTjuXbXneKv9MO3c=";
  };

  cmakeFlags = [
    (lib.cmakeBool "BUILD_TESTING" true)
    (lib.cmakeBool "OSQPEIGEN_RUN_Valgrind_tests" stdenv.hostPlatform.isLinux)
  ];

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [
    eigen
    osqp
  ];
  checkInputs = [ catch2 ];
  nativeCheckInputs = lib.optional stdenv.hostPlatform.isLinux valgrind;

  doCheck = true;

  meta = {
    description = "Simple Eigen-C++ wrapper for OSQP library";
    homepage = "https://github.com/robotology/osqp-eigen";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ nim65s ];
  };
})
