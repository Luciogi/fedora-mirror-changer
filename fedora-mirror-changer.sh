#!/bin/sh

# Get Mirror Link from User, Store in Variable
input() {
read -p "Paste Mirror Link:" link
}

addr="/etc/yum.repos.d"

# Take Backup of original files
backup() {
# sudo mkdir backup && sudo cp * ./backup/
mkdir -p $addr/backup && cp $addr/fedora* $addr/backup/
echo -e "--> Backup \e[32mDone\e[0m"
}

#  Modify repo files at /etc/yum.repos.d/
fedora() {
    sed -i -e 's#os/#os/\nbaseurl='$link'releases/$releasever/Everything/$basearch/os#' -e '/^metalink/ s/metalink=/#metalink=/' $addr/fedora.repo
    sed -i 's#debug/tree/#debug/tree/\nbaseurl='$link'releases/$releasever/Everything/$basearch/debug/tree#'  $addr/fedora.repo
    sed -i 's#source/tree/#source/tree/\nbaseurl='$link'releases/$releasever/Everything/source/tree#'  $addr/fedora.repo
    echo -e "--> \e[32mUpdated\e[0m fedora.repo"
}

fedora_updates() {
    sed -i -e '/^#baseurl/ s#basearch/#basearch/\nbaseurl='$link'updates/$releasever/Everything/$basearch#' -e '/^metalink/ s/metalink=/#metalink=/' $addr/fedora-updates.repo
    sed -i 's#/debug/#/debug/\nbaseurl='$link'updates/$releasever/Everything/$basearch/debug#'  $addr/fedora-updates.repo
    sed -i 's#SRPMS/#SRPMS/\nbaseurl='$link'updates/$releasever/Everything/source/tree#'  $addr/fedora-updates.repo
    echo -e "--> \e[32mUpdated\e[0m fedora-updates.repo"
    # Testing branch
    sed -i -e '/^#baseurl/ s#basearch/#basearch/\nbaseurl='$link'updates/testing/$releasever/Everything/$basearch#' -e '/^metalink/ s/metalink=/#metalink=/' $addr/fedora-updates-testing.repo
    sed -i 's#/debug/#/debug/\nbaseurl='$link'updates/testing/$releasever/Everything/$basearch/debug#' $addr/fedora-updates-testing.repo
    sed -i 's#SRPMS/#SRPMS/\nbaseurl='$link'updates/testing/$releasever/Everything/source/tree#' $addr/fedora-updates-testing.repo
    echo -e "--> \e[32mUpdated\e[0m fedora-updates-testing.repo"

}

fedora_updates_modular() {
    sed -i -e '/^#baseurl/ s#Modular/$basearch/#Modular/$basearch/\nbaseurl='$link'updates/$releasever/Modular/$basearch#' -e '/^metalink/ s/metalink=/#metalink=/' $addr/fedora-updates-modular.repo
    sed -i 's#$basearch/debug/#$basearch/debug/\nbaseurl='$link'updates/$releasever/Modular/$basearch/debug#' $addr/fedora-updates-modular.repo
    sed -i 's#SRPMS/#SRPMS/\nbaseurl='$link'updates/$releasever/Modular/source/tree/#' $addr/fedora-updates-modular.repo
    echo -e "--> \e[32mUpdated\e[0m fedora-updates-modular.repo"
    # Testing branch
    sed -i -e '/^#baseurl/ s#Modular/$basearch/#Modular/$basearch/\nbaseurl='$link'updates/testing/$releasever/Modular/$basearch#' -e '/^metalink/ s/metalink=/#metalink=/' $addr/fedora-updates-testing-modular.repo
    sed -i 's#$basearch/debug/#$basearch/debug/\nbaseurl='$link'updates/testing/$releasever/Modular/$basearch/debug#' $addr/fedora-updates-testing-modular.repo
    sed -i 's#SRPMS/#SRPMS/\nbaseurl='$link'updates/testing/$releasever/Modular/source/tree/#' $addr/fedora-updates-testing-modular.repo
    echo -e "--> \e[32mUpdated\e[0m fedora-updates-testing-modular.repo"

}

fedora_modular() {
    sed -i -e 's#os/#os/\nbaseurl='$link'releases/$releasever/Modular/$basearch/os#' -e '/^metalink/ s/metalink=/#metalink=/'  $addr/fedora-modular.repo
    sed -i 's#/debug/tree/#/debug/tree/\nbaseurl='$link'releases/$releasever/Modular/$basearch/debug/tree/#' $addr/fedora-modular.repo
    sed -i 's#source/tree/#source/tree/\nbaseurl='$link'releases/$releasever/Modular/source/tree#' $addr/fedora-modular.repo
    echo -e "--> \e[32mUpdated\e[0m fedora-modular.repo"

}

# Restore backup
restore() {
    cp -f $addr/backup/* $addr
    echo -e "--> Restore \e[32mdone\e[0m"
}

# Display Options
echo "1.Change Mirror (Select this for first time)"
echo "2.Update Mirror"
echo "3.Restore (Revert changes made by this script)"

# Variable for Case EXPRESSION
read  -p "Choose option:" exp
case $exp in
    1)
        backup
        input
        fedora
        fedora_updates
        fedora_updates_modular
        fedora_modular
        ;;
    2)
        input
        restore
        fedora
        fedora_updates
        fedora_updates_modular
        fedora_modular
        ;;
    3)
        restore
        ;;
esac
