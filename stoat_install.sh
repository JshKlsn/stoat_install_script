# You can edit all these variables to customize your installation

VERSION="1.3.0" # Please make sure this is the latest release available. I wont update the script every time.
INSTALL_PATH="$HOME/.local/bin/"
FILE="Stoat-linux-x64-$VERSION.zip"
RELEASE_URL="https://github.com/stoatchat/for-desktop/releases/download/v$VERSION/Stoat-linux-x64-$VERSION.zip"
ICON_URL="https://raw.githubusercontent.com/stoatchat/assets/refs/heads/main/desktop/icon.ico"
ICON_PATH="$INSTALL_PATH/Stoat-linux-x64/icon.ico"
DESKTOP_FILE="$HOME/.local/share/applications/stoat.desktop"

# Do not edit this unless you know what you are doing

echo "Welcome to this basic Stoat install/update script for linux."
echo "Be sure to have chromium and all the required dependencies installed before proceeding."
echo ""
echo "Version $VERSION will be downloaded and installed / updated. This can be changed in the beginning of the script."
echo "Please check for new versions at https://github.com/stoatchat/for-desktop/releases/"
echo ""
read -sp "Continue ? (Y/n): " ask
if [ "$ask" = "n" ]; then
    echo "Exiting."
    exit
fi
output=""
wget -O $FILE $RELEASE_URL && echo "Downloaded $FILE" && output="success" || output="failed"
if [ "$output" != "success" ]; then
    echo "Download failed. Check for release version or contact me for a fix."
    rm -rf $FILE
    echo "Exiting..."
    exit
fi
echo "Downloaded $FILE successfully."
unzip -o $FILE -d $INSTALL_PATH
echo "Version $VERSION installed."
echo "Downloading icon..."
wget -O $ICON_PATH $ICON_URL
echo "Creating entry for application..."
echo "[Desktop Entry]" > $DESKTOP_FILE
echo "Type=Application" >> $DESKTOP_FILE
echo "Name=Stoat" >> $DESKTOP_FILE
echo "GenericName=Stoat" >> $DESKTOP_FILE
echo "Comment=Open source user-first chat platform." >> $DESKTOP_FILE
echo "Icon=$ICON_PATH" >> $DESKTOP_FILE
echo "Exec=$INSTALL_PATH/Stoat-linux-x64/stoat-desktop" >> $DESKTOP_FILE
echo "Categories=Network;InstantMessaging;" >> $DESKTOP_FILE
echo "Terminal=false" >> $DESKTOP_FILE
echo "Keywords=Chat;Messaging;Stoat;" >> $DESKTOP_FILE
echo ""
echo "Installation/update complete. You can now launch Stoat."
