include VERSION

DISTDIR=dist
CORE=vim-$(VERSION_VIM)+kaoriya-$(VERSION_KAORIYA)
CORE_TARGET=$(DISTDIR)/$(CORE).tar.bz2
PATCH=vim-kaoriya-patches-$(VERSION_KAORIYA)
PATCH_TARGET=$(DISTDIR)/$(PATCH).tar.bz2
PATCH_TMPDIR=$(PATCH_TARGET:.tar.bz2=)

archive: $(CORE_TARGET) $(PATCH_TARGET)

$(CORE_TARGET):
	@if [ ! -d $(DISTDIR) ] ; then mkdir -p $(DISTDIR) ; fi
	hg archive -p "$(CORE)" -S $@ -X '.hg*'

$(PATCH_TARGET):
	@if [ ! -d $(DISTDIR) ] ; then mkdir -p $(DISTDIR) ; fi
	sh build/dist/collect_applied_patches.sh vim $(PATCH_TMPDIR)
	tar cjf $@ -C $(DISTDIR) $(PATCH)
	rm -rf $(PATCH_TMPDIR)
