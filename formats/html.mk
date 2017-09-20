
# Simplest possible format extension. Tells make how to convert HTML blog
# post sources to HTML blog posts – by simply copying them verbatim!
$(BUILDDIR)/%.html: $(SRCDIR)/%.html $(BUILDDIR)
	@echo "[HTML] $<"
	@cat $< > $@

