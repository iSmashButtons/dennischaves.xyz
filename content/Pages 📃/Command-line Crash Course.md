---
title: Command-Line Crash Course
description: Once upon a time, familiarity with bash was practically a requirement for any Linux user. That is no longer true, but a working knowledge of the command-line environment will give you much more control and a better ability to solve problems on your computer when you run into them. This article is a gentle introduction to bash scripting for people new to Linux.
aliases:
tags:
  - Linux
  - BASH
date:
draft: true
---
Once upon a time, familiarity with the command line was practically a requirement for any Linux user. Today we have very nice desktop environments and graphical programs that allow someone to use Linux on a daily basis without ever needing to see a command line interface. However, a working knowledge of the command-line environment will give you a better understanding of how the operating system works, give you much more control over it, and a better ability to solve problems on your computer when you run into them. 

This article aims to be a gentle introduction to bash scripting for people new to Linux. By the end of this article, you will know a bit more about how a Linux-based operating system works under the hood, and have a working knowledge of the command line. If I've done my job, you will understand and be able to manage your own computer better, and maybe even manage a VPS.

# Command Line, Shells, Terminals

So what is the "command line", really? "The command line" is a common term people use when talking about what is more precisely known as *the shell*. The shell is a program that enables the user to interact with the operating system by issuing commands. There are many shell programs like, `zsh`, `dash`, and `ksh`. But by far the most common shell program is `bash`. It's probably the one you're using right now, and will be the one we will learn about in this article.

What's a terminal? If you search for a program called *terminal* on your computer, and run it, you will find yourself at the "command line", where you can interact with the shell. But much like how "the command line" is a common term referring to the shell, what everyone calls "the terminal" is more precisely a *terminal emulator*. Long ago, when computers were the size of furniture rather than something you put on furniture, several users would connect to the one central computer from remote terminals. The terminals were little more than a screen, keyboard, and whatever hardware was required to connect to the main computer. Terminal emulators are the modern equivalent to these devices. Instead of connecting you to a computer on the other side of campus, it opens a window to the operating system running your computer. Just like shells, there are many such terminal emulator programs. Your default emulator may be [konsole](https://apps.kde.org/konsole/), if you're using KDE, or [gnome-terminal](https://apps.gnome.org/Console/) if you're using GNOME. But there are many other popular programs like: [kitty](https://sw.kovidgoyal.net/kitty/), [terminator](https://gnome-terminator.org/) and [ghostty](https://ghostty.org/). They all have different features and creature comforts but they all do the same thing: let you interact with the shell. `kitty` is my personal favorite, and the one I use.

The terms command line, shell, terminal, terminal emulator, and CLI (command line interface) are all used interchangeably online. When you want to be precise, precise words matter, but in general we're all usually referring to the same thing: controlling your computer by typing commands into the keyboard. To summarize:

- **Command line = shell = bash** 👈 A program which interprets your commands and turns them into actions for the operating system.
- **Terminal = terminal emulator** 👈 The program you use to interact with the shell.

# Your first commands
With definitions out of the way, start up your terminal. What you will see is a blank window with some text. This is called *the prompt*.

```
dennis@flappy:~$
```

This little bit of text is telling us three things:

- `dennis` 👈 The user currently logged in.
- `flappy` 👈 The hostname of the computer.
- `~` 👈 The current working directory.
- `$` 👈 Indicates the end of the prompt and the shell is ready for input.

Your prompt may look slightly different, but they all generally follow this format of username, hostname, directory.

Here's your first command, type in: `hjklfdsa`.

```
dennis@flappy:~$ hjklfdsa
bash: hjklfdsa: command not found...
dennis@flappy:~$ 
```

As you might have guessed, this didn't work. The shell told us it couldn't find a command by that name, and is awaiting further input. Let's try some real commands now. The `date` command will return with the current date and time.

```
dennis@flappy:~$ date
Fri Nov 21 07:19:10 PM EST 2025
```

A similar command, `cal` will display a calendar of the current month.

```
dennis@flappy:~$ cal
    November 2025   
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
 9 10 11 12 13 14 15
16 17 18 19 20 21 22
23 24 25 26 27 28 29
30   
```

Adding `december` and `2030` will show use the calendar for December, five years from now. These two extra words are called *arguments*. They are additional inputs for the command.

```
dennis@flappy:~$ cal december 2030
    December 2030   
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31 
```

Arguments are often combined with various *options*, also called *flags*, which change the behavior or output of a command. For example, examine the output of the `df` (disk free) command.

```
dennis@flappy:~$ df
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/nvme0n1p4 248293376 136964540 108804548  56% /
devtmpfs         7987640         0   7987640   0% /dev
tmpfs            8068636    158628   7910008   2% /dev/shm
efivarfs             384        88       292  24% /sys/firmware/efi/efivars
tmpfs            3227456      2616   3224840   1% /run
tmpfs               1024         0      1024   0% /run/credentials/systemd-journald.service
/dev/nvme0n1p3    996780    544412    383556  59% /boot
tmpfs            8068640     80072   7988568   1% /tmp
/dev/nvme0n1p4 248293376 136964540 108804548  56% /home
/dev/nvme0n1p2    613184     58040    555144  10% /boot/efi
tmpfs               1024         0      1024   0% /run/credentials/systemd-resolved.service
tmpfs            1613724       572   1613152   1% /run/user/1000
```

The shell returns a table listing every filesystem on the computer, the space used on that system, the space available, and other information. The problem here is that the used and available space is displayed in bytes. Which is easy for a computer to deal with, but is unclear to us humans. To help us, `df` has a `-h` flag, which will display these values in a *human-readable* format.

```
dennis@flappy:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p4  237G  131G  104G  56% /
devtmpfs        7.7G     0  7.7G   0% /dev
tmpfs           7.7G  251M  7.5G   4% /dev/shm
efivarfs        384K   88K  292K  24% /sys/firmware/efi/efivars
tmpfs           3.1G  2.6M  3.1G   1% /run
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
/dev/nvme0n1p3  974M  532M  375M  59% /boot
tmpfs           7.7G   79M  7.7G   1% /tmp
/dev/nvme0n1p4  237G  131G  104G  56% /home
/dev/nvme0n1p2  599M   57M  543M  10% /boot/efi
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
tmpfs           1.6G  572K  1.6G   1% /run/user/1000
```

That's much better.

To end your terminal session, you have a few options. The first and most obvious would be to simply close the window. You could also type `exit`, or press `Ctrl-d` to end the session.
## Command history
Now that we've entered a few commands, we can explore the shell's *command history*. Most distributions are configured to remember up to 1000 commands by default. To bring your previous command back, press the up key. Keep pressing up to bring up every other previous command.

You can also search through your command history by pressing `Ctrl-r`. As you start typing, the shell will match it with the most recent occurrence in the history. Once you find the command your looking for, just press enter to execute it.

# Navigating The Filesystem

Next, let's talk about how to explore your computer's files. One of the cool things about Linux is the fact that *everything is a file*. This has some pretty cool implications that we will explore later. First, let's clarify what I'm talking about when I mention the filesystem.

Your computer has one or more disk drives in it. The disk is usually segmented into several partitions, and each partition has a certain *filesystem*. The filesystem is like your computer's librarian. It has several important jobs, including:

- Keeping track of where every file and folder lives on the disk.
- Keeping track of each file's name, size, type, and when it was created or last modified.
- Makes sure two different files don't get stored in the same exact spot.

Without the filesystem, all the data in your computer would be in one massive, unusable pile of bits.
## Windows/DOS and Unix Filesystems

One thing I want to clear up first is the very different ways disks and filesystems are organized and used between Windows and Unix-like systems. Because this really threw me for a loop when I first started. I spent way too much time trying to find files in the terminal and wondering "Where's the C drive?"

Both Windows and Unix-like systems organize files in a tree-like pattern of directories, which contain files and other directories. The first directory in any filesystem is called the **root directory**.

```
+ Root directory
    + directory 1
    - directory 2
        + directory 1
        - file 1
        - file 2
        - file 3
    - file 1
    - file 2
```

In Windows, each storage device has its own root directory: `C:\` is the root directory of the `C` disk drive, `D:\` is the root directory of the `D` disk drive, et cetera. 

In Linux and other Unix-like operating systems, the entire system exists within one big filesystem tree, with a single root directory: `/`. Everything in the system, including other disks and filesystems, exists within the main root filesystem. It may seem strange at first, as it did to me, but trust me, once you see how this all works, you will prefer it over Window's disk-based system.

## Moving around the file system

### Current working directory
The `pwd` command (print working directory) will return the path to your current location in the filesystem.

```
dennis@flappy:~$ pwd
/home/dennis
```

Here we're in the "home" directory for the current user.

### List contents of directory
The `ls` command will list the contents of the current working directory.
```
dennis@flappy:~$ ls
AppImages                dennisgpg_secretkey.asc  FreeCAD     OpenPLC   sensehat_pi_bin  Websites
BambuP1S                 Desktop                  GIMP        Pictures  Sync
bin                      Documents                Monero      Public    Templates
dennisgpg_publickey.asc  Downloads                Multiboard  Python    Videos
dennisgpg_revoke.asc     ebooks                   Music       ROMs      vimwiki
```
You can't see it here, but in your terminal, the directories should be a different color than regular files. Or, if there are no colors, directories will be denoted by a trailing `/` on their name, like: `Music/`.

You can also list the contents of other directories by providing them as arguments.

```
dennis@flappy:~$ ls Python
30-Days-Of-Python          CrashCourse    pyglog              spyblog            twilio-sms.py
advent_of_code             freeCodeCamp   pykata              spyblog_test_blog
automate_the_boring_stuff  Games          randomRenamer       toolbox
basic-computer-games       input_checker  sandbawks           turtles
basic-python-games         PPP            sorting-algorithms  tutorials
```

And you can list the contents of directories even further away, if you know the path.

```
dennis@flappy:~$ ls Python/sorting-algorithms/
bubble.py  bubble_recursive.py  factorial.py  merge.py  selection.py
```

You can get a more detailed listing of the directory by adding the `-l` (long) option flag. By the way, options always come *before* arguments. And we'll add the `h` option in there to get file sizes in a human-readable format.

```
dennis@flappy:~$ ls -lh Downloads
total 6.4G
-rw-r--r--. 1 dennis dennis  59K Oct  9 17:19  Budget+Worksheet.xlsx
-rw-r--r--. 1 dennis dennis 766K Nov 17 18:14  favicon_io.zip
-rw-r--r--. 1 dennis dennis  89K Nov 18 18:15 'ID Card.pdf'
-rw-r--r--. 1 dennis dennis 112M Apr 11  2025  KindleDataBackup20230411.tar.xz
-rw-r--r--. 1 dennis dennis 2.0M Dec 12  2024  old-library-trinity-college-dublin.jpeg
-rw-r--r--. 1 dennis dennis 6.3G Nov 12 18:19  omarchy-3.1.7.iso
```
### Change directory

Ok, so now that we can see where we are, let's try going somewhere. That's what the `cd` (change directory) command is for. Just tell it where you want to go. First, make sure you're in your home directory. If you're not, or you're not sure, close the terminal window and start a new one.

```
dennis@flappy:~$ cd Documents/
dennis@flappy:~/Documents$ 
```

Notice how your prompt has changed to reflect your current location in the filesystem. Now let's go back to the previous directory. You don't usually see it but the current directory is indicated by a single `.`, and the next directory up in the tree is indicated by two: `..`. So, to get back to where we were...

```
dennis@flappy:~/Documents$ cd ..
dennis@flappy:~$ 
```

Here are a couple other useful `cd` shortcuts:


| Shortcut       | Action                                                                                          |
| -------------- | ----------------------------------------------------------------------------------------------- |
| `cd`           | Without any arguments, `cd` will take you back to your home directory                           |
| `cd -`         | Takes you to the previous directory (which may or may not be the next directory up in the tree) |
| `cd ~bob_vila` | Takes you to user `bob_vila`'s home directory.                                                  |

## Pathnames
A path name is a string of text that describes where something lives on the filesystem. There are two types of pathnames: absolute and relative. *Absolute pathnames* describe the location of a file from the root directory. A *relative pathname* describes the location relative to your current location. For instance, if I wanted to point to a file called `MyFavoriteCheeses.md` in my Documents folder, while my current working directory is my home directory, it could look like either of these:

- **Absolute** 👉 `/home/dennis/Documents/MyFavoriteCheeses.md`
- **Relative** 👉 `./Documents`
- **Relative** 👉 `Documents`

I gave two relative pathname examples because the `./` represents the current working directly. Whenever the pathname does not start with a `/`, the shell assumes the pathname is relative, and so the `./` is implied and optional. You can also use the `..`, which signifies the previous directory. Say you are in the `Documents` directory and you wanted to point to a file in the `Pictures` directory. That would look like this: `../Pictures/pic001.jpg`.

## Filenames
Here are some important things you should know about filenames.

### Hidden Files And Directories
Any filenames starting with a `.` are hidden from the default output of `ls`. To see them: `ls -a`. There are a lot of these "dot files" in your home directory. Most of them are "config files" used to set options in various programs on your computer.

### Case Sensitive
Filenames in Linux are case-sensitive. That means, unlike in Windows, `file1` and `File1` are two different files.

### File Extensions
While you will generally see file extensions like `.jpg` and `.txt`, the extension is not required to determine the file type. `TextFile.txt` and `TextFile` are both text files. However, while the OS doesn't care much about file extensions, many applications do, and it makes it easier for you to see the type of each file. So it's a good idea to use them.

### Special Characters
Linux supports the use of long filenames with spaces and punctuation characters. For example `This is a file? with a *really long* name.md` is a valid filename. But referencing that in a filepath is a typing nightmare, because all the special characters need to be indicated by a `\`: `~/Documents/This\ is\ a\ file\?\ with\ a\ \*really\ long\*\ name.md`.

You can see how easy it would be to miss a single `\` in this long string and wind up with an error.

Also, in the shell, arguments to a command are separated by spaces, so that's another reason do not use them in your file name. `file_name` appears as a single file to the shell, but `file name` looks like two files.

So, although Linux allows you to play fast and loose with filenames, limit the use of special characters to underscores `_`, dashes `-` and periods `.`. If you want to improve the readability of your filenames without spaces, use "camel case" or substitute underscores or dashes for spaces.

- `CamelCaseFileName.md`
- `underscores_not_spaces.md`

# A Tour of The Filesystem
https://youtu.be/p9lCbFq8IPo?si=-FHZm6GvXh9xH9m-

Now that we know how to move around directories in the filesystem and see what's in them, let's go on a guided tour of a typical Linux filesystem. Let's start where all things begin in a Linux filesystem: `/` the root directory. Enter the root directory and list its contents.

```
dennis@flappy:/$ ls -l
total 20
dr-xr-xr-x.   1 root root    0 Jul 29 20:00 afs
lrwxrwxrwx.   1 root root    7 Jul 29 20:00 bin -> usr/bin
dr-xr-xr-x.   6 root root 4096 Nov 12 21:36 boot
drwxr-xr-x.  22 root root 4960 Nov 22 09:44 dev
drwxr-xr-x.   1 root root 5056 Nov 21 14:19 etc
drwxr-xr-x.   1 root root   12 Jul 29 20:00 home
lrwxrwxrwx.   1 root root    7 Jul 29 20:00 lib -> usr/lib
lrwxrwxrwx.   1 root root    9 Jul 29 20:00 lib64 -> usr/lib64
drwx------.   1 root root    0 Apr 14  2024 lost+found
drwxr-xr-x.   1 root root    0 Jul 29 20:00 media
drwxr-xr-x.   1 root root    0 Jul 29 20:00 mnt
drwxr-xr-x.   1 root root   52 Jul 29 20:00 opt
dr-xr-xr-x. 521 root root    0 Nov 20 17:35 proc
dr-xr-x---.   1 root root  190 Nov  9 06:57 root
drwxr-xr-x.  62 root root 1580 Nov 21 10:38 run
lrwxrwxrwx.   1 root root    8 Jul 29 20:00 sbin -> usr/sbin
drwxr-xr-x.   1 root root    0 Jul 29 20:00 srv
dr-xr-xr-x.  13 root root    0 Nov 20 17:35 sys
drwxrwxrwt.  27 root root  740 Nov 22 10:46 tmp
drwxr-xr-x.   1 root root  168 Nov  3 15:54 usr
drwxr-xr-x.   1 root root  200 Nov  3 16:03 var
```

The number and names of these directories may be slightly different on your system. I'll explain the ones most common to all Linux distributions.


| Directory | What's inside                                                                                                                                                                                                                 |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/bin`    | Essential commands that everyone needs. Things like: `ls`, `cat`, `cp`, `mv`, `bash`, `mkdir`, `echo`, `sleep`. Everything needed to boot or fix the system is in here.                                                       |
| `/boot`   | Files the bootloader needs to start Linux. Things like kernel images, `initramfs`, GRUB config files, EFI boot files, all live here.                                                                                          |
| `/dev`    | Files that represent devices in the computer. Your keyboard, disk drives, USB devices, even the CPU all live here in the form of special device files.                                                                        |
| `/etc`    | ETC = Editable Text Config. Configuration files for system-wide applications and services live here. Things like Wi-Fi settings, user accounts, file system settings.                                                         |
| `/home`   | Each user has their own directory in here: `/home/Matthew`, `/home/Mark`. And within each user directory is where all their personal files live.                                                                              |
| `/lib`    | Libraries that are required for programs in `/bin` or `/sbin`. Libraries are like `.dll` files in Windows.                                                                                                                    |
| `/media`  | Is where the system auto-mounts removable media like USB hard drives, CDs and DVDs.                                                                                                                                           |
| `/mnt`    | The place where sysadmins or the system itself "mounts" things to the filesystem tree, usually storage devices.                                                                                                               |
| `/opt`    | Optional third-party software, usually proprietary, closed-source stuff like: Google Chrome, Steam, Zoom, live here.                                                                                                          |
| `/proc`   | Files in here represent running processes on the system. It's not "real" in the sense that these files don't actually exist on the system. They're generated on the fly and come and go as processes start and stop.          |
| `/root`   | The home directory of the root user. The root user is the super-admin able to do anything on the system.                                                                                                                      |
| `/run`    | Contains temporary runtime data - stuff that only exists while the system is running. Nothing in here survives a reboot. It's also where your USB memory sticks will be automatically mounted: `/run/media/username/USBname`. |
| `/sbin`   | Essential system binaries. Things like `fdisk`, `reboot`, `ip`, `mkfs`. And other tools you typically need root-access for.                                                                                                   |
| `/srv`    | Data for web server files (`/srv/www`), or FTP server files (`/srv/ftp`). This is typically empty for desktop systems.                                                                                                        |
| `/sys`    | Kernel and hardware settings                                                                                                                                                                                                  |
| `/tmp`    | Programs write temporary files here, and it's usually wiped every reboot.                                                                                                                                                     |
| `/usr`    | Basically everything else not essential to the system. Binaries of programs for all users, libraries, icons, and programs you compiled yourself.                                                                              |
| `/var`    | Variable data - the files in here change a log. Log files, server content, cache, spool (print jobs). Things like that.                                                                                                       |

That's a lot of stuff. So here's a shorter way to remember everything:

- If it's needed to boot or fix the system 👉 `/bin`, `/sbin`, `/lib`, `/etc`, `/boot`
- If it's about the current running system 👉 `/proc`, `/sys`, `/run`, `/dev`
- If it's your stuff 👉 `/home/YourUserName`
- If it keeps growing or changing 👉 `/var`

## A Closer Look at The Root

### Is it a command or a program?
You've just had a look at what's in the top-most directory, I want to show you a couple more things around here, and we'll learn some new commands along the way.

List the contents of `/bin`. I'm not going to copy the output here because there are *a lot* of files in this directory. But if you look through, you may notice there are files in here sharing the names of some of the commands we've been using so far, like `ls` and `cd` are both in here. Try this:

```
dennis@flappy:/$ file /bin/ls
/bin/ls: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=f7a7b83c94d071d23cefa87c3c444779b0b000a9, for GNU/Linux 3.2.0, stripped
```

The `file` command tells you the file type of any file you pass to it. We can see here that what we have been calling the "command" `ls` is actually an executable binary file. That's the case with *all the commands* we will be talking about here. Every command is just a tiny little program. Find an image file on your computer, and see what the `file` command has to say about it.

```
dennis@flappy:~$ file Pictures/ye_olde_pic.png 
Pictures/ye_olde_pic.png: PNG image data, 1024 x 1024, 8-bit/color RGB, non-interlaced
```

It brings back some information about the picture. We now know it's a PNG image file, which is useful because remember, file extensions are not how file types are determined in Linux. We also can see the size of the image among other things. "What's so useful about this?" You might be asking. Well maybe you have a ton of pictures and you want to sort them by their pixel widths. This information would be useful in a script doing such a thing. Maybe we'll write such a script later on in this article.

### Filesystem Table
Let's take a closer look at the `/etc` directory. This is where many configuration files are kept. On Linux, many programs use plain text files to set options and preferences for the program. If you have Firefox installed on your computer, there's likely an `/etc/firefox` directory. Configuration files here would effect every user on the system.

Another important file that lives here is `fstab`: the filesystem table. Take a look at it:

```
dennis@flappy:~$ cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Mon Sep 16 12:14:03 2024
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
UUID=69ef0120-de69-40af-9aaa-631ae020c702 /                       btrfs   subvol=root,compress=zstd:1 0 0
UUID=d11e9e37-cc6a-4276-a53d-139165c3f953 /boot                   ext4    defaults        1 2
UUID=8CE4-69B7          /boot/efi               vfat    umask=0077,shortname=winnt 0 2
UUID=69ef0120-de69-40af-9aaa-631ae020c702 /home                   btrfs   subvol=home,compress=zstd:1 0 0
```

First, I'd like to point out the new command we just used here: `cat`. It's short for *concatenate* and usually it's used to join two or more files together end-to-end. But if you give it just one file, it will simply print out its contents. 

This file describes all the filesystems that should be mounted at boot time. To "mount" a filesystem simply means to make the content The last line here is particularly important. the device, here represented by its Universally Unique Identifier (UUID), is mounted to `/home`. This means the entire `/home` directoryof a file storage device available in the main filesystem tree. Each line of this file represents a device or partition of a device, where it's mounted, and what filesystem it's using. If you have an extra hard disk on your system that you want available automatically at boot time, you'll need to add it to this file. We'll go over that later.

### Device Files
Everything in a Linux system is a file. And I mean *everything*. Even devices are represented as files on the system. List the contents of `/dev/input` and you will see one or more `mouse` files that represents your mouse. List the contents of `/dev` and look for your disk drives listed here. If you have multiple hard disk drives, they'll be listed as `hd0`, `hd1` and so on. Solid-state drives are `sd` and NVME storage is listed as `nvme0`.

There's also pseudo devices in here - things that are no physical devices like mice and disks, but are treated as devices anyway - `/dev/random` is one such device. All it does is constantly spit out random bits of data, which is useful for things like encryption. Try typing `cat /dev/random` - you will see tons of gibberish stream by your eyes. Press `Ctrl-C` to stop it.

`/dev/null` is like a black hole on your computer, where everything that goes into it just disappears. Let's demonstrate this. Try this command:

```
dennis@flappy:~$ yes "I love Fedora"
^C
```

Before you can blink, your screen will fill up with "I love Fedora". The `yes` program simply repeats the input string until the program is killed. Press `Ctrl-C` to stop it. Now let's see what happens if we send the output of `yes` to the black hole.

```
dennis@flappy:~$ yes "I'm flying into a black hole!" > /dev/null
^C
```

The terminal appears to do nothing, but it's not doing nothing! The `yes` program is returning an endless series of strings, but they are being redirected `>` to the null device, which is just eating it up. This will go on forever, so press `Ctrl-C` to stop it.

### Automatic Mounting
Most modern Linux distributions will automatically mount things like USB flash drives and SD cards. Try looking at `/run/media/YourUserName/`, do you see anything in there? If not, connect an SD card or USB flash drive and check again.

```
dennis@flappy:~$ ls /run/media/dennis
dennis@flappy:~$ ls /run/media/dennis
GCODE
```


## A Closer Look at Long Listings

A long list of a directory gives us some very useful information. Let's look at my home directory and explain each column, left to right.

```
dennis@flappy:~$ ls -lh
total 20K
drwxr-xr-x. 1 dennis dennis  274 Nov 10 17:15 AppImages
drwxr-xr-x. 1 dennis dennis  340 May 29 16:42 BambuP1S
drwxr-xr-x. 1 dennis dennis  108 Nov 19 19:07 bin
-rw-r--r--. 1 dennis dennis 3.1K Feb  5  2023 dennisgpg_publickey.asc
-rw-------. 1 dennis dennis  918 Feb  5  2023 dennisgpg_revoke.asc
-rw-r--r--. 1 dennis dennis 6.7K Feb  5  2023 dennisgpg_secretkey.asc
drwxr-xr-x. 1 dennis dennis 1.1K Nov 19 16:50 Desktop
drwxr-xr-x. 1 dennis dennis  970 Nov 18 18:16 Documents
drwxr-xr-x. 1 dennis dennis  266 Nov 22 07:54 Downloads
drwxr-xr-x. 1 dennis dennis 1.7K Nov 22 07:54 ebooks
drwxr-xr-x. 1 dennis dennis  698 Nov  3 18:27 FreeCAD
drwxr-xr-x. 1 dennis dennis  682 Jun 17  2023 GIMP
drwxr-xr-x. 1 dennis dennis  444 Mar 21  2025 Music
drwxr-xr-x. 1 dennis dennis 2.3K Nov 17 18:21 Pictures
drwxr-xr-x. 1 dennis dennis    0 Sep 16  2024 Public
drwxr-xr-x. 1 dennis dennis  518 Nov 22 07:43 Python
drwxr-xr-x. 1 dennis dennis   18 Oct 12  2024 Sync
drwxr-xr-x. 1 dennis dennis   94 May 25 07:28 Templates
drwxr-xr-x. 1 dennis dennis  168 Jun  6 07:36 Videos
drwxr-xr-x. 1 dennis dennis  200 Nov 16  2024 vimwiki
drwxr-xr-x. 1 dennis dennis  582 Nov 15 20:36 Websites
```

- Column 1, file type and permissions. This is a string of 10 characters describing the file type and permissions.
	- First character (file type):
		- `-` regular file
		- `d` a directory
		- `l` a symlink
		- `c` a character device
		- `b` a block device (hard disk, SSD, etc)
		- `p` a named pipe
		- `s` socket
	- The following 9 characters describe the permissions of the file's owner, the group, and everyone else. They can be any combination of:
		- `r` - read
		- `w` - write
		- `x` - execute
	- 
## Links

If you do a long-listing of a directory, you may notice some files have a funky arrow that looks like this: `->`.

```
lrwxrwxrwx. 1 dennis dennis    31 Dec 23  2024 .steampath -> /home/dennis/.steam/sdk32/steam
```

These files are *links*. There are symbolic links and hard links. In my experience most links are symbolic
