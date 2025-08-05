#!/bin/bash
# Bash Script for install MrF3RDI tools
# Must run to install tool

clear
echo "
  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. 
 | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
 | | ____    ____ | || |  _______     | || |              | || |  _________   | || |    ______    | || |  _______     | || |  ________    | || |     _____    | |
 | ||_   \  /   _|| || | |_   __ \    | || |              | || | |_   ___  |  | || |   / ____ `.  | || | |_   __ \    | || | |_   ___ `.  | || |    |_   _|   | |
 | |  |   \/   |  | || |   | |__) |   | || |              | || |   | |_  \_|  | || |   `'  __) |  | || |   | |__) |   | || |   | |   `. \ | || |      | |     | |
 | |  | |\  /| |  | || |   |  __ /    | || |              | || |   |  _|      | || |   _  |__ '.  | || |   |  __ /    | || |   | |    | | | || |      | |     | |
 | | _| |_\/_| |_ | || |  _| |  \ \_  | || |      _       | || |  _| |_       | || |  | \____) |  | || |  _| |  \ \_  | || |  _| |___.' / | || |     _| |_    | |
 | ||_____||_____|| || | |____| |___| | || |     (_)      | || | |_____|      | || |   \______.'  | || | |____| |___| | || | |________.'  | || |    |_____|   | |
 | |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |
 | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 
";

sudo chmod +x uninstall

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/MrF3RDI"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/MrF3RDI"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.MrF3RDI"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory MrF3RDI was found! Do you want to replace it? [Y/n]:" ;
    read -r mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/MrF3RDI*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/MrF3RDI*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/MrF3RDI" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/MrF3RDI"
    else
        sudo rm -rf "$ETC_DIR/MrF3RDI"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/Ferdibrgll/MrF3RDI "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/MrF3RDI.py" "${1+"$@"}" > "$INSTALL_DIR/MrF3RDI";
chmod +x "$INSTALL_DIR/MrF3RDI";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/MrF3RDI" "$BIN_DIR"
    cp "$INSTALL_DIR/MrF3RDI.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/MrF3RDI" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/MrF3RDI.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/MrF3RDI";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing MrF3RDI !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
