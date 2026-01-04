{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "masterchef-script-shell";
    buildInputs = with pkgs; [
        yt-dlp
        ffmpeg
    ];
    shell = "${pkgs.bashInteractive}/bin/bash";
}

