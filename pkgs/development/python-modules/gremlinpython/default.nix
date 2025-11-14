{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  aenum,
  aiohttp,
  async-timeout,
  isodate,
  nest-asyncio,
  pytestCheckHook,
  mock,
  pyhamcrest,
  pyyaml,
  radish-bdd,
}:

buildPythonPackage rec {
  __structuredAttrs = true;

  pname = "gremlinpython";
  version = "3.8.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "apache";
    repo = "tinkerpop";
    tag = version;
    hash = "sha256-dslSvtne+0mobjhjZDiO7crQE3aW5wEMWw7l3LkBTV8=";
  };

  sourceRoot = "${src.name}/gremlin-python/src/main/python";

  build-system = [
    setuptools
  ];

  pythonRelaxDeps = [ "async-timeout" ];

  dependencies = [
    aenum
    aiohttp
    async-timeout
    isodate
    nest-asyncio
  ];

  nativeCheckInputs = [
    pytestCheckHook
    mock
    pyhamcrest
    pyyaml
    radish-bdd
  ];

  # many tests expect a running tinkerpop server
  disabledTestPaths = [
    "tests/driver/test_client.py"
    "tests/driver/test_driver_remote_connection.py"
    "tests/driver/test_driver_remote_connection_http.py"
    "tests/driver/test_driver_remote_connection_threaded.py"
    "tests/driver/test_web_socket_client_behavior.py"
    "tests/process/test_dsl.py"
    "tests/structure/io/test_functionalityio.py"
  ];

  disabledTests = [
    "TestFunctionalGraphSONIO and test_timestamp"
    "TestFunctionalGraphSONIO and test_datetime"
    "TestFunctionalGraphSONIO and test_uuid"
    "test_transaction_commit"
    "test_transaction_rollback"
    "test_transaction_no_begin"
    "test_multi_commit_transaction"
    "test_multi_rollback_transaction"
    "test_multi_commit_and_rollback"
    "test_transaction_close_tx"
    "test_transaction_close_tx_from_parent"
  ];

  meta = with lib; {
    description = "Gremlin-Python implements Gremlin, the graph traversal language of Apache TinkerPop, within the Python language";
    homepage = "https://tinkerpop.apache.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ ris ];
  };
}
