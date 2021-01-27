#
# mruby/c  Makefile
#
# Copyright (C) 2015-2018 Kyushu Institute of Technology.
# Copyright (C) 2015-2018 Shimane IT Open-Innovation Center.
#
#  This file is distributed under BSD 3-Clause License.
#

# MRUBY_TAG corresponds to tag or branch of mruby/mruby
MRUBY_TAG = $(shell grep MRUBY_VERSION mrblib/global.rb | sed 's/MRUBY_VERSION *= *"\(.\+\)"/\1/')
USER_ID = $(shell id -u)

all: mrubyc_lib mrubyc_bin

mrubyc_lib:
	cd mrblib ; $(MAKE) all
	cd src ; $(MAKE) all

mrubyc_bin:
	cd sample_c ; $(MAKE) all

clean:
	cd mrblib ; $(MAKE) clean
	cd src ; $(MAKE) clean
	cd sample_c ; $(MAKE) clean

package: clean
	@LANG=C ;\
	TARGET="mruby-c_`head -n1 Version`" ;\
	if [ -n "$$MRUBYC_VERSION" ] ;\
		then TARGET="mruby-c_$$MRUBYC_VERSION" ;\
	fi ;\
	echo Making \"$$TARGET.tgz\" ;\
	mkdir -p pkg/$$TARGET ;\
	cp -Rp src doc sample_c sample_ruby auto_test README.md Makefile pkg/$$TARGET ;\
	cd pkg ;\
	tar cfz ../$$TARGET.tgz $$TARGET ;\
	cd .. ;\
	rm -Rf pkg ;\
	echo Done.

.PHONY: test setup_test check_tag

test: check_tag
	docker run --mount type=bind,src=${PWD}/,dst=/work/mrubyc \
	  -e CFLAGS="-DMRBC_USE_MATH=1 -DMAX_SYMBOLS_COUNT=500 $(CFLAGS)" \
	  mrubyc-dev bundle exec mrubyc-test \
	  --every=10 \
	  --mrbc-path=/work/mruby/build/host/bin/mrbc \
	  $(file)

check_tag:
	$(eval CURRENT_MRUBY_TAG = $(shell docker run mrubyc-dev \
	  /bin/sh -c 'cd /work/mruby && git status | ruby -e"puts STDIN.first.split(\" \")[-1]"'))
	@echo MRUBY_TAG=$(MRUBY_TAG)
	@echo CURRENT_MRUBY_TAG=$(CURRENT_MRUBY_TAG)
	if test "$(CURRENT_MRUBY_TAG)" = "$(MRUBY_TAG)"; \
	then \
	  echo 'Skip setup_test'; \
	else \
	  make setup_test; \
	fi

setup_test:
	docker build -t mrubyc-dev --build-arg MRUBY_TAG=$(MRUBY_TAG) --build-arg USER_ID=$(USER_ID) .
