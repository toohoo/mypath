# mypath
Command line Tool (written in Perl) for working with PATH on Windows

## prerequisites
* installed Perl with executable in PATH
* necessary files reside in `d:\temp` - otherwise change programming - put all files there.
* directory `d:\temp` is already in PATH

## usage
the usage states this
```
mypath.pl - Thomas Hofmann, Apr. 2010 - PATH Handling
Usage/Benutzung: [perl] mypath.pl [-q] {delete|unshift|push} (dir1) [{delete|unshift|push} (dir2) ..]
Usage2/Benutzung2: [perl] mypath.pl list [-all|(dir-fragment)]
-q   Quiet, some messages are suppressed,
     or set environment variable MYPATH_QUIET=[1,yes,true,on]
```
Set switch `-q` for "quiet" operation, some messages are suppressed.
Instead of using switch `-q` you can set environment variable MYPATH_QUIET=[Ja|Yes|true|1|-q|On]
On Usage2 switch `-q` has no effect.

Instead of using `perl mypath.pl` you can use the `mypath.bat` with same effect.

## be aware
* After changing the PATH call batch `mypathnew.bat` (also resides in `d:\temp` )
to let the changes take effect.
* Be aware of directories with spaces, set them in double quotes (").
