# 基本状态标识
# A- = untracked 未跟踪
# A = tracked 已跟踪未修改
# A+ = modified - 已修改未暂存
# B = staged - 已暂存未提交
# C = committed - 已提交未PUSH
# 各状态之间变化
# A- -> B : git add <FILE>
# B -> A- : git rm --cached <FILE>
# B -> 删除不保留文件 : git rm -f <FILE>
# A -> A- : git rm --cached <FILE>
# A -> A+ : 修改文件
# A+ -> A : git checkout -- <FILE>
# A+ -> B : git add <FILE>
# B -> A+ : git reset HEAD <FILE>
# B -> C : git commit
# C -> B : git reset --soft HEAD^
# 修改最后一次提交:git commit --amend

g=git//不解释
ga='git add'//添加到暂存区
  *ga -u//只添加已经被版本管理的文件,区分于ga .
gaa='git add --all'
gap='git apply'
gapa='git add --patch'
gau='git add --update'
gav='git add --verbose'
gb='git branch'//列出所有本地分支
   *gb [branch-name]//新建分支,但依然停留在当前分支
   *gb [branch-name] [commit]//新建分支,指向指定commit
   *gb -r'//列出所有远程分支
   *gb --track [branch] [remote-branch]'//新建分支,与指定的远程分支建立追踪关系
gba='git branch -a'//列出所有本地和远程分支
gbD='git branch -D'
gbd='git branch -d'//删除分支
gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -r -n 1 git branch -d'
gbnm='git branch --no-merged'
gbr='git branch --remote'
gcmsg='git commit -m'
gcn!='git commit -v --no-edit --amend'
gcs='git commit -S'
gcsm='git commit -s -m'
gc='git commit -v'//提交时显示所有diff信息
gc!='git commit -v --amend'//替代上一次提交
gca='git commit -v -a'//提交工作区自上次commit之后的变化,直接到仓库区
gca!='git commit -v -a --amend'//替代上一次提交
gcam='git commit -a -m'//提交暂存区到仓库区
gcan='git commit -v -a --no-edit --amend'
gcans!='git commit -v -a -s --no-edit --amend'

gco='git checkout'
    *gco [branch]//切换到分支
    *gco - //切换到上一个分支
    *gco [file]//从暂存区覆盖工作区的文件
    *gco [commit] [file]//从某个commit拿文件覆盖暂存区和工作区
gcm='git checkout master'//切换到指定分支,并更新工作区
gcd='git checkout develop'
gcb='git checkout -b [branch-name]'//新建分支,并切换到该分支

  git restore .//放弃工作区的修改

grh='git reset [file]'//重置文件,从暂存区移回到工作区,git add的反操作(相当于从暂存区移除,不修改工作区文件)
   *grh [commit]//重置到commit节点,移除暂存区,不改变工作区,加--soft不改变暂存区,git commit的反操作
gru='git reset --'
grhh='git reset --hard'//重置暂存区与工作区,与上一次commit保持一致
groh='git reset origin/$(git_current_branch) --hard'

git cherry -v//查看未push的commit
git log origin/HEAD..HEAD//查看所有未push的commit

gbl='git blame -b -w [file]'//指定文件每一行的修改时间和人
gbs='git bisect'
gbsb='git bisect bad'
gbsg='git bisect good'
gbsr='git bisect reset'
gbss='git bisect start'
gcf='git config --list'
gcl='git clone --recurse-submodules'
gclean='git clean -fd' //删除工作区
gcount='git shortlog -sn'
gcp='git cherry-pick [commit]'//选择一个commit,合并进当前分支
gcpa='git cherry-pick --abort'
gcpc='git cherry-pick --continue'
gd='git diff'//暂存区和工作区的差异
    *gd [branch1] [branch2]//比较两个分支的具体差异
    *gd [branch1] [branch2] [filename]//比较两个分支的具体文件的具体差异
    *gd [branch1] [branch2] --stat//列出两个分支的差异文件
gdca='git diff --cached'
gdct='git describe --tags `git rev-list --tags --max-count=1`'
gdcw='git diff --cached --word-diff'
gds='git diff --staged'
gdt='git diff-tree --no-commit-id --name-only -r'
gdw='git diff --word-diff'
gf='git fetch'
gfa='git fetch --all --prune'
gfo='git fetch origin'
gg='git gui citool'
gga='git gui citool --amend'
ggpull='git pull origin "$(git_current_branch)"'
ggpush='git push origin "$(git_current_branch)"'
ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
ghh='git help'
gignore='git update-index --assume-unchanged'
gignored='git ls-files -v | grep "^[[:lower:]]"'
git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
gl='git pull'
gwch='git whatchanged -p --abbrev-commit --pretty=medium'//显示指定文件的commit历史细节
glg='git log --stat'//显示commit历史,以及每次变更的文件
glgg='git log --graph'
glgga='git log --graph --decorate --all'
glgm='git log --graph --max-count=10'
glgp='git log --stat -p'
    *glgp --follow [file]//显示指定文件的commit历史细节
glo='git log --oneline --decorate'
glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
glog='git log --oneline --decorate --graph'
gloga='git log --oneline --decorate --graph --all'
glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --all'
glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --stat'
glum='git pull upstream master'
gm='git merge [branch]'//合并指定分支到当前分支
gma='git merge --abort'
gmom='git merge origin/master'
gmt='git mergetool --no-prompt'
gmtvim='git mergetool --no-prompt --tool=vimdiff'
gmum='git merge upstream/master'
gp='git push'//上传本地分支到远程仓库
gpd='git push --dry-run'
gpf='git push --force-with-lease'
gpf!='git push --force'//强行上传本地分支到远程仓库,即使有冲突
gpoat='git push origin --all && git push origin --tags'
gpristine='git reset --hard && git clean -dfx'
gpsup='git push --set-upstream origin $(git_current_branch)'
gpu='git push upstream'
gpv='git push -v'
gr='git remote'
gra='git remote add'
grb='git rebase'//变基,push之前使用,log更好看
grba='git rebase --abort'
grbc='git rebase --continue'
grbd='git rebase develop'
grbi='git rebase -i'
grbm='git rebase master'
grbs='git rebase --skip'

grm='git rm'
grmc='git rm --cached'//从版本跟踪删除,不删除文件
grmv='git remote rename'
grrm='git remote remove'
grset='git remote set-url'
grt='cd "$(git rev-parse --show-toplevel || echo .)"'
grup='git remote update'
grv='git remote -v'
gst='git status'//显示变更文件
gsb='git status -sb'
gsd='git svn dcommit'
gsh='git show'
gsi='git submodule init'
gsps='git show --pretty=short --show-signature'
gsr='git svn rebase'
gsta='git stash save'
gstaa='git stash apply'//显示最近一次的隐藏操作,加stash编号可以选择要显示的隐藏(gstaa stash@{2})
gstall='git stash --all'
gstc='git stash clear'
gstd='git stash drop'//移除隐藏
gstl='git stash list'//查看所有隐藏文件
gstp='git stash pop'//显示隐藏内容,区别于apply的是同时会移除隐藏
gsts='git stash show --text'
gsu='git submodule update'
gts='git tag -s'
gtv='git tag | sort -V'
gunignore='git update-index --no-assume-unchanged'
gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
gup='git pull --rebase'
gupa='git pull --rebase --autostash'
gupav='git pull --rebase --autostash -v'
gupv='git pull --rebase -v'
gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
