---
tags:
  - Linux
  - Fedora
title: Fedora Post-Installation Tips
date: 2025-11-16
---
So you've just installed Fedora on your computer? Well done! I for one, think you've just made the best operating system choice. In my opinion, Fedora is the best general-purpose Linux-based operating system. But there are a few things I would encourage you to do, as soon as possible, to improve your experience.

All of these improvements will be implemented through the command line. If you are *really new to Linux*, or just have command-line anxiety, don't worry. Just copy, paste, and you're good to go. However I would encourage you to really learn *what these commands do*, and learn how to use the command line interface. In doing so, you will know more about how your system works. The more you know how it works, the easier it will be to fix it if things go wrong. My [[Command-line Crash Course]] is a good place to learn the basics.

Let's get started making the best operating system even better.

# Package Improvements
## Improve `dnf` configuration
By default, Fedora's `dnf` package manager only downloads one package at a time. But I'm pretty sure even African villages these days have enough bandwidth to handle more. `dnf` also defaults to *no* any time you are asked for confirmation. Let's change the default to *yes* so you can just hit enter twice to run your update or install new packages.

Run this command: `sudo gnome-text-editor /etc/dnf/dnf.conf`, and add these lines to the end of the file.

  ```bash
  # Speed enhancements:
  fastestmirror=True
  max_parallel_downloads=5 
  defaultyes=True
  keepcache=True
  ```

Save and close the file.

If you're interested in seeing what other `dnf` settings you can change, check out the [dnf Configuration Reference](https://dnf.readthedocs.io/en/latest/conf_ref.html).

## Update the system

Now that you have a faster `dnf`, run a system update to make sure you have all the latest and greatest packages.

```bash
sudo dnf update
```

## Enable RPM Fusion

By default, Fedora draws from package repositories that contain only Free software. There is a lot of software that is not "free software" by strict definition. But just because it doesn't meet the definition doesn't mean it's bad. Once enabled, a lot more packages will be available from your Software app.

Run the installation command:

  ```bash
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Then run the update:

```bash
sudo dnf groupupdate core
  ```

And that's all for this tip. Check out [RPM Fusion Configuration](https://rpmfusion.org/Configuration) for more details.

## Add The Flathub Package Repository

Since Flatpaks are a universal package format developed by RedHat, of course Fedora is able to use Flatpaks out of the box. However, by default you are restricted to only Fedora's Flatpak repository, which strictly excludes non-free (as in freedom) software. A program like Zoom contains proprietary code, and is therefore excluded from the default repositories. You can go to [flathub.org](https://flathub.org) and download/install packages from there. But running the commands below makes all of these packages conveniently available to you from the Software application.

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

For more information about Flatpaks, check out [flatpak.org](https://flatpak.org).

## Install Media Codecs

These media codecs are a must-have if you plan on watching any videos online at [Odysee](https://odysee.com), YouTube or similar sites. 

```bash
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
```

# Desktop Environment Customization
## GNOME Extensions
Fedora is set up with GNOME desktop environment. It's the most popular desktop environment, and for good reason. GNOME has extensions that can add lots of additional features to the desktop. Let's install Tweaks and Extensions. The Extensions app allows you to manage your installed extensions, and Tweaks gives you access to a few extra options, not available in the Settings app.

Everything can be installed with one line:
```bash
sudo dnf install gnome-tweaks gnome-extensions-app chrome-gnome-shell
```

After installation, head over to [extensions.gnome.org](https://extensions.gnome.org) to find some extensions. Extensions can be installed directly from the site by simply clicking the install button. Here are some of the extensions I currently use.

- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/) 👈 Temporarily disables screen saver and system suspension.
- [Emoji Copy](https://extensions.gnome.org/extension/6242/emoji-copy/) 👈 Search for emoji and copy them to your clipboard.
- [Quake Terminal](https://extensions.gnome.org/extension/6307/quake-terminal/) 👈 Assign a keyboard shortcut to bring a terminal in and out of view from the top of the screen, like in the classic video game Quake.
- [Pomodoro Timer](https://extensions.gnome.org/extension/8790/pomodoro-timer/) 👈 A timer that locks you out of your system at set intervals. Taking regular timed breaks is surprisingly effective and keeping you focused.
- [System Monitor](https://extensions.gnome.org/extension/6807/system-monitor/) 👈 Know what your CPU, memory, and other vitals are up to at a glance.
- [Tiling Shell](https://extensions.gnome.org/extension/7065/tiling-shell/) 👈 Bring some nice window-tiling features to a floating window environment.

## Wallpapers
Some people don't care about wallpapers. Often just sticking to the default. Myself on the other hand, I'm definitely guilty of spending several hours looking for the perfect wallpaper and I've amassed a collection of them over the years. My favorite place to find wallpapers these days is [wallhaven.cc](https://wallhaven.cc).  They have excellent search and filtering to help you find just the right one. Honorable mention goes to [gnome-look.org](https://gnome-look.org) because many of their wallpapers come in light/dark mode pairs.
# Performance And Hardware Optimization
## Nvidia GPUs
Fedora will handle Intel/AMD integrated graphics out of the box. But if you have an NVIDIA GPU, you'll need to install proprietary drivers. Here's how you install the NVIDIA drivers:

```bash
sudo dnf install akmod-nvidia
```

Reboot once the installation is complete.

## Battery Optimization
When it comes to laptops, I've only ever used retired enterprise level laptops from Dell. For me, Fedora has always been perfect out  of the box when it comes to battery management. But other brands, or consumer grade laptops could benefit from  `tlp`: a command line utility that helps save battery power.

There is no graphical front-end for this program. If you want to tweak settings, it will need to be done through a terminal. But fear not: the default settings for `tlp` are optimized for battery life. So all you'll need to do is install it, and `tlp` will take care of the rest.

# Other Tips
## Change Your hostname

A **hostname** is a label assigned to a device connected to a network. I highly recommend giving your computer some easy to remember hostname if you're going to be managing anything about it from somewhere else, like a router or firewall.

Most distributions ask you to give your computer a host name at installation time. Fedora opts to make one up for you based on your hardware. If you want to change it, it's as easy as one command:

```bash
sudo hostnamectl set-hostname "new_hostname_here"
```
# That's All!

With this handful of commands, your installation of Fedora should not be capable of everything you need. As you may have noticed, most of it is just gaining access to some extra software repositories and codecs not installed by default because they may not contain 100% Free software. While this is an inconvenience to some, I don't think it's a big deal. I appreciate the Fedora Project's commitment to Free software. Even a new user should be able to handle copy/pasting these commands to make their Fedora more useful.
