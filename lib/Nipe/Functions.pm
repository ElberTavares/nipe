#!/usr/bin/perl

#########################################################
# Nipe developed by Heitor Gouvêa                       #
# This work is licensed under MIT License               #
# Copyright (c) 2015-2016 Heitor Gouvêa                 #
#                                                       #
# [+] AUTOR:        Heitor Gouvêa                       #
# [+] EMAIL:        hi@heitorgouvea.me                  #
# [+] GITHUB:       https://github.com/GouveaHeitor     #
# [+] TWITTER:      https://twitter.com/GouveaHeitor    #
# [+] FACEBOOK:     https://fb.com/GouveaHeitor         #
#########################################################

package Nipe::Functions;

sub help {
	print "\n\tCOMMAND \t FUCTION\n
	install \t to install
	start   \t to start
	stop    \t to stop\n\n";
}

sub config {
	my $os = `cat /etc/os-release | grep 'ID' | cut -d '=' -f 2`;

	my ($username, $manager);

	if ($os =~ /[A,a]rch/) {
		$username = "tor";
		$manager  = "pacman -S";
	}

	elsif (($os =~ /[U,u]buntu/) || ($os =~ /[D,d]ebian/)) {
		$username = "debian-tor";
		$manager  = "apt-get install";
	}

	elsif ($os =~ /[F,f]edora/) {
		$username = "toranon";
		$manager  = "dnf install";
	}

	else {
		$username = "tor";
		$manager  = "apt-get";
	}


	return $manager;
}

sub install {

	my $manager = Nipe::Functions -> config();

	system ("sudo $manager tor iptables");

	if (($os =~ /[U,u]buntu/) || ($os =~ /[D,d]ebian/)) {
		system ("sudo wget http://heitorgouvea.me/nipe/ubuntu/torrc");
	}

	elsif ($os =~ /[A,a]rch/) {
		system ("sudo wget http://heitorgouvea.me/nipe/arch/torrc");
	}

	elsif ($os =~ /[F,f]edora/) {
		system ("sudo wget http://heitorgouvea.me/nipe/fedora/torrc");
	}

	else {
		system ("sudo wget http://heitorgouvea.me/nipe/arch/torrc");
	}

	system ("sudo mkdir -p /etc/tor");
	system ("sudo mv torrc /etc/tor/torrc");
	system ("sudo chmod 644 /etc/tor/torrc");
}

1;
