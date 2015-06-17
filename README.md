# dsh: Docker shell

Run your shell inside docker and take docker with you.

## Synopsis

    $ sudo ./dsh
    Docker image not found. Rebuilding.
    Sending build context to Docker daemon 
    Step 0 : FROM phusion/baseimage
    [...]
    Successfully built [...]
    # docker ps
    CONTAINER ID        IMAGE                       COMMAND                CREATED             STATUS
    cdbab3de4ac7        dsh:latest              "/bin/sh -c 'cd /roo   3 seconds ago       Up 2 seconds
    # exit
    $

## What it does

Docker shell (dsh) is a bash shell inside a container, and will bring
any docker configuration along, making it possible to control docker from
inside dsh.

The shell comes with a data container of its own that is persisted across
invocations of dsh. Anything under `/root` (a symlink to `/workspace`) is
persisted in the data container named `dsh-ws`.

When run, the shell will automatically launch a smb file share, exposing
the volumes avaliable in dsh (mainly `/workspace`), making it easy to share
files with the shell.

## Parameters

 -s|--samba: start samba server for file sharing
 -b|--build: rebuild dsh image

Use `--` to indicate start of command line to run inside dsh:

    $ dsh -- ls /
    bin   dev  home  lib64	mnt  proc  run	 srv  tmp  var
    boot  etc  lib	 media	opt  root  sbin  sys  usr  workspace
    $

## Author

Written by Michael Zedeler <michael@zedeler.dk>

## Copyright and license

Copyright Nota (http://nota.dk), licensed under the MIT license, see LICENSE.
