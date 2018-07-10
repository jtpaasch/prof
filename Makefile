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
	$(compiler) -I $(build_dir) -c $(build_dir)/files.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/files.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/ps.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/ps.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/execution.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/execution.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/execution_printer.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/execution_printer.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/trials.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/trials.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/trials_printer.mli
	$(compiler) -I $(build_dir) -c $(build_dir)/trials_printer.ml
	$(compiler) -I $(build_dir) -c $(build_dir)/main.ml
	$(compiler) -I $(build_dir) -o bin/$(exe_name) \
		unix.$(libextension) \
		cli.$(objextension) \
		tty_str.$(objextension) \
		logs.$(objextension) \
		files.$(objextension) \
		ps.$(objextension) \
		execution.$(objextension) \
		execution_printer.$(objextension) \
		trials.$(objextension) \
		trials_printer.$(objextension) \
		main.$(objextension)
