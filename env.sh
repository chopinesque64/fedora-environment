set -e

install="sudo dnf install -y"
stow="stow --target=$HOME"
bin_dir="$HOME/bin"

# Home directory setup
rm -r ~/{Documents,Downloads,Music,Pictures,Public,Templates,Videos}
ln -s /run/media/$USER ~/media
[ -d $bin_dir ] || mkdir -p $bin_dir
mkdir -p jupyter

# Global software
$install \
    dnf-plugins-core \
    snapd \
    git \
    emacs \
    curl \
    stow \
    zsh \
    firefox \
    sdcv \
    wordnet \
    lilypond \
    dconf-editor \
    the_silver_searcher \
    evince

$install \
    libreoffice \
    gimp

sudo dnf groupinstall "Development Tools"

stow .config --target=$HOME/.config

# Conda
TEMP=$(mktemp -d)
wget -O $TEMP/conda.sh 'https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh'
$TEMP/conda.sh

# Zsh
wget -O ~/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
$stow zsh
chsh --shell $(which zsh) $USER

# Git
$stow git

# Fi$HOME$def$/
firefox=$HOME/.mozilla/firefox
defaults=$firefox/defaults/pref
mkdir -p $defaults
ln -s $PWD/firefox/autoconfig.js $defaults/
ln -s $PWD/firefox/mozilla.cfg $firefox/

# Docker
sudo dnf remove docker \
     docker-client \
     docker-client-latest \
     docker-common \
     docker-latest \
     docker-latest-logrotate \
     docker-logrotate \
     docker-selinux \
     docker-engine-selinux \
     docker-engine
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
$install docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER
newgrp docker
sudo systemctl enable --now docker

# Rust
type rustup >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | zsh
rustup toolchain add nightly
cargo +nightly install racer
rustup component add rust-src

# Rhythmbox
dconf load /org/gnome/rhythmbox/ < dconf/rhythmbox.dconf

# Xreader
dconf load /org/x/reader/ < dconf/xreader.dconf

# Node.js
curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
sudo dnf install -y nodejs

# Jupyter Lab
pip install jupyterlab --user

# Teams for Linux
sudo snap install teams-for-linux

# Chrome
$install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
$install google-chrome-stable

# Dropbox
$install 'https://linux.dropbox.com/packages/fedora/nautilus-dropbox-2019.02.14-1.fedora.x86_64.rpm'
read -p "Press RET once Dropbox has synced all files..."
ln -s $HOME/Dropbox/org $HOME/org

# Cinnamon
ln -s $HOME/org/wall.jpg $HOME/
ln -s $HOME/org/face $HOME/
dconf load /org/cinnamon/ < dconf/cinnamon.dconf
dconf load /org/gnome/ < dconf/gnome.dconf
dconf load /org/nemo/ < dconf/nemo.dconf

# Emacs
sudo ln -s /usr/share/applications/emacs.desktop ~/.config/autostart/
cd ~/org/data/d0/26d375-2725-4f1e-9aae-153f9e886b6f/emacs.d
$stow emacs
cd -

# Stardict
ln -s $HOME/org/data/83/26ca46-77b6-44f3-9907-e7a820ac3ae6/.stardict $HOME/

# TeX Live
TEMP=$(mktemp -d)
wget -qO- 'http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz' | tar -C $TEMP -xvz --strip-components=1
$TEMP/install-tl -profile texlive.profile

texmf_dir=$HOME/texmf/tex/latex
mkdir -p $texmf_dir
cd $HOME/org/data/b6/5cc287-4ab8-414f-92d0-d7e74d84ed9d/tex-a-tac
stow local --target=$texmf_dir
cd -

# Web-ext
npm install web-ext

# VirtualBox
$install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras

cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/29/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF

sudo dnf search virtualbox
$install VirtualBox-6.1
sudo usermod -a -G vboxusers $USER
newgrp vboxusers

# KVM
sudo dnf -y install bridge-utils libvirt virt-install qemu-kvm \
     virt-top libguestfs-tools \
     virt-manager

sudo systemctl enable --now libvirtd

# Gestures
sudo dnf install xdotool wmctrl

# Zotero
zotero="~/zotero"
wget -qO- 'https://download.zotero.org/client/release/5.0.84/Zotero-5.0.84_linux-x86_64.tar.bz2' | tar -C $zotero -xvj --strip-components=1
$zotero/set_launcher_icon
sudo ln -sf $zotero/zotero.desktop /usr/share/applications/

# SageMath
wget http://mirrors.mit.edu/sage/linux/64bit/sage-9.0-Debian_GNU_Linux_10-x86_64.tar.bz2 | tar -C $HOME -xvj
jupyter kernelspec install --user ~/SageMath/local/share/jupyter/kernels/sagemath

# R/RStudio
$install 'https://download1.rstudio.org/desktop/fedora28/x86_64/rstudio-1.2.5033-x86_64.rpm'
$install R
