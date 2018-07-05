exe_name = prof
compiler = ocamlopt
libextension = cmxa
objextension = cmx
build_dir = build

all: clean $(build_dir)

clean:
	rm -rf $(docs_dir)
	rm -rf $(build_dir)
	rm -rf bin

$(build_dir):
	mkdir -p bin
	rm -rf $(build_dir)
	cp -R src $(build_dir)
	$(compiler) -I $(build_dir) -c $(build_dir)/cli.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/cli.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/tty_str.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/tty_str.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/logs.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/logs.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/main.ml
	$(compiler) -I $(build_dir) -o bin/$(exe_name) unix.$(libextension) cli.$(objextension) tty_str.$(objextension) logs.$(objextension) main.$(objextension)
