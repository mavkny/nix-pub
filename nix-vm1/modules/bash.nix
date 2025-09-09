{ config, lib, pkgs, ... }:

{

  programs.bash.completion.enable = true;

  environment.systemPackages = with pkgs; [
    bash-completion
    starship
  ];

  programs.bash.interactiveShellInit = ''
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    shopt -s histappend
    export HISTCONTROL=ignoreboth:erasedups
    export HISTSIZE=100000
    export HISTFILESIZE=100000

    # Starship einhängen (NixOS hat keine enableBashIntegration)
    eval "$(starship init bash)"
  '';

  programs.starship = {
    enable = true;  
    settings = {
      add_newline = true;
      format = "$username@$hostname $directory $git_branch$git_status $character";
      character = { success_symbol = "[➜](bold green) "; error_symbol = "[✗](bold red) "; };
    };
  };
}
