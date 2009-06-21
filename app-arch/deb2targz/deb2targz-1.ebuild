# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deb2targz/deb2targz-1.ebuild,v 1.13 2009/06/19 22:07:35 ranger Exp $

DESCRIPTION="Convert a .deb file to a .tar.gz archive"
HOMEPAGE="http://www.miketaylor.org.uk/tech/deb/"
SRC_URI="http://www.miketaylor.org.uk/tech/deb/${PN}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${PN} "${S}"
	sed -i -e 's,#!/usr/bin/perl,#!'"${EPREFIX}"'/usr/bin/perl,' ${PN}
}

src_install() {
	dobin ${PN}
}
