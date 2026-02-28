INSTALL_PATH="$HOME/.local/bin/"
INSTALLED_VERSION="$INSTALL_PATH/Stoat-linux-x64/installed-version.txt"
ICON_PATH="$INSTALL_PATH/icon.ico"

echo -e "\e[1;95mStoat updater/installer."
echo -e "\e[1;92mChecking for updates.."
VERSION=$(curl -s https://github.com/stoatchat/for-desktop | grep -oP '(?<=v)[0-9]+\.[0-9]+\.[0-9]+' | head -1)

if [ -z "$VERSION" ]; then
    echo -e "\e[1;91mError: Unable to retrieve the latest version.\e[0m"
    exit 1
fi

echo ""
echo -e "\e[1;93mThe latest version is $VERSION. You have $(< "$INSTALLED_VERSION") installed.\e[0m"
echo ""

read -p "Continue? (Y/n): " ask
if [[ "$ask" == "n" ]]; then
    echo "Exiting."
    exit 0
fi

FILE="Stoat-linux-x64-$VERSION.zip"
RELEASE_URL="https://github.com/stoatchat/for-desktop/releases/download/v$VERSION/$FILE"
ICON_URL="https://raw.githubusercontent.com/stoatchat/assets/refs/heads/main/desktop/icon.ico"
DESKTOP_FILE="$HOME/.local/share/applications/stoat.desktop"

echo -e "\e[1;93mBe sure to have Chromium and all the required dependencies installed before proceeding.\e[0m"
echo ""
read -p "Continue? (Y/n): " ask
if [[ "$ask" == "n" ]]; then
    echo "Exiting."
    exit 0
fi

if ! wget -O "$FILE" "$RELEASE_URL"; then
    echo "Download failed. Check your internet connection and try again."
    exit 1
fi

echo "Downloaded $FILE"

if ! unzip -o "$FILE" -d "$INSTALL_PATH"; then
    echo "Extraction failed. Make sure you have unzip installed."
    rm -f "$FILE"
    exit 1
fi

echo -e "\e[1;93mVersion $VERSION installed.\e[0m"
echo -e "\e[1;92mDownloading icon...\e[0m"

if ! wget -O "$ICON_PATH" "$ICON_URL"; then
    echo "Icon download failed. Please check the URL."
    exit 1
fi

echo -e "\e[1;92mAdding Stoat to application launcher..\e[0m"

echo "$VERSION" | sudo tee "$INSTALLED_VERSION" > /dev/null


cat <<EOL | sudo tee "$DESKTOP_FILE" > /dev/null
[Desktop Entry]
Version=$VERSION
Type=Application
Name=Stoat
GenericName=Stoat
Comment=Open source user-first chat platform.
Icon=$ICON_PATH
Exec=$INSTALL_PATH/Stoat-linux-x64/stoat-desktop
Categories=Network;
Terminal=false
Keywords=Chat;Messaging;Stoat;Discord;
EOL

echo ""
echo -e "\e[1;94mInstallation/update complete. You can now launch Stoat. You can also run this script again to check for and apply updates."
