.POSIX:

all: bin bin/release

check: all
	@tests/run

bin:
	@mkdir $@

bin/release: src/release.sh
	@cp $< $@
	@chmod u+x $@
