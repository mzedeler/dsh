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


## Parameters

 -s|--samba:       start samba server for file sharing
 -b|--build:       rebuild dsh image
 --host-workspace: to specify a path used as workspace in stead of the
                   normal data container

Any options not on the list above will be passed to docker, for instance:

Use `--` to indicate start of command line to run inside dsh:

    $ dsh -- ls /
    bin   dev  home  lib64	mnt  proc  run	 srv  tmp  var
    boot  etc  lib	 media	opt  root  sbin  sys  usr  workspace
    $


## Examples

### Take a peek into a data container

    $ sudo ./dsh --volumes-from my-data -- ls
    file1 file2 file3

### Link a container by name and ping it

    $ sudo ./dsh --link my-webserver -- ping my-webserver
    PING stashdb (172.17.0.4) 56(84) bytes of data.
    64 bytes from stashdb (172.17.0.4): icmp_seq=1 ttl=64 time=0.077 ms


## Customizing dsh

Docker shell will create an image named dsh and use it for all invocations
of `dsh`. If you want to customize dsh with extra packages or such, use the
image name `dsh-custom`:

    $ sudo ./dsh
    # apt-get update && apt-get install some-awesome-package
    ....
    # docker commit $(hostname) dsh-custom

The hostname of the docker shell is the id of the running container, which
makes docker commit recognize the currently running container. Next time
dsh is run, it will have `some-awesome-package` installed.


# Caveats

Docker shell will try to detect how to connect to the docker daemon on 
the host, but this may fail. In this case `dsh` will work as usual, with 
the exception that the `docker` command fails. File a bug if this happens!

Docker shell installs a docker client inside dsh that matches the one
on the host. If you upgrade your host docker engine, you may need to
rebuild dsh (`dsh -b`). Note that this does *not* replace `dsh-custom`.
You have to do that yourself if you have any.


## Author

Written by Michael Zedeler <michael@zedeler.dk>


## Copyright and license

Copyright Nota (http://nota.dk), licensed under the MIT license, see LICENSE.
