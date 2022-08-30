##### 常规安装
```bash
# 依赖zsh和git，https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### 自动补全配置和语法高亮配置
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

vim ~/.zsh
# 新增插件配置
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```
