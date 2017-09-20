
METAS = $(wildcard $(SRCDIR)/*.meta)
POSTS = $(notdir $(basename $(METAS)))


PAGES = $(addprefix $(ROOTDIR)/,$(POSTS) index)


all: info $(addsuffix .html, $(PAGES)) $(STATIC)
	@echo "=================="
	@echo "[ALL] Build finished."


info:
	@echo "[INFO] Directory for post sources: $(SRCDIR)"
	@echo "[INFO] Directory for templates: $(TEMPLATEDIR)"
	@echo "[INFO] Directory for static content: $(STATICDIR)"
	@echo "[INFO] Root directory for build: $(ROOTDIR)"
	@echo "[INFO] Looking for meta files $(addprefix $(SRCDIR)/*.,$(META))"
	@echo "=================="
	@echo "[INFO] Meta files found: $(METAS)"
	@echo "[INFO] Corresponding to pages: $(notdir $(PAGES))"
	@echo "=================="


install: $(PREFIX)
	@echo "[INSTALL] Copying $(ROOTDIR) into $(PREFIX)"
	@cp -r $(ROOTDIR)/* $(PREFIX)/


M4_METAS = $(addsuffix .m4,$(addprefix $(BUILDDIR)/,$(POSTS)))
M4_COMMASEP = $(shell echo $(M4_METAS) | tr ' ' ',')

$(ROOTDIR)/index.html: $(TEMPLATEDIR)/index.m4 $(ROOTDIR)
	@echo "[BUILD] Generating $@"
	m4 utils.m4 -DLATEST=$(M4_COMMASEP) $< > $@


META_PARSE_RE = ^\([_[:alnum:]]*\)[[:space:]]*=[[:space:]]*\(.*\)$

$(BUILDDIR)/%.m4: $(SRCDIR)/%.meta $(BUILDDIR)
	@echo "[META] $<"
	@sed "s/$(META_PARSE_RE)/pushdef(\1,\2)/" $< >> $@
	@echo "pushdef(SLUG,$(basename $(@F)))" >> $@
	@echo "pushdef(URL,$(basename $(@F)).html)" >> $@


$(ROOTDIR)/%.html: $(ROOTDIR) $(BUILDDIR)/%.html $(BUILDDIR)/%.m4 $(TEMPLATEDIR)/base.html
	@echo "[BUILD] Building blog page $@"
	@m4 $(word 3,$^) -DCONTENT=$(word 2,$^) $(word 4,$^) > $@


clean: clean$(BUILDDIR) clean$(ROOTDIR)

clean%:
	@echo "[CLEAN] Removing directory $*"
	@rm -rf $*


$(BUILDDIR) $(ROOTDIR) $(POSTS) $(PREFIX):
	@mkdir -p $@


$(STATIC): $(STATICDIR) $(ROOTDIR)
	@echo "[STATIC] Copying $< to $@"
	@cp -r $< $@


.PHONY: all info install prebuild clean
.PRECIOUS: $(BUILDDIR)/%.html $(BUILDDIR)/%.m4
