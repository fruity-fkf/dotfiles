{ pkgs, lib, ... }:
{

  #      the standard path under ~/.config/ 
  #           to find the file       Where the file is located relative to this .nix file
  #                    |                             |
  #                    V                             V
  xdg.configFile."starship.toml".source = ./starship.toml;

  home.packages = with pkgs; [
    pkgs.fishPlugins.autopair
    fishPlugins.fzf-fish
  ];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # tmux.enableShellIntegration = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "fruity-fkf";
    userEmail = "fruity.fkf@proton.me";

    extraConfig = {
      # pull = {
      #   rebase = true;
      # };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # programs.starship = {
  #   enable = true;
  #   # Configuration written to ~/.config/starship.toml
  #   settings = {
  #     add_newline = true;
  #
  #     character = {
  #       success_symbol = "[➜](bold green)";
  #       error_symbol = "[➜](bold red)";
  #     };
  #     # package.disabled = true;
  #   };
  # };
  #
  # programs.starship = {
  #   enable = true;
  #   enableFishIntegration = true;
  #   settings = {
  #     add_newline = true;
  #     hostname.style = "bold green"; # don"t like the default
  #     username.style_user = "bold blue"; # don"t like the default
  #     format = lib.concatStrings [
  #       "$all"
  #       "$line_break"
  #       "$package"
  #       "$line_break"
  #       "$character"
  #       "$username"
  #     ];
  #     scan_timeout = 2000;
  #     character = {
  #       success_symbol = "➜";
  #       error_symbol = "➜";
  #     };
  #   };
  #   enableTransience = true;
  # };

  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    # for editing directly to config.nu 
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
       show_banner: false,
       completions: {
       case_sensitive: false # case-sensitive completions
       quick: true    # set to false to prevent auto-selecting completions
       partial: true    # set to false to prevent partial filling of the prompt
       algorithm: "fuzzy"    # prefix or fuzzy
       external: {
       # set to false to prevent nushell looking into $env.PATH to find more suggestions
           enable: true 
       # set to lower can improve completion performance at the cost of omitting some options
           max_results: 100 
           completer: $carapace_completer # check 'carapace_completer' 
         }
       }
      } 
      $env.PATH = ($env.PATH | 
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )
    '';
    shellAliases = {
      vi = "hx";
      vim = "hx";
      nano = "hx";
    };
  };
  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

}