# A profiler

Requirements:

* OCaml 4.05+

If you don't have OCaml on your system, use a docker container:

    $ docker run --rm -ti -v $(pwd):/srv -w /srv ocaml/opam:ubuntu-16.04_ocaml-4.06.0 bash

Build:

    $ git clone [REPO_URL]
    $ cd [REPO_ROOT]
    $ make

That produces an executable in the `bin` folder:

    $ [REPO_ROOT]/bin/prof --help

To use it, invoke the executable, followed by two dashes, then the command you want to profile. For example:

    $ [REPO_ROOT]/bin/prof -- echo "hello world"

That will print out something like this:

    Profiling [[ echo "hello world" ]] ...
    Completed trials.

    Results:
    Avg time: 0.250s
    Total time: 1.252s
    Number of trials: 5
    Avg num stat collections per trial: 1
    Avg RSS across all trials: 524Kb
    Avg min RSS across all trials: 524Kb
    Avg max RSS across all trials: 524Kb
    Min RSS of all trials: 484Kb
    Max RSS of all trials: 568Kb

To change the number of trials, use the `--num-trials` parameter (before the two dashes). For example, to run the command through 10 trials:

    $ [REPO_ROOT]/bin/prof --num-trials 10 -- echo "hello world"

To see verbose output, use the `--verbose-log` parameter (before the two dashes). For example, to send the verbose log to stdout:

    $ [REPO_ROOT]/bin/prof --verbose-log stdout -- echo "hello world"

Or send the verbose log to a file:

    $ [REPO_ROOT]/bin/prof --verbose-log /tmp/out.log -- echo "hello world"
