---
title: ncl - G-code linter in Bash
description: I kept running into silly error with g-code files. So I used bash to fix it.
aliases:
tags:
  - CNC
  - Linux
  - BASH
date: 2025-11-24
draft: false
---
This is one of the first projects I completed right after learning to use BASH, AWK and other GNU coreutils. I call it a "linter" but it's not a full-blown NC linter. More like a common problem checker that's tailored specifically for the problems I was facing with G-code and the DNC system at chesterton, so it may or may not be useful for anyone else. This was mostly just a programming exercise while also fixing a problem.

[View the source code on GitHub](https://github.com/iSmashButtons/Manufacturing-Scripts/blob/main/nc-linter/ncl.sh)

I created this because so many of the NC program files my shop inherited were full of errors. I had operators approaching me several times a day saying they could not download a program to the machine or the program was setting off machine alarms. More often than not the cause was a missing or extra character and it was really irritating me. So I set out to create this little program that I could run periodically in order to fix any bad programs that were added to the library.

The AWK script in this program checks for and fixes the following errors:

- first char of first line is not transmission marker (`%`)
- program address is `:` instead of `O`
- extraneous transmission markers
- leading/trailing whitespace on lines
- open comments
- double-decimals (`X10.0.0`)
- missing address (value without a corresponding address, eg: `0.1234`)
- decimal values exceeding 4 digits.

If any errors are found and fixed, the changes made are logged and the modified program files are written to a separate directory where they can be double-checked by a human before replacing the originals. The logs output for each file include a terse error description along with the line numbers where the error appeared. Some “errors”, like leading/trailing spaces, don’t cause any trouble at the machine but they are ugly. For these errors the total number of lines is output instead of unique line numbers.

