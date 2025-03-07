---
title: "Pinephone emulation on qemu"
author: "Ramon Dev"
date : 2020-07-09T10:40:33+02:00
draft: false
categories: [ "info" ]
tags : [ "pinephone", "pine64", "linux", "qemu" ]
---

Have you heard about pinephone device ? It's a $150 smartphone driven by open source community for the software, and pine64 team for the hardware.<br>
Most part of the hardware is also open.

| ![alt text](pinephone.jpg "Pinephone image") |  &bull; Allwinner A64 Quad Core<br>&bull; Mali 400 MP2 GPU<br>&bull; 2GB of LPDDR3 RAM  GPU<br>&bull; 5.95″ LCD 1440×720 <br>&bull;  HW switches: LTE/GNSS, WiFi, Microphone, Speaker, Cameras|
| ------:| -----------:|

I have implemented in qemu what is needed to emulate pinephone, but be warned, you will only get a serial console. Currently lima driver won't work, because the pinephone GPU is not implemented on qemu.<br>
Also note that you will need to clone my qemu repo, because my patch is not (yet?) in official qemu release.

Here is the instruction to run the manjaro ARM 20.06 on it.

**1.** [Download manjaro ARM Alpha5 for pinephone](https://forum.manjaro.org/t/manjaro-arm-alpha5-for-pinephone-testing-branch/136614)

**2.** Extract from this image the kernel, initrd, and dts file. This is needed because we need to remove some unimplemented stuff from dts file like the GPU. Without that you will get a panic.

<pre><code class="Bash">
> cd tmp
> wget https://osdn.net/projects/manjaro-arm/storage/pinephone/plasma-mobile/alpha5/Manjaro-ARM-plasma-mobile-pinephone-alpha5.img.xz
> xz -d Manjaro-ARM-plasma-mobile-pinephone-alpha5.img.xz 
> mkdir /tmp/img /tmp/qemu_img
> sudo mount -o loop,offset=32000000 -t auto /tmp/Manjaro-ARM-plasma-mobile-pinephone-alpha5.img  /tmp/img/ 
> cp img/dtbs/allwinner/sun50i-a64-pinephone.dtb qemu_img/
> cp img/Image qemu_img/
> cp img/initramfs-linux.img qemu_img/
> sudo umount /tmp/img

</code></pre>

To compute the offset value, use fdisk -u sectors -l /tmp/Manjaro-ARM-plasma-mobile-pinephone-alpha5.img, and get the start sector of first partition (62500) and multiply it by 512 (sector size).

Voila ! You have extracted what you need.

**3.** Fix dts file: you should remove at least GPU related stuff from it. If you dont want to do it yourself, you can use mine:

<pre><code class="Bash">
> wget https://rdev.pages.dev/2020/07-09-pinephone-emulation-on-qemu/dts_pinephone.dtb -O /tmp/qemu_img/dts_pinephone.dtb

</code></pre>

the [dts source is here](/post/2020/pinephone/dts_pinephone)

**4.** Get my patched version of qemu and build it. 

<pre><code class="Bash">
> git clone https://github.com/rdev0x1/qemu.git
> cd qemu
> git checkout pinephone_wip
> ./configure
> CFLAGS="-g -j32" make aarch64-softmmu/all -j32 
</code></pre>

**5.** Test it ! Username is Manjaro and password is 1234

<pre><code class="Bash">
> ./aarch64-softmmu/qemu-system-aarch64 -M pinephone \
  -sd /tmp/Manjaro-ARM-plasma-mobile-pinephone-alpha5.img \
  -kernel /tmp/qemu_img/Image -initrd /tmp/qemu_img/initramfs-linux.img  \
  -serial mon:stdio -nographic \
  -append 'maxcpus=4 earlycon=uart8250,mmio32,0x1c28000 console=ttyS0,115200n8 root=/dev/mmcblk0p2 rw' \
  -dtb /tmp/qemu_img/dts_pinephone.dtb

</code></pre>

<pre><code class="Bash">
Manjaro Linux 5.5.0-7-MANJARO-ARM (ttyS0)

manjaro-arm login: manjaro
Password: 
Welcome to Manjaro-ARM
~~Website: https://manjaro.org
~~Forum:   https://forum.manjaro.org/c/manjaro-arm
~~IRC:     #manjaro-arm on irc.freenode.net
~~Matrix:  #manjaro-arm-public:matrix.org
Last login: Thu Jul  2 14:06:31 on ttyS0
[manjaro@manjaro-arm ~]$ 
[manjaro@manjaro-arm ~]$ 
[manjaro@manjaro-arm ~]$ uname -a
Linux manjaro-arm 5.5.0-7-MANJARO-ARM #1 SMP Fri Apr 17 17:05:01 +03 2020 aarch64 GNU/Linux
[manjaro@manjaro-arm ~]$ lsmod
Module                  Size  Used by
bluetooth             401408  2
ecdh_generic           16384  1 bluetooth
ecc                    28672  1 ecdh_generic
rfkill                 32768  2 bluetooth
crct10dif_ce           16384  1
ip_tables              32768  0
x_tables               32768  1 ip_tables
ipv6                  446464  50
nf_defrag_ipv6         24576  1 ipv6
[manjaro@manjaro-arm ~]$

</code></pre>


