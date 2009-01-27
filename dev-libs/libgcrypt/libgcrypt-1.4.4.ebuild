# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.4.4.ebuild,v 1.1 2009/01/25 21:30:26 dragonheart Exp $

EAPI="prefix"

inherit eutils

DESCRIPTION="general purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/libgcrypt/${P}.tar.bz2
	ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.bz2
	!bindist? ( idea? ( mirror://gentoo/${PN}-1.4.0-idea.diff.bz2 ) )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bindist"

RDEPEND=">=dev-libs/libgpg-error-1.5"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# include sys/time.h for fd_set on interix
	epatch "${FILESDIR}"/${PN}-1.4.0-interix.patch
	[[ ${CHOST} == *-interix3* ]] && epatch "${FILESDIR}"/${PN}-1.4.0-interix3.patch

	# remove the included libtool.m4 to force a new libtool
	# to be used.
	rm -f m4/libtool.m4

	AT_M4DIR="m4" eautoreconf # need new libtool for interix
}

src_compile() {
	# --disable-padlock-support for bug #201917
	econf \
		--disable-padlock-support \
		--disable-dependency-tracking \
		--with-pic \
		--enable-noexecstack
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
}
