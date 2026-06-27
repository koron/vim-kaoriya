CURDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

ROOT_DIR = $(abspath $(CURDIR)../..)
VIM_DIR = $(ROOT_DIR)/vim

patch-apply:
	cd $(ROOT_DIR)/vim && guilt push -a

patch-revert:
	cd $(ROOT_DIR)/vim && guilt pop -a

build:
	./bin/make-vim

test:
	./bin/test-vim
	# Stop conhost.exe, which is likely running out of control.
	taskkill -F -FI "IMAGENAME eq conhost.exe" -FI "MEMUSAGE gt 200000"

test-clean:
	./bin/test-vim clean

clean:
	./bin/make-vim clean

zip:
	./bin/build-zip

package-auto:
	$(MAKE) clean test-clean patch-apply build test patch-revert zip

install-daily:
	./bin/install-vim /d/Vim/daily

install:
	./bin/install-vim /d/Vim

upload:
	./bin/upload-files

release: package-auto install-daily install upload
