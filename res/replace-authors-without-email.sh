#!/bin/bash

# replace empty emails

git filter-branch --env-filter '
if test "$GIT_AUTHOR_EMAIL" = ""
then
   GIT_AUTHOR_EMAIL=Unknow
   export GIT_AUTHOR_EMAIL
fi
if test "$GIT_COMMITTER_EMAIL" = ""
then
   GIT_COMMITTER_EMAIL=Unknow
   export GIT_COMMITTER_EMAIL
fi
'

