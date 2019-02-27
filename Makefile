PROG=	fsnotifier
SRCS=	inotify.c main.c util.c
MAN=
CSTD=	c99
PREFIX?=	/usr/local

CFLAGS+=	-Wall -Wextra -D_DEFAULT_SOURCE

CFLAGS+=	-std=${CSTD} -I${PREFIX}/include${INOTIFY}
LDFLAGS+=	-L${PREFIX}/lib${INOTIFY} -Wl,-rpath=${PREFIX}/lib${INOTIFY}
LDFLAGS+=	-pthread

OS!=	uname -s
.if ${OS} == "OpenBSD"
INOTIFY?=	/inotify
.elif ${OS} == "NetBSD"
PREFIX=		/usr/pkg
CFLAGS+=	-D_NETBSD_SOURCE
.endif

.if defined(STATIC_INOTIFY)
LDADD=	/usr/local/lib${INOTIFY}/libinotify.a
.else
LDFLAGS+=	-linotify
.endif

.include <bsd.prog.mk>
