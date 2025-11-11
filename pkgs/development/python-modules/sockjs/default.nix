{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  aiohttp,
  async-timeout,

  # tests
  aiohttp-cors,
  pytest-aiohttp,
  pytest-mock,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "sockjs";
  version = "0.13.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "aio-libs";
    repo = "sockjs";
    tag = "v${version}";
    hash = "sha256-MqlI8hwKLBYtRd1U8EluJTRoOy8pia1AqNuiKlj/QIA=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    async-timeout
  ];

  nativeCheckInputs = [
    aiohttp-cors
    pytest-aiohttp
    pytest-mock
    pytestCheckHook
  ];

  disabledTestPaths = [
    # missing cykooz dependency
    "tests/test_route.py"
  ];

  pythonImportsCheck = [ "sockjs" ];

  meta = with lib; {
    description = "Sockjs server";
    homepage = "https://github.com/aio-libs/sockjs";
    license = licenses.asl20;
    maintainers = with maintainers; [ freezeboy ];
  };
}
