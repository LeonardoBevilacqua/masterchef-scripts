{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "masterchef-script-shell";
    buildInputs = with pkgs; [
        yt-dlp
        ffmpeg
	mkvtoolnix-cli
    ];
    shell = "${pkgs.bashInteractive}/bin/bash";
}

