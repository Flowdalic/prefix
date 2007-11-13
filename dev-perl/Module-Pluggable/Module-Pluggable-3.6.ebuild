# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Pluggable/Module-Pluggable-3.6.ebuild,v 1.5 2007/11/10 12:41:28 drac Exp $

EAPI="prefix"

inherit perl-module

DESCRIPTION="automatically give your module the ability to have plugins"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SI/SIMONW/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc-solaris ~x86 ~x86-macos"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/module-build-0.28
	dev-perl/Class-Inspector
	virtual/perl-File-Spec
	dev-lang/perl"
