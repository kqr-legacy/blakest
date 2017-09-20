
# Where to store intermediary files converted from post sources
BUILDDIR = build

# Where the site is built
ROOTDIR = out

# Where will the site be installed when you run `make install'? If you
# don't like the default, you can either change here or run make with
# `make -DPREFIX=/home/johndoe/www install'
PREFIX = /usr/local/www

# Location of static content on the final built site
STATIC = $(ROOTDIR)/static

# Location of post sources and metadata
SRCDIR = src
# Location of site templates
TEMPLATEDIR = templates
# Location of static data
STATICDIR = static

include base.mk
include formats/*.mk




