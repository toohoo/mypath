# mypath
(Perl) Tool for working with PATH on Windows

## prerequisites
* installed Perl with executable in PATH
* necessary files reside in `d:\temp` - otherwise change programming
* directory `d:\temp` is already in PATH

## usage
the usage states this
```
mypath.pl - Thomas Hofmann, Apr. 2010 - PATH Handling
Usage/Benutzung: [perl] mypath.pl {delete|unshift|push} (dir1) [{delete|unshift|push} (dir2) ..]
Usage2/Benutzung2: [perl] mypath.pl list [-all|(dir-fragment)]
```

## be aware
* After changing the PATH call batch mypathnew.bat (also resides in `d:\temp` )
to let the changes take effect.
* Be aware of directories with spaces, set them in double quotes (").
