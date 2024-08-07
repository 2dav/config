{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "yambar-hyprland-wses-alpha";
  version = "0.2.0-alpha.1";

  src = fetchFromGitHub {
    owner = "jonhoo";
    repo = "yambar-hyprland-wses";
    rev = "v${version}";
    hash = "sha256-FPFo8SYYPmwnfL6XYhbbJGY+A5gphYECMSOLLpPdUjI=";
  };

  cargoHash = "sha256-a4pjLCPvtmVA5CmMT9MXLLL6smSv5+K0NQeqLHhRqTk=";

  meta = with lib; {
    description = "";
    homepage = "https://github.com/jonhoo/yambar-hyprland-wses.git";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ ];
    mainProgram = "yambar-hyprland-wses";
  };
}
