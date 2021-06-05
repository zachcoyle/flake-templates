{
  description = "mobile development flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell.url = github:numtide/devshell;
  };


  outputs = { self, nixpkgs, flake-utils, devshell }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlay ];
        config.android_sdk.accept_license = true;
      };

      mainBuildToolsVersion = "30.0.3";
      platformVersions = [ "29" ];

      android = pkgs.androidenv.composeAndroidPackages {
        toolsVersion = "26.1.1";
        platformToolsVersion = "31.0.2";
        buildToolsVersions = [ mainBuildToolsVersion ];
        includeEmulator = true;
        emulatorVersion = "30.4.5";
        inherit platformVersions;
        includeSources = false;
        includeSystemImages = false;
        systemImageTypes = [ "google_apis_playstore" ];
        abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
        cmakeVersions = [ "3.10.2" ];
        includeNDK = true;
        ndkVersion = "22.0.7026061";
        useGoogleAPIs = false;
        useGoogleTVAddOns = false;
        includeExtras = [ "extras;google;gcm" ];
      };

      #ios = (import ./ios.nix { inherit pkgs; });

    in
    {

      # TODO: add examples of building apps entirely through nix
      #packages = { };

      devShell = pkgs.devshell.mkShell {
        packages = with pkgs; [
          android.androidsdk
          android.platform-tools
          cocoapods
          fastlane
          gitAndTools.gitFull
          gitAndTools.gh
          gradle
          jdk
          just
          nodejs-16_x
          yarn
        ];

        env = [
          {
            name = "ANDROID_HOME";
            value = "${android.androidsdk}/libexec/android-sdk";
          }
          {
            name = "GRADLE_OPTS";
            value = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android.androidsdk}/libexec/android-sdk/build-tools/${mainBuildToolsVersion}/aapt2";
          }

        ];

      };
    });
}
