# Why this script exist?
Dnf do not choose mirrors based on speed, rather it choose mirrors based on latency. Most of time, mirrors chosen by dnf are too slow like 🐢
# Dependencies
`sed`
# HOW TO Use it?
## **I will not be responsible if this script damage your system. Use at your own risk.**

1. Download script
```
git clone https://github.com/Luciogi/fedora-mirror-changer.git
```
2. Make script executable
```
cd fedora-mirror-changer/ && chmod +x fedora-mirror-changer.sh
```
3. Copy link of any mirror ([Mirrorlist](https://admin.fedoraproject.org/mirrormanager/))
4. Execute script with root privileges i.e sudo , doas
```
sudo ./fedora-mirror-changer.sh
```
NOTE: Do not select second option **Update Mirror** for first time, because it will not take any backup of default files.
