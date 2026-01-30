{
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication {
  pname = "commit";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "1blckhrt";
    repo = "commit";
    rev = "ba6fd1a2304d68796a688f73426f9408150e008c";
    hash = "sha256-7qVsOW0Ypn9Yle5poFUpKy3PFbHft7vTvcHrtkGjA3c=";
  };

  format = "pyproject";

  nativeBuildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    questionary
    rich
  ];

  doCheck = false;

  meta = {
    description = "Opinionated conventional commit CLI";
    homepage = "https://github.com/1blckhrt/commit";
  };
}
