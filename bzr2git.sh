BZR_REPO="bzr"
GIT_UPSTREAM=upstream

if ! [ -d "$BZR_REPO" ]
then
   mkdir $BZR_REPO
   cd $BZR_REPO

   LANG=C bzr branch lp:terminator
   cd terminator
else
   cd $BZR_REPO/terminator
   LANG=C bzr pull
fi

if [ -d ".git" ]
then
   rm -rf .git
fi

git init

LANG=C bzr fast-export . | git fast-import
git checkout -f master

git remote add local ../../

git log --graph --decorate --oneline --simplify-by-decoration --all --color

git push --force local master:$GIT_UPSTREAM
git push --force local --tags
# 4. Relaunch this script anytime you want to synchronize with bazaar
