
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

merge 后, 未push // 场景 , merge 后出现大量冲突, 自已不想解决, 但又退不出去
git reflog 查看最上次一次  id
git reset --hard [id]

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

### 解决使用终端执行git 命令，无权限读写的问题

<red>warning: unable to access '/Users/Mac/.config/git/attributes': Permission denied<red>


终端根目录下执行：ls -al命令查看所有文件明细：
sudo chown user-name .config

sudo chown -R $USER:$(id -gn $USER) /Users/huangzhengjie/.config

### git 设置 ALIAS 
touch .gitconfig

[alias]
st=status
ad=add
cm=commit
pl=pull
ps=push


## 如果远程库的地址修改了, 此时本地如何快速切换库的远程地址
```
git remote -v 查看库关联的远程地址
git remote remove origin 删除关联的远程地址
git remote add origin ssh://xxx.git 添加关联的远程地址
```