
srcdir = src
sitedir = site
staticdir = static

metas = $(wildcard $(addprefix $(srcdir)/*.,meta))
objs = $(addprefix $(sitedir)/,$(notdir $(basename $(metas))))



all: $(objs)


prebuild:
	cp -rf site old_site
	mkdir site


$(sitedir)/% :: static/header.html $(srcdir)/%.html static/footer.html
	cat $^ > $@

.PHONY: all debug

# file name of post source: some_slug.format
# some_slug should be SEO and unique
# formats supported currently: html,bml
# example: makefile-generated-blog.bml
#
# file name for post metadata: some_slug.meta
# example contents:
# published=2017-08-22
# title=Using Makefile to Generate a Blog
# tags=blog tech programming
#


# command ideas:
# - make (builds blog)
# - make list posts (list of posts with greppable status among other things)
# - make list tags (list of tags)
# possibly more to add tags etc to posts!!
