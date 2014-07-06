
GIT_CONFIG_FLAG=$FLAGS_DIR/.git-config

if [ -f $GIT_CONFIG_FLAG ]; then
  echo "Git config is already processed. Flag:$GIT_CONFIG_FLAG"
else
  git config --global user.name "Ignacio Rossi";
  git config --global user.email "rossi.ignacio@gmail.com";
  git config --global push.default current;
  git config --global core.editor vim;
  git config --global color.ui true;
  git config --global merge.conflictstyle diff3;
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
  echo "Creating flag $GIT_CONFIG_FLAG"
  touch $GIT_CONFIG_FLAG
fi
