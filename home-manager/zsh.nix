{ inputs, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
        { name = "zsh-users/zsh-completions"; tags = [ "as:plugin" ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; tags = [ "as:plugin" ]; }
        { name = "momo-lab/zsh-abbrev-alias"; tags = [ ]; }
        { name = "hlissner/zsh-autopair"; tags = [ ]; }
        { name = "Tarrasch/zsh-bd"; tags = [ ]; }
        #{ name = ""; tags = [  ]; }
      ];
    };
    initExtraFirst = ''
      		    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      		      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      		    fi
      		'';
    initExtra = ''
      		    abbrev-alias --init
      		    for file in ''${XDG_CONFIG_HOME:-$HOME/.config}/zsh/*(.); source $file

              # list files when switching directories
              function auto_cdls(){
                  emulate -L zsh
                  eza --group-directories-first
              }
              chpwd_functions=(''${chpwd_functions[@]} "auto_cdls")
              bindkey "''${key[Up]}" up-line-or-search
      		'';
    autocd = true;
    enableVteIntegration = true;
    defaultKeymap = "viins";
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      save = 50000;
      size = 50000;
    };
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
  };
}



