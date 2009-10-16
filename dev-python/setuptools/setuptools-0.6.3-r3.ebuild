# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools/setuptools-0.6.3-r3.ebuild,v 1.2 2009/10/03 17:32:46 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A collection of enhancements to the Python distutils including easy install"
HOMEPAGE="http://pypi.python.org/pypi/distribute"
SRC_URI="http://pypi.python.org/packages/source/d/distribute/distribute-${PV}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# Avoid silent errors during upgrade from older versions.
DEPEND="!!<dev-python/setuptools-0.6.3-r2"
RDEPEND=""

S="${WORKDIR}/distribute-${PV}"

DOCS="README.txt docs/easy_install.txt docs/pkg_resources.txt docs/setuptools.txt"

pkg_setup() {
	# Older versions of Portage don't support !! dependencies correctly (bug #270953).
	if has_version "<dev-python/setuptools-0.6.3-r2"; then
		die "<dev-python/setuptools-0.6.3-r2 must be uninstalled before installation of newer versions to avoid silent errors"
	fi

	# Delete unneeded files which cause problems. These files were created by some older, broken versions.
	rm -fr "${EROOT}"usr/lib*/python*/site-packages/{,._cfg????_}setuptools-*egg-info || die "Deletion of broken files failed"
}

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-0.6_rc7-noexe.patch"

	# Remove tests that access the network (bugs #198312, #191117)
	rm setuptools/tests/test_packageindex.py
}

src_test() {
	tests() {
		PYTHONPATH="." "$(PYTHON)" setup.py test
	}
	python_execute_function tests
}
