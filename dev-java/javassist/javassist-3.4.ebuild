# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javassist/javassist-3.4.ebuild,v 1.5 2008/03/28 07:33:09 opfer Exp $

EAPI="prefix"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

# TODO add notes about where the distfile comes from
DESCRIPTION="Javassist makes Java bytecode manipulation simple."
SRC_URI="mirror://sourceforge/jboss/${P}.zip"
HOMEPAGE="http://www.csg.is.titech.ac.jp/~chiba/javassist/"

LICENSE="MPL-1.1"
SLOT="3"
KEYWORDS="~amd64-linux ~x86-linux ~x86-macos"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar || die
	java-ant_rewrite-classpath build.xml
}

src_compile() {
	eant clean jar $(use_doc javadocs) -Dgentoo.classpath=$(java-config --tools)
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dohtml Readme.html || die
	use doc && java-pkg_dojavadoc html
	use source && java-pkg_dosrc src/main/javassist
}
