{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Dryyy";
        email = "your-email@example.com";
      };
      
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
