{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  pythonOlder,
  pyserial,
  tqdm,
  pyusb,
}:

buildPythonPackage rec {
  pname = "stcgal";
  version = "1.10";
  pyproject = true;
  disabled = pythonOlder "3.8";
  
  #fetchFromGitHub because setup.py reads docs/Pypi.md during building
  src = fetchFromGitHub {
    owner = "grigorig";
    repo = "stcgal";
    rev = "v${version}";
    hash = "sha256-SM2wtpJ1F6sfBwfX+2124fLfTtVNjwa5NqsWrhORGhI=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    pyserial
    tqdm
  ];

  passthru.optional-dependencies = {
    usb = [ pyusb ];
  };

  pythonImportsCheck = [ "stcgal" ];

  meta = with lib; {
    mainProgram = "stcgal"; 
    description = "STC MCU ISP flash tool";
    homepage = "https://pypi.org/project/stcgal/";
    platforms = with platforms; unix;
    license = licenses.mit;
    maintainers = with maintainers; [ qwqawawow ];
  };
}
