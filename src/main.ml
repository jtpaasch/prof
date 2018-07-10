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
  let num_trials = Cli.num_trials () in

  let msg =
    Printf.sprintf "-- Starting profiler %s\n" (String.make 27 '-') in
  let ttystr = Tty_str.create msg in
  Logs.log "verbose" [ttystr];

  let msg = Printf.sprintf "Profiling [[ %s ]] ..." cmd in
  let msg_ttystr = Tty_str.create msg ~fmt:Tty_str.Bold in
  Logs.log "main" [msg_ttystr];

  let trials = Trials.run cmd num_trials in

  let trials_strs = Trials_printer.pprint trials in
  let trials_ttystrs = List.map Tty_str.create trials_strs in
  Logs.log "verbose" trials_ttystrs;

  let avg_time = Trials.avg_time trials in
  let total_time = Trials.total_time trials in
  let num_stats = Trials.avg_num_stat_collections trials in
  let avg_rss = Trials.avg_rss trials in
  let avg_min_rss = Trials.avg_min_rss trials in
  let avg_max_rss = Trials.avg_max_rss trials in
  let min_rss = Trials.min_rss trials in
  let max_rss = Trials.max_rss trials in

  let msg =
    Printf.sprintf "-- Reporting results %s\n" (String.make 27 '-') in
  let ttystr = Tty_str.create msg in
  Logs.log "verbose" [ttystr];

  let msgs = ["Completed trials."; ""] in
  let ttystrs = List.map Tty_str.create msgs in
  Logs.log "main" ttystrs;

  let ttystr = Tty_str.create "Results:" ~fmt:Tty_str.Bold in
  Logs.log "main" [ttystr];

  let msgs = [
    Printf.sprintf "Avg time: %.3fs" avg_time;
    Printf.sprintf "Total time: %.3fs" total_time;
    Printf.sprintf "Number of trials: %d" num_trials;
    Printf.sprintf "Avg num stat collections per trial: %d" num_stats;
    Printf.sprintf "Avg RSS across all trials: %dKb" avg_rss;
    Printf.sprintf "Avg min RSS across all trials: %dKb" avg_min_rss;
    Printf.sprintf "Avg max RSS across all trials: %dKb" avg_max_rss;
    Printf.sprintf "Min RSS of all trials: %dKb" min_rss;
    Printf.sprintf "Max RSS of all trials: %dKb" max_rss;
    ] in
  let ttystrs = List.map Tty_str.create msgs in
  Logs.log "main" ttystrs

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
