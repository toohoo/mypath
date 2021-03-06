#!/usr/bin/perl
##########################################
# mypath.pl
# Thomas Hofmann, Apr. 2010, thomas@th-o.de
# PATH Handling
# Functions/Funktionen:
# 	delete, (to be removed directory/zu loeschendes Verzeichnis)
# 	unshift, (add directory on begin of PATH/am Anfang einzufuegendes Verzeichnis)
# 	push, (add directory at the end of PATH/am Ende einzufuegendes Verzeichnis)
##########################################

#print "1: $ARGV[0]\n2: $ARGV[1]\n";
#print "... vor if ($#ARGV < 1)\n";
#print "\$#ARGV [$#ARGV]\n";
#print "\$ARGV[0/1] [$ARGV[0]/$ARGV[1]]\n";
if ( ( $#ARGV < 1 ) && ( $ARGV[0] !~ /list/i ) ) {&abbruch();}
#print "... nach if ($#ARGV < 1)\n";
my $quiet = 0;
if ( $ARGV[0] =~ /-q/i ) { $quiet = shift @ARGV; }
if ( $ENV{MYPATH_QUIET} =~ /^(Ja|Yes|true|1|-q|On)$/i ) { $quiet = '1'; }

my $path = $ENV{'PATH'};
#print "... before ENV{PATH}=[$ENV{'PATH'}] \n\n" if !$quiet;
#print "... before PATH=$path \n\n" if !$quiet;
#print "... before ENV{MYPATH_DEBUG}=[$ENV{'MYPATH_DEBUG'}] \n\n" if !$quiet;

my @path = split(/;+/,$path);
my $neupath = "d:\\temp\\mypathnew.bat";
my ($act, $dir);

# if list, then other job/wenn list, dann andere Behandlung
if ( $ARGV[0] =~ /list/i ) {
	print "... list ...\n" if $ENV{'MYPATH_DEBUG'}; # $quiet;
	shift(@ARGV);
	my @what = @ARGV;
	if( $what[0] ne '' ) {
		my $whatcount = @what; $whatcount++;
		print "... the many \@ARGV: $whatcount\n" if !$quiet;
		my $what = join( ' -- ', @what );
		print "... --- \@ARGV are: [$what]\n" if !$quiet;
	} else {
		@what = ();
		print "... no further \@ARGV on list\n" if $ENV{'MYPATH_DEBUG'}; #if !$quiet;
	}
	listdirs( @what );
	exit(0);
}

my ($parbegin, $rest, @dirrest, $nextact, $nextdir);
# if not 'list' then change directories/wenn nicht 'list' dann Verzeichnisse bearbeiten
while ($ARGV[1]) {
	$act = shift(@ARGV);
	$dir = shift(@ARGV);
	$dir =~ s/ +$//;
	$dir =~ s/\"$//;
	# ein '\"' ist Teufelswerk! Das beendet den Parameter nicht.
	while( $dir =~ m/^(.+?)\\?"(.*?)$/ ) { # while dir contains '"'
		$dir = $1;
		$rest = $2;
		if( $rest =~ m/ *(delete|unshift|push) +(.*?)$/i ) { # are there params after dir?
			$nextact = $1;
			$nextdir = $2;
			if( $nextdir =~ m/^ *"(.*?)$/ ) { # does nextdir start with '"'?
				push( @ARGV, $nextact, $nextdir); # push it and let it run into next while
			} else { # if nextdir doesn't start with '"' 
				@dirrest = split( / +/, $nextdir ); # then split it; 
				$dirrest[0] .= '"'; # put '"' at end of dir; 
				$nextdir = join( ' ', @dirrest ); # join it 
				push( @ARGV, $nextact, $nextdir); # => next while
			}
		}
	}
	
	#print ">>> [$act]:: $dir\n";
	
	if ($act =~ m/^delete$/i) {
		&delete($dir);
	} elsif ($act =~ m/^unshift$/i) {
		&delete($dir);
		unshift(@path,$dir);
		$path=join(';',@path);
	} elsif ($act =~ m/^push$/i) {
		&delete($dir);
		push(@path,$dir);
		$path=join(';',@path);
	} else {
		&usage("Wrong param/Falscher Parameter 1 [$act]");
	}
}
$ENV{'PATH'} = $path;
&ausgabe() if $ENV{'MYPATH_DEBUG'}; # !$quiet;
if (open(PATH,">$neupath")) {
	print "... write/schreibe $neupath\n" if !$quiet;
	print PATH "set PATH=$path\n";
	close(PATH);
}

sub usage {
	my ($mes,@rest) = @_;
	if (!($mes)) {
		$mes = "mypath.pl - Thomas Hofmann, Apr. 2010 - PATH Handling";
	}
	print <<__USAGE__;
$mes
Usage/Benutzung: [perl] mypath.pl [-q] {delete|unshift|push} (dir1) [{delete|unshift|push} (dir2) ..]
Usage2/Benutzung2: [perl] mypath.pl list [-all|(dir-fragment)]
-q   Quiet, some messages are suppressed, 
     or set environment variable MYPATH_QUIET=[1|yes|true|on]
__USAGE__

}

sub abbruch {
	my ($mes,@rest) = @_;
	&usage("Error/Fehler: " . $mes); 
	exit;
}

sub ausgabe {
	print "\nmyPATH=$path\n\n";
}

sub delete {
	my ($dir,@rest) = @_;
	my (@neu,$i);
	$dir = lc($dir);
	foreach (@path) {
		#if (lc($_) !~ m|^($dir\\)?$|i) {
		if ( (lc($_) ne $dir) && (lc($_) ne "$dir\\")) {
			#print "\tkeep/uebernehme[$_]\n";
			push(@neu,$_);
		} else {
			#print "\tREMOVE/LOESCHE[$_]\n";
		}
	}
	@path=@neu;
	$path=join(';',@path);
}

sub listdirs {
	my ( @what ) = @_;
	my ( $all, $what ) = ( '', '' );
	if ( ( $what[0] =~ /^-all$/i ) or ( $#what < 0 ) ) {
		$all = 1; 
	} else {
		$what = shift @what;
	}
	print "___ dir's actually ___\n" if $ENV{'MYPATH_DEBUG'};
	foreach my $p ( @path ) {
		print "$p\n" if ( $all or ( $p =~ /$what/i ) );
	}
}

1;
