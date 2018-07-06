# A profiler

Requirements:

* OCaml 4.05+

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

To change the number of trials, use the `--num-trials` parameter (before the two dashes). For example, to run the command through 10 trials:

    $ [REPO_ROOT]/bin/prof --num-trials 10 -- echo "hello world"

To see verbose output, use the `--verbose-log` parameter (before the two dashes). For example, to send the verbose log to stdout:

    $ [REPO_ROOT]/bin/prof --verbose-log stdout -- echo "hello world"

Or send the verbose log to a file:

    $ [REPO_ROOT]/bin/prof --verbose-log /tmp/out.log -- echo "hello world"
