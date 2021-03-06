# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=6

inherit git-r3 eutils autotools flag-o-matic

DESCRIPTION="An open-source karaoke game"
HOMEPAGE="http://usdx.eu/"
EGIT_REPO_URI="https://github.com/UltraStar-Deluxe/USDX/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="projectm debug webcam"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl2[opengl]
	media-libs/sdl2-image
	media-libs/freetype
	media-libs/libpng
	=media-libs/portaudio-19*
	media-video/ffmpeg
	dev-db/sqlite
	dev-lang/lua
	projectm? ( media-libs/libprojectm )
	webcam? ( media-libs/opencv )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-lang/fpc-3.0.0"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_with projectm libprojectM) \
		$(use_enable debug) \
		|| die "econf failed"
}
src_compile() {
	emake LDFLAGS="$(raw-ldflags)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc COPYRIGHT.txt ChangeLog.txt README.md

	doicon icons/${PN}-icon.svg
	make_desktop_entry ${PN} "UltraStar Deluxe"
}
