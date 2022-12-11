#!/bin/bash
# The core comes from Mohist
# version:1.2.0
# The script comes from BlackCat and GuGuGe
# The script is suitable for Centos 7 and Xshell terminal

# format output date
Now_Date=$(date "+%Y-%m-%d %H:%M:%S")

# User permission detection
if [[ $(id -u) -ne 0 ]]; then
    printf "请使用 root 账户运行该脚本\n"
    echo "[${Now_Date}]Please Use ROOT to Run!" >>./run.log
    exit
fi

# Prompt the user to enter the installation address
read -r -e -p "输入安装地址(/Directory):" format
Install_Directory=${format%%/}
if [[ ! -e ${Install_Directory} ]]; then
    mkdir -p "${Install_Directory}"
fi

# Install the base build software
yum -y update && yum -y install vim tmux lrzsz lsof wget net-tools

# Check if the core is downloaded successfully
server_pwd=$(find "${Install_Directory}" -name server.jar | grep server.jar)

# No. 1 related operation function
function NumsOne() {
    yum -y install java-1.8.0-openjdk-devel.x86_64
    if [[ ! -e ${server_pwd} ]]; then
        wget -c "https://cloud.xiaoyi.ink/d/ServerSoft/mohist-1.12.2-320-server.jar" -O "${Install_Directory}"/server.jar
    fi
    return $?
}

# No. 2 related operation function
function NumsTwo() {
    yum -y install java-11-openjdk-devel.x86_64
    if [[ ! -e ${server_pwd} ]]; then
        wget -c 'https://cloud.xiaoyi.ink/d/ServerSoft/mohist-1.16.5-1091-server.jar' -O "${Install_Directory}"/server.jar
    fi
    return $?
}

# Create a virtual terminal
function Tmux_Begin() {
    if ! tmux has-session -t McManager; then
        # McManager:0.0 执行运行服务器命令
        tmux new-session -s McManager -n status -d
        # McManager:0.1 执行 状态监视命令
        tmux split-window -v -p 20 -t McManager
        # McManager:0.2 执行查看当前用户命令
        tmux split-window -h -p 25 -t McManager:0.1
        # McManager:0.3 执行输入命令
        tmux split-window -h -p 40 -t McManager:0.0

        # McManager:0.0 执行 java -jar server.jar
        tmux send-keys -t McManager:0.0 "cd ${Install_Directory} && java -jar ${Install_Directory}/server.jar" Enter
        tmux send-keys -t McManager:0.1 'mcm status' Enter
        tmux send-keys -t McManager:0.2 'echo "当前连接用户"' Enter
        tmux send-keys -t McManager:0.3 'mcm access' Enter
    fi
}

# Prompt the user to choose the version to install
printf "\e[1;32m请选择安装游戏的内核版本：\e[0m\n"
printf "\e[1;32m注意！！！\e[0m\e[1;0m游戏版本并不是服务器内核版本！！！\e[1;0m\n"
printf "1)1.12.2\t"
printf "2)1.16.5\n"
read -r -p "选择版本序号：" -n 2 Nums_Version

# Use loops to prevent users from typing indiscriminately
while :; do
    case ${Nums_Version} in
    '1')
        NumsOne
        if ! echo $?; then
            echo "[${Now_Date}]Error Setting 1.12.2 Core" >>./run.log
        else
            echo "[${Now_Date}]Setting Success 1.12.2" >>./run.log
        fi
        break
        ;;
    '2')
        NumsTwo
        if ! echo $?; then
            echo "[${Now_Date}]Error Setting 1.16.5 Core" >>./run.log
        else
            echo "[${Now_Date}]Setting Success 1.16.5" >>./run.log
        fi
        break
        ;;
    *)
        read -r -p "请输入正确的版本序号:" -n 2 Nums_Version
        echo "[${Now_Date}]User Choose ERROR" >>./run.log
        ;;
    esac
done

# The basic environment is built and the Mohist terminal is installed
if [[ -e "/usr/bin/mcm" ]]; then
    rm -rf /usr/bin/mcm
fi
mv "$(find / -name mcm)" /usr/bin/mcm && chmod 755 /usr/bin/mcm
sed -ri "s|^(Install_Directory).*|\1=\"${Install_Directory}\"|" /usr/bin/mcm
if ! grep ".*mcm.*" "${HOME}"/.bashrc; then
    echo "# McManager Menu 
alias mcm='sh /usr/bin/mcm' " >>"${HOME}"/.bashrc
fi
if ! tmux ls | grep McManager; then
    Tmux_Begin
fi
if [[ ! -e /etc/systemd/system/mcm.service ]]; then
    touch /etc/systemd/system/mcm.service
    chmod 755 /etc/systemd/system/mcm.service
    cat >>/etc/systemd/system/mcm.service <<EOF
[Unit]
Description=McServer enable Service
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/mcm start
ExecStop=/usr/bin/mcm stop
KillMode=process
Restart=on-abnormal
[Install]
WantedBy=multi-user.target
EOF
else
    rm -rf /etc/systemd/system/mcm.service
    touch /etc/systemd/system/mcm.service
    chmod 755 /etc/systemd/system/mcm.service
    cat >>/etc/systemd/system/mcm.service <<EOF
[Unit]
Description=McServer enable Service
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/mcm start
ExecStop=/usr/bin/mcm stop
KillMode=process
Restart=on-abnormal
[Install]
WantedBy=multi-user.target
EOF
fi
b=''
for ((i = 0; i <= 100; i += 1)); do
    printf "正在配置服务器:[%-100s]%d%%\r" "$b" $i
    sleep 1.5
    b=">$b"
done
echo "服务器启动完成>>>>"
tmux send-keys -t McManager:0.0 'true' Enter
echo "[${Now_Date}]Install Over~" >>./run.log
printf "======================Mc Manager For TUI================================\n"
printf "\t在您看到这条信息的时候，你已经可以使用 mcm 来进行管理啦~\n"
printf "\t记得在 mcm 菜单中选择[管理后台]选项哦~~~\n"
printf "\t我的世界服务器已部署完成，其他配置请输入 mcm 来继续进行操作1\n"
printf "\t\t\t感谢使用~~~~\n"
printf "========================================================================\n"
sleep 5
tmux attach -t McManager
