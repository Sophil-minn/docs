
### git 命令 - 代码恢复
```
add 前：放弃新增的目录及文件
git clean -nfd
git clean -fd

add后，commit 前：放弃文件及目录的修改
git co -- <file>
git co . 

commit 后：放弃一交提交
git reset -hard HEAD^ or HEAD~1
git reset –hard commitid
```

##
```
git branch -d <BranchName>
git branch -D <BranchName>
git push origin -d <BranchName>
git push origin --delete <BranchName>
git push origin :<BranchName>
```

###
```
git pull --all  #更新本地所有分支
git remote update origin --prune  #更新所有分支列表
```