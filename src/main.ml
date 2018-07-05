(** The main program CLI/interface. *)

(** The main entrypoint to the program. *)
let main () =

  (* Make sure to quit through [exit], so all exit handlers are called. *)
  Sys.(set_signal sighup (Signal_handle exit));
  Sys.(set_signal sigint (Signal_handle exit));

  (* Parse the command line arguments. *)
  Cli.cli ();

  (* Set up some log channels. *)
  Logs.create "verbose" (Cli.verbose_log ());
  Logs.create "main" (Cli.main_log ());
  Logs.create "error" (Cli.error_log ());
  at_exit Logs.close_all;

  let cmd = Cli.shell_cmd () in

  let msg = Printf.sprintf "---------------- Starting profiler\n" in
  let msg_ttystr = Tty_str.create ~fmt:Tty_str.Bold msg in
  Logs.log "verbose" [msg_ttystr];

  let msg = Printf.sprintf "Shell command: [[ %s ]]" cmd in
  let msg_ttystr = Tty_str.create msg in
  Logs.log "verbose" [msg_ttystr]



(** Handle custom errors, and any unix errors. *)
let handle_errors f () =
  Printexc.register_printer
    (function
      | _ -> None
    );
  try
    Unix.handle_unix_error f ()
  with e ->
    let msg = Printexc.to_string e in
    Printf.printf "Error. %s\n%!" msg;
    exit 1

let () = handle_errors main ()
