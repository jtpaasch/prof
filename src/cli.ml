(** Implements {!Cli}. *)

let program_name = "prof"

let verbose_log_target = ref "/dev/null"
let main_log_target = ref "stdout"
let error_log_target = ref "stderr"
let number_of_trials = ref 5
let full_shell_command = ref ""

let verbose_log () = !verbose_log_target
let main_log () = !main_log_target
let error_log () = !error_log_target
let num_trials () = !number_of_trials
let shell_cmd () = !full_shell_command

let append_to_cmd cmd =
  let updated_cmd = Printf.sprintf "%s %s" !full_shell_command cmd in
  full_shell_command := String.trim updated_cmd

let help_hint = Printf.sprintf "See %s --help." program_name

let usage_str =
  Printf.sprintf "%s [OPTIONS] -- SHELL_CMD" program_name

let descr_str = "Profile a SHELL_CMD."

let usage =
  Printf.sprintf "USAGE: %s\n\n  %s\n\nOPTIONS:" usage_str descr_str

let spec = [

  ("--verbose-log",
   Arg.Set_string verbose_log_target,
   "Where to send the verbose log. Default: /dev/null");

  ("--main-log",
   Arg.Set_string main_log_target,
   "Where to send the main log. Default: stdout");

  ("--error-log",
   Arg.Set_string error_log_target,
   "Where to send the error log. Default: stderr");

  ("--num-trials",
   Arg.Set_int number_of_trials,
   "Num times to run profiled commands. Default: 5");

  ("--",
   Arg.Rest append_to_cmd,
   "Everything after '--' is the SHELL_CMD to profile.");

  ]

let handle_args arg =
  Printf.printf "Error. Unrecognized argument: '%s'. %s\n%!"
  arg help_hint;
  exit 1

let check () =
  match shell_cmd () with
  | "" ->
    Printf.printf "Error. Please provide a SHELL_CMD. %s\n%!" help_hint;
    exit 1
  | _ -> ()

let cli () =
  Arg.parse spec handle_args usage;
  check ()
