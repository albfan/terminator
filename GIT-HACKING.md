# Cloning notes

Since terminator is keep on bzr, updates to this mirror are done with `git fast-import`

1. Clone original bzr repo

        $ bzr branch lp:terminator

 If already cloned, just update

        $ bzr pull

2. Do a export to git from bzr.

 If already exported, remove git repo 

        $ rm -rf .git/ 

 Start git repo

        $ git init

 And export
 
        $ bzr fast-export --plain . | git fast-import

3. Fetch new git clone on real repo

        $ git remote add local file://<path-to-git-import>
        $ git fetch local

 Last common commit can be detected using

       $ git log --color --date-order --date=local --graph --format=\"%C(auto)%h%Creset %C(blue bold)%ad%Creset %Cgreen%an %C(auto)%d%Creset %s\" --all

  I use an alias for that `git logdra`. More on log alias on [stackoverflow](http://stackoverflow.com/a/22875140/848072) and [my dotfiles](https://github.com/albfan/dotfiles/blob/master/gitconfig#L16)

 Example

        * local/master <new-import>
        *
        *
        | * master <changes to default project>
        | *
        * | <common-new-commit>
        | * <common-old-commit>
        * |
        | *

 And rebasing with

        $ git rebase <commom-new-commit> local/master --onto <common-old-commit>

 Resulting on

            * (HEAD)
            *
            *
        *   | local/master <new-import>
        *   |
        *   |
        | * | master <changes to default project>
        | * |
        * |/ <common-new-commit>
        | * <common-old-commit>
        * |
        | *

 Remove local remote and finish

          * (HEAD)
          *
          *
        * | master <changes to default project>
        * |
        |/ 
        * <common-old-commit>
        |
        *

 From here rebase master, merge or whatever you want

4. There's a problem with launchpad workflow. There are some commits for releases that have no email author and that's problematic on git. Execute [replace-authors-without-email.sh](res/replace-authors-without-email.sh)

    $ . res/replace-authors-without-email.sh

 To detect and fix that commits.

