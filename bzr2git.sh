BZR_REPO="bzr"

if ! [ -d "$BZR_REPO" ]
then
   mkdir $BZR_REPO
   cd $BZR_REPO

   bzr branch lp:terminator
else
   cd $BZR_REPO
   bzr pull
fi

if [ -d ".git" ]
then
   rm -rf .git
fi

git init

bzr fast-export . | git fast-import
git checkout -f master

git remote add local ../

git log --graph --decorate --oneline --simplify-by-decoration --all --color

git push local master:newmaster
git push local --tags
# 4. Relaunch this script anytime you want to synchronize with bazaar
