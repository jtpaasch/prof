(** Manages/defines the CLI for the program.

    To use it, first parse the command line arguments:
    
    {[
      Cli.cli ()
    ]}

    Then retrieve values of parsed arguments, e.g.:

    {[
      let num_trials = Cli.num_trials () in
      Printf.printf "Num trials: %d\n%!" num_trials
    ]}

*)

(** [verbose_log ()] returns the value of the [--verbose-log] parameter. *)
val verbose_log : unit -> string

(** [main_log ()] returns the value of the [--main-log] parameter. *)
val main_log : unit -> string

(** [error_log ()] returns the value of the [--error-log] parameter. *)
val error_log : unit -> string

(** [num_trials ()] returns the value of the [--num-trials] parameter. *)
val num_trials : unit -> int

(** [shell_cmd ()] returns the value of the [SHELL_CMD] argument. *)
val shell_cmd : unit -> string

(** [cli ()] parses the command line arguments. *)
val cli : unit -> unit