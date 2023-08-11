#!/bin/bash
# just my few commands to set up a basic working system
# beware: at this time this only works on ubuntusystems
# this fire and forget! it will replace any authorized_keys file!
# 
# if it matures from a quick and easy setup to something more
# i will possibly also include some safety-measures, but until then:
#
# KNOW WHAT YOU ARE DOING!
# ########################

cd ~

# update installation
sudo apt update

# install necessary and other useful tools
sudo apt install git build-essential gettext cmake mc termshark tmux htop neofetch

# get my configs
#git clone https://github.com/aibix0001/cfg

# configure tmux
cp cfg/tmux/.tmux.conf ~
mkdir ~/.tmux
# get tmux plugin manager (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# get and build current version of neovim
# (current stable in debian/ubuntu is quite old)
# this should be fairly quick on reasonable new systems
git clone https://github.com/neovim/neovim.git
cd ~/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# set neovim as default editor
# this affects things like crontab, visudo and so on
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 10

# setup neovim with nvchad customizations in one go
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# import ssh public keys
mkdir ~/.ssh
cd ~
tee .ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB/CrXjnWXMeatom73hQgr5epm6IMKJGQgZLQ6461NXkLvbS4D3MYDKGkFd8x1qyEYKRc2iZ4HFVfI+TamN0Vm1aPOAW/YmRmGuUbywsNrRqsE8WHtmnb1G9h42DxpOBfri/bmbwX4I1D/XUWPqazu1OvVWXwnskJh5NiZ5OZw9I21TSuIG8WrCBJLK9/tuQ3qLVpq3oYny/OLuq3lxf/wA0Ga8OzutHS+XDePYf0ZI6MbEIDPTk34TS3D1hbcEAeySli4CXdYq5tStqku01/7yvYl6LBJZTj2/Vq104uXIRCV5eYHBKqsjdhx2mwmnL7/nivpAR/eSUfgYJPg4KtCppk/8ZgDfvMWAY3XfQPwWYV5pVZQt9pZvdY4dUwqN5nzdabZbFipwwMz1Z8MjrEQ6cdVmvNP9WhZWk6sp7Hy3PoYnW9/iBAnoNI8O4HvpQK064F6Zs6vkT/+EIsVNjY1EqpOt4f4eNg3PD/Z/FtiVF5Ia9yFFTazx5jzfHWK4Es= gerd@bronco
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnF96HqxqaNl73bQoJzAHR12LVnTjtwiE2a+tYu/4q1cEaC6k3mvRw/+ts4t4k9hmmh543tQcaiQ4JnDS5EzVu5uTD0iruLkgQYLqcgoCa91BSQegmQlcNEPi7ArHqYgdE1cTNmM55VuMfwuXgQLmgseo+M49SL7Y789liDPekC8bzutqwW508VEp2CEcwMKGuKZkmOS7DkPAsLdSTREWbuXAUnh4kuFKSRfdxZc0UuofC0mCJ6utjdd3HTgLWSrBlUnAOo984yxHY9L6DxZ7gYNQsFj4pFCmYGWELNNecG8pEFtmGizg9YKkZLnyB0dePDDnehd2RSZstvkzfo/QkdCsB7TvMhqdu7AXve3ogmII/nYyhQ6UpUksIqN1HwzyQiD1xBQzCVUVsCXIuJLnuJjm832xw2ZBGShkjHv3m0xXvsVvGoxvC5cOpgmf7tiyvGqMYx0uExkXx+VKlgOcCJjuCa19GwwCbnkfiXSGBoqsRaT8z8GHT7j7FYY8MKEM= gerd@wasabi
EOF

echo "all done. enjoy! :)"
