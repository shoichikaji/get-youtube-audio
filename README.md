# get youtube audio

Get youtube video and extract audio m4a file from it.

## Usage

    > get-youtube-audio https://www.youtube.com/watch?v=L0MK7qz13bU
    Downloading L0MK7qz13bU.mp4 (fmt 22)
    Downloading `/tmp/vvqd4Gsuv9/L0MK7qz13bU.mp4`
    60619774/60619774 (100.00%)
    Successfully get L0MK7qz13bU.mp4 and L0MK7qz13bU.m4a

    > open -a iTunes L0MK7qz13bU.m4a

## Dependencies

* perl and modules listed in cpanfile
* ffmpeg
* MP4Box (gpac)

## How to install dependencies

OS X:

    > cpanm -nq --installdeps .
    > brew install ffmpeg
    > brew install gpac --HEAD

Ubuntu 14.04:

    > cpanm -nq --installdeps .
    # install ffmpeg
    > sudo apt-get install software-properties-common
    > sudo add-apt-repository ppa:mc3man/trusty-media
    > sudo apt-get update
    > sudo apt-get dist-upgrade
    > sudo apt-get install ffmpeg
    # install mp4box
    > apt-get install -y gpac
