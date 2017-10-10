SRCDIR=		src
TEMPLATEDIR=	templates
PREFIX=		site


METASRC!=	find ${SRCDIR} -name "*.meta" -exec basename {} \;
POSTS=		${METASRC:.meta=.contents}
PAGES=		index.page tags.page ${POSTS:.contents=.page}


# Source suffixes:
# .meta: contains metadata like title and tags
# .html: post source expressed as html
# .m4: template for rendering final product
#
# Intermediary suffixes:
# .post: post after plain conversion to output format, then templated to
# .contents: data in output format inserted into main base template
#
# Output suffixes:
# .page: final page after applying base template

.SUFFIXES: .meta .html .m4 .record .post .contents .page
VPATH=		${SRCDIR}

TAGSFROM=	
BYCOUNT=	

PARSEMETA=	
all: metaindex ${PAGES}

install: all


allposts: metaindex
	@cat metaindex

alltags: metaindex
	@awk -F\t '{ print $$4; }' metaindex | tr ' ' '\n' | sort -u | sed 's/^/@tag	/'

search: metaindex
	@awk -F\t '$$4'"~ /$$tagged/ { print; }" metaindex


metaindex: ${METASRC:.meta=.record}
	cat *.record > metaindex


.contents.page:
	m4 -DCONTENTS=$<\
	${TEMPLATEDIR}/base.m4 > $@


# Index contents generated directly
index.contents: metaindex
	awk -f templating.awk ${TEMPLATEDIR}/index.m4\
	| m4 > $@


# Tags portal also generated directly
tags.contents: metaindex
	awk -f templating.awk ${TEMPLATEDIR}/tags.m4\
	| m4 > $@


# Post contents generated from earlier sources
.post.contents:
	awk -F\t -f templating.awk ${<:.post=.record} | m4 > $@


.meta.record:
	awk -F '=\t+' -v 'OFS=\t'\
	-v "slug=$$(basename ${<:.meta=})"\
	-v "template=${TEMPLATEDIR}/detail.m4" '\
		$$1 == "TITLE" { title = $$2; }\
		$$1 == "TAGS" { tags = $$2; }\
		$$1 == "PUBLISHED" { published = $$2; }\
		END { print\
			"@post",\
			published,\
			title,\
			tags,\
			slug,\
			slug ".post",\
			template;\
		}\
	' $< > $@


.html.post:
	cat $< > $@


clean:
	rm -rf *.record *.post *.contents


cleanall: clean
	rm -rf metaindex *.page


.PHONY: clean allposts alltags search all
