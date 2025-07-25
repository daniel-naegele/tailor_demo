{
  description = "Flutter environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    unstable.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    cmake-nixpkgs.url = "github:NixOS/nixpkgs/653ff61cb6f891bf493035af81d16c8e002fdbee";
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      flake-utils,
      cmake-nixpkgs,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        pkgs = import unstable {
          inherit system;
          config.allowUnfree = true;
          config.allowUnsupportedSystem = true;
          android_sdk.accept_license = true;
        };
        stable-pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnsupportedSystem = true;
          android_sdk.accept_license = true;
        };
        cmake-pkgs = import cmake-nixpkgs {
          inherit system;
        };
        androidEnv = stable-pkgs.androidenv.override { licenseAccepted = true; };
        androidComposition = androidEnv.composeAndroidPackages {
          cmdLineToolsVersion = "13.0";
          platformToolsVersion = "35.0.2";
          buildToolsVersions = [
            "30.0.3"
            "34.0.0"
            "35.0.0"
          ];
          platformVersions = [
            "31"
            "33"
            "34"
            "35"
          ];
          abiVersions = [ "x86_64" ]; # emulator related: on an ARM machine, replace "x86_64" with
          # either "armeabi-v7a" or "arm64-v8a", depending on the architecture of your workstation.
          includeNDK = true;
          ndkVersions = [ "27.0.12077973" ];
          includeSystemImages = true; # emulator related: system images are needed for the emulator.
          systemImageTypes = [
            "google_apis"
            "google_apis_playstore"
          ];
          includeEmulator = true; # emulator related: if it should be enabled or not
          useGoogleAPIs = true;
          includeExtras = [
            "extras;google;auto"
          ];
          extraLicenses = [
            "android-googletv-license"
            "android-sdk-arm-dbt-license"
            "android-sdk-license"
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
            "mips-android-sysimage-license"
          ];
        };
        androidSdk = androidComposition.androidsdk;
      in
      {
        devShell =
          with pkgs;
          mkShell rec {
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_USER_HOME = "/home/daniel/.android/";
            JAVA_HOME = jdk17.home;
            FLUTTER_ROOT = flutter;
            DART_ROOT = "${flutter}/bin/cache/dart-sdk";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
            QT_QPA_PLATFORM = "wayland;xcb"; # emulator related: try using wayland, otherwise fall back to X.
            # NB: due to the emulator's bundled qt version, it currently does not start with QT_QPA_PLATFORM="wayland".
            # Maybe one day this will be supported.
            buildInputs = [
              androidSdk
              flutter
              qemu_kvm
              gradle
              jdk17
              cocoapods
              cmake-pkgs.cmake
            ];
            # emulator related: vulkan-loader and libGL shared libs are necessary for hardware decoding
            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
              vulkan-loader
              libGL
            ]}";
            # Globally installed packages, which are installed through `dart pub global activate package_name`,
            # are located in the `$PUB_CACHE/bin` directory.
            shellHook = ''
              if [ -z "$PUB_CACHE" ]; then
                export PATH="$PATH:$HOME/.pub-cache/bin"
              else
                export PATH="$PATH:$PUB_CACHE/bin"
              fi

              export PATH="$PATH:$ANDROID_HOME/extras/google/auto/"
            '';
          };
      }
    );
}
