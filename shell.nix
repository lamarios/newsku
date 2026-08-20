{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
    config.allowBroken = true;
    config.permittedInsecurePackages = [
      "gradle-7.6.6"
    ];
  }
, ci ? false}:

let
 aliases = [ ];


in
pkgs.mkShell {
  buildInputs = with pkgs; builtins.concatLists [
    [ jdk25 maven gnumake python313Packages.pip http-server ]
  ];

  # to run CI or DB migrations
  shellHook =  ''
  # Setting up mkdocs
  python -m venv --clear mkdocs/venv
  source mkdocs/venv/bin/activate
  pip install -r mkdocs/requirements.txt

  # to install new plugin dependencies, pip install <package> then pip freeze > mkdocs/requirements.txt to add it to the requirement file

  export JAVA_HOME=${pkgs.jdk25}/lib/openjdk

  echo "Setting up submodules"
  git submodule init
  git submodule update


  "Adding flutter submodule to path"
  export PATH="${toString ./.}/src/main/app/submodules/flutter/bin:$PATH"


  echo "Setting up pre-commit hook"
  dart run tools/setup_git_hooks.dart

  flutter config --jdk-dir ${pkgs.jdk21}/lib/openjdk
  flutter doctor

  echo "creating useful aliases..."
  echo -e "\nAll done 🎉 \nAvailable aliases:"
  ''+
          pkgs.lib.concatStrings (map (x: ''echo "${x.name}: ${x.description}";'') aliases);

  ####################################################################
  # Without  this, almost  everything  fails with  locale issues  when
  # using `nix-shell --pure` (at least on NixOS).
  # See
  # + https://github.com/NixOS/nix/issues/318#issuecomment-52986702
  # + http://lists.linuxfromscratch.org/pipermail/lfs-support/2004-June/023900.html
  ####################################################################

  LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}

# vim: set tabstop=2 shiftwidth=2 expandtab:
