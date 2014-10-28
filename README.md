## my vimrc

### 安装 ctags 和 cscope
```bash
sudo apt-get install exuberant-ctags
sudo apt-get install cscope
```

### 下载
```bash
git clone https://github.com/hmgle/gle_vimrc.git ~/.vim
```

### 创建 vimrc
```bash
ln -s ~/.vim/vimrc ~/.vimrc
```

### 安装 vundle 及插件
```bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qa
```
