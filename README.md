# Custom Kali Linux Docker Image
_A handy custom Kali image based on https://hub.docker.com/r/kalilinux/kali-rolling._

#### Features
- Easy to connect to a VPN.
- Pre-configured non-root user, complete with home directory, password, and sudo privileges.
- Easily share files between host and container.

#### Requirements
- Docker and DockerCLI. See https://docs.docker.com/get-docker/.
- For now, MacOS, but it might work on other Unix-like host OS's.
- A terminal, bash, and the ability to run bash scripts.

#### Getting Started
Clone this repository, ```cd``` into it, then execute the build and run scripts.
```sh
$ git clone https://github.com/qkmiller/kali-docker
$ cd kali-docker
$ ./build && ./run
```
You should now see a prompt that looks similar to the following:
```sh
┌──(user㉿d35809e82c53)-[~]
└─$
```
___NOTE:___ _The default user's password is "kali123"._

#### Configuration
The pre-configured username, password, and image name can be changed by editing the build script. For example, if you want the username to be "foo", the password to be "bar", and the image name to be "foobar", change the build script to look like this:
```sh
#!/bin/bash
docker build -t foobar \
  --build-arg user=foo \
  --build-arg password=bar \
  --no-cache \
  .
```

You can force ```apt``` to use a specific mirror by changing the following line in the Dockerfile. Replace <MIRROR> with the mirror of your choice
```dockerfile
RUN echo "<MIRROR> kali-rolling main contrib non-free" > /etc/apt/sources.list
```
___NOTE:___ _Kali's default mirror (metalink, http://http.kali.org/kali/) tends to be slow. To find out which mirror is best for you, visit http://http.kali.org/README.mirrorlist. Ensure the link ends with /kali/ (for example, http://mirrors.ocf.berkeley.edu/kali/ is valid)._

#### Sharing Files
The run script creates a directory on the host and binds it to ```/shared``` inside the container. Files located here can be added, removed, accessed and changed by both the host and the container. 

```foo.txt``` on the host: 
```sh
$ pwd
/.../.../kali-docker/shared
$ ls
foo.txt
```
```foo.txt``` in the container:
```sh
$ pwd
/shared
$ ls
foo.txt
```
    
#### Using a VPN
To route the container's traffic through a VPN, simply move a VPN config file (e.g., ```bar.ovpn```) from your host into the shared folder, then run the following from inside the container:
```sh
$ sudo openvpn /shared/bar.ovpn
```

#### License
Copyright (c) 2022 Quinn Miller

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
