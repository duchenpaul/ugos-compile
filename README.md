# Compile ugos

## Compile
### Run in docker
```bash
git pull
WORKDIR=~/projects/ugos-compile/data
image_name=ugos_compile

mkdir ${WORKDIR}

docker build . -t ${image_name}

docker run --rm -it -v ${WORKDIR}:/home/chend/data ${image_name} bash

# In docker
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git checkout -f v22.03.0-rc4

rm -rf staging_dir/host/bin/python3
ln -s /usr/bin/python3  staging_dir/host/bin/python3
sed -i 's#http://grail.cba.csuohio.edu#https://grail.cba.csuohio.edu#g' tools/xxd/Makefile

./scripts/feeds update -a
./scripts/feeds install -a

# Configure
# make menuconfig
 
# Optional: configure the kernel (usually not required)
# Don't, unless have a strong reason to
make -j$(nproc) kernel_menuconfig

# Out of docker
cp dotconfig data/openwrt/.config

```

### Compile paramters
1. Get the system info:
   ```bash
   root@UGREEN-XXXX:~# cat /proc/version 
    Linux version 5.10.120 (ugreen@jenkins-ugos) (x86_64-openwrt-linux-gnu-gcc (OpenWrt GCC 8.4.0 r0-d2b09aa6) 8.4.0, GNU ld (GNU Binutils) 2.38) #0 SMP Wed Sep 27 13:45:48 2023
    ```
2. Branch: `v22.03.0-rc4`
3. add packages using `make menuconfig`

## Repo setup
1. If compile by yourself, setup a web server in `bin`
2. If using artifact from Github Actions, download the zip and setup a web server.
3. Make sure the web directory contains, say your web url is http://<IP>:
    ```bash
    packages/
    targets/ 
    ```
4. Modify `/etc/opkg/distfeeds.conf`, replace the content with:
    ```bash
    src/gz openwrt_base http://<IP>/packages/x86_64/base
    src/gz openwrt_packages http://<IP>/packages/x86_64/packages
    src/gz openwrt_routing http://<IP>/packages/x86_64/routing
    src/gz openwrt_telephony http://<IP>/packages/x86_64/telephony
    ```
5. In `/etc/opkg.conf`, comment `option check_signature`
6. SSH into NAS, do `opkg update` and `opkg install jq`, it should be able to install, and run `jq` to verify it works.

## Reference
- [绿联DX4600：编译并自建opkg软件源服务器](https://www.bilibili.com/video/BV1DY411B7qX/?spm_id_from=333.788.recommend_more_video.3&vd_source=80fe7f5ab34917451155178cd07db5ea)
- https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem