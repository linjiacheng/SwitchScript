#!/bin/sh
set -e

### Credit to the Authors at https://rentry.org/CFWGuides
### Script created by Fraxalotl
### Mod by huangqian8

# -------------------------------------------

### Create a few new folders for storing files
if [ -d Copy_to_SD ]; then
  rm -rf Copy_to_SD
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi

mkdir -p Copy_to_SD
cd Copy_to_SD

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases
curl -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases \
  | jq '.[0].name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases \
  | jq '.[0]' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*atmosphere[^"]*.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o atmosphere.zip
if [ $? -ne 0 ]; then
    echo "atmosphere download\033[31m failed\033[0m."
else
    echo "atmosphere download\033[32m success\033[0m."
    unzip -oq atmosphere.zip
    rm atmosphere.zip
fi

### Fetch Hekate + Nyx CHS from https://github.com/easyworld/hekate/releases/latest
curl -sL https://api.github.com/repos/easyworld/hekate/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/easyworld/hekate/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*hekate_ctcaer[^"]*_sc.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o hekate.zip
if [ $? -ne 0 ]; then
    echo "Hekate + Nyx CHS download\033[31m failed\033[0m."
else
    echo "Hekate + Nyx CHS download\033[32m success\033[0m."
    unzip -oq hekate.zip
    ### Rename hekate_ctcaer_*.bin to payload.bin
    find . -name "*hekate_ctcaer*" -exec mv {} payload.bin \;
    if [ $? -ne 0 ]; then
        echo "Rename hekate_ctcaer_*.bin to payload.bin\033[31m failed\033[0m."
    else
        echo "Rename hekate_ctcaer_*.bin to payload.bin\033[32m success\033[0m."
    fi
    rm hekate.zip
fi

### Fetch Sigpatches from https://gbatemp.net/threads/sigpatches-for-atmosphere-hekate-fss0-fusee-package3.571543/
curl -sL "https://raw.githubusercontent.com/linjiacheng/SwitchScript/main/plugins/sigpatches.zip" -o sigpatches.zip
if [ $? -ne 0 ]; then
    echo "sigpatches download\033[31m failed\033[0m."
else
    echo "sigpatches download\033[32m success\033[0m."
    echo sigpatches  >> ../description.txt
    unzip -oq sigpatches.zip
    rm sigpatches.zip
fi

mkdir -p ./bootloader/payloads

### Fetch latest fusee.bin from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
curl -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*fusee.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o fusee.bin
if [ $? -ne 0 ]; then
    echo "fusee download\033[31m failed\033[0m."
else
    echo "fusee download\033[32m success\033[0m."
    mv fusee.bin ./bootloader/payloads
fi

### Fetch latest Lockpick_RCM.bin from https://github.com/zdm65477730/Lockpick_RCMDecScots/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
if [ $? -ne 0 ]; then
    echo "Lockpick_RCM download\033[31m failed\033[0m."
else
    echo "Lockpick_RCM download\033[32m success\033[0m."
    mv Lockpick_RCM.bin ./bootloader/payloads
fi

### Fetch latest TegraExplorer.bin from https://github.com/zdm65477730/TegraExplorer/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*TegraExplorer.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o TegraExplorer.bin
if [ $? -ne 0 ]; then
    echo "TegraExplorer download\033[31m failed\033[0m."
else
    echo "TegraExplorer download\033[32m success\033[0m."
    mv TegraExplorer.bin ./bootloader/payloads
fi

### Fetch latest CommonProblemResolver.bin from https://github.com/zdm65477730/CommonProblemResolver/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*CommonProblemResolver.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o CommonProblemResolver.bin
if [ $? -ne 0 ]; then
    echo "CommonProblemResolver download\033[31m failed\033[0m."
else
    echo "CommonProblemResolver download\033[32m success\033[0m."
    mv CommonProblemResolver.bin ./bootloader/payloads
fi

### Fetch logo
curl -sL https://raw.githubusercontent.com/linjiacheng/SwitchScript/main/theme/logo.zip -o logo.zip
if [ $? -ne 0 ]; then
    echo "logo download\033[31m failed\033[0m."
else
    echo "logo download\033[32m success\033[0m."
    unzip -oq logo.zip
    rm logo.zip
fi

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/tag/658
curl -sL https://api.github.com/repos/rashevskyv/dbi/releases/135856657 \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*DBI.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o DBI.nro
if [ $? -ne 0 ]; then
    echo "DBI 658 download\033[31m failed\033[0m."
else
    echo "DBI 658 download\033[32m success\033[0m."
    mkdir -p ./switch/DBI
    mv DBI.nro ./switch/DBI
fi

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/latest
curl -sL https://api.github.com/repos/rashevskyv/dbi/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo DBI {} and 658en >> ../description.txt
curl -sL https://api.github.com/repos/rashevskyv/dbi/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*DBI.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o DBI.nro.ru
if [ $? -ne 0 ]; then
    echo "DBI download\033[31m failed\033[0m."
else
    echo "DBI download\033[32m success\033[0m."
    mv DBI.nro.ru ./switch/DBI
fi

### Fetch lastest Hekate-toolbox from https://github.com/WerWolv/Hekate-Toolbox/releases/latest
curl -sL https://api.github.com/repos/WerWolv/Hekate-Toolbox/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo HekateToolbox {} >> ../description.txt
curl -sL https://api.github.com/repos/WerWolv/Hekate-Toolbox/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*HekateToolbox.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o HekateToolbox.nro
if [ $? -ne 0 ]; then
    echo "HekateToolbox download\033[31m failed\033[0m."
else
    echo "HekateToolbox download\033[32m success\033[0m."    
    mkdir -p ./switch/HekateToolbox
    mv HekateToolbox.nro ./switch/HekateToolbox
fi

### Fetch lastest NX-Activity-Log from https://github.com/zdm65477730/NX-Activity-Log/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Activity-Log.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NX-Activity-Log.nro
if [ $? -ne 0 ]; then
    echo "NX-Activity-Log download\033[31m failed\033[0m."
else
    echo "NX-Activity-Log download\033[32m success\033[0m."
    mkdir -p ./switch/NX-Activity-Log
    mv NX-Activity-Log.nro ./switch/NX-Activity-Log
fi

### Fetch lastest JKSV from https://github.com/J-D-K/JKSV/releases/latest
curl -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo JKSV {} >> ../description.txt
curl -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*JKSV.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o JKSV.nro
if [ $? -ne 0 ]; then
    echo "JKSV download\033[31m failed\033[0m."
else
    echo "JKSV download\033[32m success\033[0m."
    mkdir -p ./switch/JKSV
    mv JKSV.nro ./switch/JKSV
fi

### Fetch lastest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
curl -sL https://api.github.com/repos/xfangfang/wiliwili/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/xfangfang/wiliwili/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*wiliwili-NintendoSwitch.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o wiliwili-NintendoSwitch.zip
if [ $? -ne 0 ]; then
    echo "wiliwili download\033[31m failed\033[0m."
else
    echo "wiliwili download\033[32m success\033[0m."
    unzip -oq wiliwili-NintendoSwitch.zip    
    mkdir -p ./switch/wiliwili
    mv wiliwili/wiliwili.nro ./switch/wiliwili
    rm -rf wiliwili
    rm wiliwili-NintendoSwitch.zip
fi

### Fetch lastest Switchfin from https://github.com/dragonflylee/switchfin/releases/latest
curl -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Switchfin.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Switchfin.nro
if [ $? -ne 0 ]; then
    echo "Switchfin download\033[31m failed\033[0m."
else
    echo "Switchfin download\033[32m success\033[0m."
    mkdir -p ./switch/Switchfin
    mv Switchfin.nro ./switch/Switchfin
fi

### Fetch lastest Moonlight from https://github.com/XITRIX/Moonlight-Switch/releases/latest
curl -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Moonlight {} >> ../description.txt
curl -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Moonlight-Switch.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Moonlight-Switch.nro
if [ $? -ne 0 ]; then
    echo "Moonlight download\033[31m failed\033[0m."
else
    echo "Moonlight download\033[32m success\033[0m."
    mkdir -p ./switch/Moonlight-Switch
    mv Moonlight-Switch.nro ./switch/Moonlight-Switch
fi

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
curl -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*appstore.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o appstore.nro
if [ $? -ne 0 ]; then
    echo "hb-appstore download\033[31m failed\033[0m."
else
    echo "hb-appstore download\033[32m success\033[0m."
    mkdir -p ./switch/HB-App-Store
    mv appstore.nro ./switch/HB-App-Store
fi

mkdir -p ./switch/.overlays

### Fetch nx-ovlloader from https://github.com/zdm65477730/nx-ovlloader/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*nx-ovlloader.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o nx-ovlloader.zip
if [ $? -ne 0 ]; then
    echo "nx-ovlloader download\033[31m failed\033[0m."
else
    echo "nx-ovlloader download\033[32m success\033[0m."
    mkdir -p ./atmosphere/contents/420000000007E51Anx-ovlloader
    unzip -oq nx-ovlloader.zip
    rm nx-ovlloader.zip
fi

### Fetch lastest Ultrahand-Overlay from https://github.com/zdm65477730/Ultrahand-Overlay/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Ultrahand.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Ultrahand.zip
if [ $? -ne 0 ]; then
    echo "Ultrahand-Overlay download\033[31m failed\033[0m."
else
    echo "Ultrahand-Overlay download\033[32m success\033[0m."
    unzip -oq Ultrahand.zip
    rm Ultrahand.zip
    cat > ./config/Ultrahand/config.ini << ENDOFFILE
[ultrahand]
default_lang=zh-cn
ENDOFFILE
    cat > ./config/Ultrahand/overlays.ini << ENDOFFILE
[ovl-sysmodules.ovl]
priority=1
custom_name=系统模块
[sys-patch-overlay.ovl]
priority=2
custom_name=签名补丁
[StatusMonitor.ovl]
priority=3
custom_name=状态监控
[sys-clk.ovl]
priority=4
custom_name=硬件超频
[Fizeau.ovl]
priority=5
custom_name=色彩调整
[EdiZon.ovl]
priority=6
custom_name=游戏作弊
[emuiibo.ovl]
priority=7
custom_name=虚拟Amiibo
ENDOFFILE
fi

### Fetch ovlSysmodules from https://github.com/zdm65477730/ovl-sysmodules/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ovl-sysmodules.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ovl-sysmodules.zip
if [ $? -ne 0 ]; then
    echo "ovlSysmodules download\033[31m failed\033[0m."
else
    echo "ovlSysmodules download\033[32m success\033[0m."
    unzip -oq ovl-sysmodules.zip
    rm ovl-sysmodules.zip
fi

### Fetch sys-patch from https://github.com/zdm65477730/sys-patch/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/sys-patch/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/sys-patch/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-patch[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-patch.zip
if [ $? -ne 0 ]; then
    echo "sys-patch download\033[31m failed\033[0m."
else
    echo "sys-patch download\033[32m success\033[0m."
    mkdir -p ./atmosphere/contents/420000000000000Bsys-patch
    unzip -oq sys-patch.zip
    rm sys-patch.zip
fi

### Fetch StatusMonitor from https://github.com/zdm65477730/Status-Monitor-Overlay/releases
curl -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases?per_page=2 \
  | jq '.[0].name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases?per_page=2 \
  | jq '.[0]' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*StatusMonitor.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o StatusMonitor.zip
if [ $? -ne 0 ]; then
    echo "StatusMonitor download\033[31m failed\033[0m."
else
    echo "StatusMonitor download\033[32m success\033[0m."
    unzip -oq StatusMonitor.zip
    rm StatusMonitor.zip
fi

### Fetch sys-clk from https://github.com/zdm65477730/sys-clk/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo sys-clk {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk.zip
if [ $? -ne 0 ]; then
    echo "sys-clk download\033[31m failed\033[0m."
else
    echo "sys-clk download\033[32m success\033[0m."
    mkdir -p ./atmosphere/contents/00FF0000636C6BFFsys-clk
    unzip -oq sys-clk.zip
    rm sys-clk.zip
fi

### Fetch lastest Fizeau from https://github.com/zdm65477730/Fizeau/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/Fizeau/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/Fizeau/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Fizeau.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Fizeau.zip
if [ $? -ne 0 ]; then
    echo "Fizeau download\033[31m failed\033[0m."
else
    echo "Fizeau download\033[32m success\033[0m."
    mkdir -p ./atmosphere/contents/0100000000000F12Fizeau
    unzip -oq Fizeau.zip
    rm Fizeau.zip
fi

### Fetch lastest EdiZon-Overlay from https://github.com/zdm65477730/EdiZon-Overlay/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*EdiZon.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o EdiZon-Overlay.zip
if [ $? -ne 0 ]; then
    echo "EdiZon-Overlay download\033[31m failed\033[0m."
else
    echo "EdiZon-Overlay download\033[32m success\033[0m."
    unzip -oq EdiZon-Overlay.zip
    rm EdiZon-Overlay.zip
fi

### Fetch lastest emuiibo from https://github.com/zdm65477730/emuiibo/releases/latest
curl -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
curl -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*emuiibo.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o emuiibo.zip
if [ $? -ne 0 ]; then
    echo "emuiibo download\033[31m failed\033[0m."
else
    echo "emuiibo download\033[32m success\033[0m."
    mkdir -p ./atmosphere/contents/0100000000000352emuiibo
    unzip -oq emuiibo.zip
    rm emuiibo.zip
fi

## Fetch lastest OC_Toolkit_SC_EOS from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
curl -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo OC Toolkit {} >> ../description.txt
curl -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*kip.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o kip.zip
curl -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*OC.Toolkit.u.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o OC.Toolkit.u.zip
if [ $? -ne 0 ]; then
    echo "OC_Toolkit_SC_EOS download\033[31m failed\033[0m."
else
    echo "OC_Toolkit_SC_EOS download\033[32m success\033[0m."
    mkdir -p ./atmosphere/kips
    unzip -oq kip.zip -d ./atmosphere/kips/
    mkdir -p ./switch/.packages
    unzip -oq OC.Toolkit.u.zip -d ./switch/.packages/
    rm kip.zip
    rm OC.Toolkit.u.zip
fi

### Write hekate_ipl.ini in /bootloader/
cat > ./bootloader/hekate_ipl.ini << ENDOFFILE
[config]
autoboot=0
autoboot_list=0
bootwait=3
autohosoff=0
autonogc=1
updater2p=1
backlight=100

[CFW (emuMMC)]
pkg3=atmosphere/package3
kip1patch=nosigchk
emummcforce=1
atmosphere=1
icon=bootloader/res/icon_Atmosphere_emunand.bmp
id=cfw-emu

[CFW (sysNAND)]
pkg3=atmosphere/package3
kip1patch=nosigchk
emummc_force_disable=1
atmosphere=1
icon=bootloader/res/icon_Atmosphere_sysnand.bmp
id=cfw-sys

[OFW (SysNAND)]
pkg3=atmosphere/package3
emummc_force_disable=1
stock=1
icon=bootloader/res/icon_stock.bmp
id=ofw-sys
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[31m failed\033[0m."
else
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[32m success\033[0m."
fi

### write exosphere.ini in root of SD Card
cat > ./exosphere.ini << ENDOFFILE
[exosphere]
debugmode=1
debugmode_user=0
disable_user_exception_handlers=0
enable_user_pmu_access=0
; 控制真实系统启用隐身模式。
blank_prodinfo_sysmmc=1
; 控制虚拟系统启用隐身模式。
blank_prodinfo_emummc=1
allow_writing_to_cal_sysmmc=0
log_port=0
log_baud_rate=115200
log_inverted=0
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing exosphere.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing exosphere.ini in root of SD card\033[32m success\033[0m."
fi

### Write emummc.txt & sysmmc.txt in /atmosphere/hosts
mkdir -p ./atmosphere/hosts
cat > ./atmosphere/hosts/emummc.txt << ENDOFFILE
# 屏蔽任天堂服务器
127.0.0.1 *nintendo.*
127.0.0.1 *nintendo-europe.com
127.0.0.1 *nintendoswitch.*
127.0.0.1 ads.doubleclick.net
127.0.0.1 s.ytimg.com
127.0.0.1 ad.youtube.com
127.0.0.1 ads.youtube.com
127.0.0.1 clients1.google.com
207.246.121.77 *conntest.nintendowifi.net
207.246.121.77 *ctest.cdn.nintendo.net
69.25.139.140 *ctest.cdn.n.nintendoswitch.cn
95.216.149.205 *conntest.nintendowifi.net
95.216.149.205 *ctest.cdn.nintendo.net
95.216.149.205 *90dns.test
ENDOFFILE
cp ./atmosphere/hosts/emummc.txt ./atmosphere/hosts/sysmmc.txt
if [ $? -ne 0 ]; then
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[31m failed\033[0m."
else
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[32m success\033[0m."
fi

### Write boot.ini in root of SD Card
cat > ./boot.ini << ENDOFFILE
[payload]
file=payload.bin
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing boot.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing boot.ini in root of SD card\033[32m success\033[0m."
fi

mkdir -p ./atmosphere/config
### Write override_config.ini in /atmosphere/config
cat > ./atmosphere/config/override_config.ini << ENDOFFILE
[hbl_config]
program_id_0=010000000000100D
override_address_space=39_bit
; 按住R键点击相册进入HBL自制软件界面。
override_key_0=R
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing override_config.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing override_config.ini in ./atmosphere/config\033[32m success\033[0m."
fi

### Write system_settings.ini in /atmosphere/config
cat > ./atmosphere/config/system_settings.ini << ENDOFFILE
[eupld]
; 禁用将错误报告上传到任天堂
upload_enabled = u8!0x0

[usb]
; 开启USB3.0，尾数改为0是关闭
usb30_force_enabled = u8!0x1

[ro]
; 控制 RO 是否应简化其对 NRO 的验证。
; （注意：这通常不是必需的，可以使用 IPS 补丁。
ease_nro_restriction = u8!0x1

[atmosphere]
; 是否自动开启所有金手指。0=关。1=开。
dmnt_cheats_enabled_by_default = u8!0x0

; 如果你希望大气记住你上次金手指状态，请删除下方；号
; dmnt_always_save_cheat_toggles = u8!0x1

; 如果大气崩溃，10秒后自动重启
; 1秒=1000毫秒，转换16进制
fatal_auto_reboot_interval = u64!0x2710

; 使电源菜单的“重新启动”按钮重新启动到payload
; 设置"normal"正常重启l 设置"rcm"重启RCM，
; power_menu_reboot_function = str!payload

; 启动90DNS与任天堂服务器屏蔽
enable_dns_mitm = u8!0x1
add_defaults_to_dns_hosts = u8!0x1

; 是否将蓝牙配对数据库用与虚拟系统
enable_external_bluetooth_db = u8!0x1
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing system_settings.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing system_settings.ini in ./atmosphere/config\033[32m success\033[0m."
fi

### Delete unneeded files
rm -f switch/haze.nro
rm -f switch/reboot_to_payload.nro

# -------------------------------------------

echo ""
echo "\033[32mYour Switch SD card is prepared!\033[0m"