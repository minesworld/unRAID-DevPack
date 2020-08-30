# unraid DockerImage
Create an docker image for local development.

Usage:

- copy the Unraid USB stick into usb-sticks/VERSION. There must be a usb-sticks/VERSION/UNRAID/bzroot later. Change version accordingly in "Dockerfile.base" if needed.

- to build a clean "unraid-base" image (only contents of Unraids bzroot file) run

docker build -t unraid-base -f Dockerfile-base .

- to create a "unraid-dev" image with development tools ontop run

docker build -t unraid-dev -f Dockerfile-dev .

- create your own docker image based on "unraid-dev" to create your packages
- test your packages with another image based on "unraid-base" to see if all link dependencies resolve etc.

How it does its "magic" in Dockerfile-base:

- bzroot-preproc: as "bzroot" needs to be repacked into a new cpio archive so no awk etc. is needed later
- statics-builder: an image from "scratch" has no libs available, all binaries RUN from docker must be statically linked:
  - "cpio" to restore the preprocessed image from step bzroot-preproc
  - as no bash is available a helper tool "catexec" is needed to feed and call cpio as it wants its input from stdin
- e.g. only /cpio and /catexec are needed on a blank image to restore any cpio archive into it...

Note: its unlikely that Unraid "itself" will run within the "unraid-base" image. The images purpose is just development and packaging without the need for additional hardware or virtualization...

Hope these images help you as much as me and save you a lot of time and headaches :-)

Oh - you can donate too:

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=A5XDJVC3D5HKC&source=url)



# unRAID 6.1+
unRAID DevPack plugin and packages

Collection of packages for compiling packages for unRAID.



These are notes more for my memory or for anyone who wants to make unRAID plugins using this structure

I manage this on my laptop running Linux Mint Mate

I use Sublime Text as an editor and SmarGit to upload to github

copy tar-1.13 from unRAID to /bin/tar-1.13 on laptop

copy makepkg from unRAID to /sbin/makepkg on laptop

I modified gfjardim's pkg_build.sh to take an argument and add arch type plus modified the lettering function

To compile the packages for unRAID plugin run from the source directory

sudo ./mkpkg plugin

This creates a slackware compliant package and md5 in the archive directory with the date as the version number

And adds the date to the plugin file in plugins directory.

e.g. plugin-2017.06.09-x86_64-1.txz and plugin-2016.06.09-x86_64-1.md5

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKQJF5NVA5E3S)