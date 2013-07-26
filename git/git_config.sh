
GIT_CONFIG_FLAG=$FLAGS_DIR/.git

if [ -f $GIT_CONFIG_FLAG ]; then
  echo "Git config is already processed"
else
  git config --global user.name "Ignacio Rossi";
  git config --global user.email "rossi.ignacio@gmail.com";
  git config --global push.default current;
  git config --global core.editor vim;
  git config --global color.ui true;
  git config --global merge.conflictstyle diff3;
  touch $GIT_CONFIG_FLAG
fi
