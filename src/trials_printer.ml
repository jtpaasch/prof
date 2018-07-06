(** Implements {!Trials_printer}. *)

let pad s =
  let total_width = 48 in
  let len_s = String.length s in
  let len_pad = (total_width - len_s) - 5 in
  let padding = String.make len_pad '-' in
  String.concat "" ["--- "; s; " "; padding]

let pprint trials =
  let num_trials = Trials.num_trials trials in
  let avg_time = Trials.avg_time trials in
  let total_time = Trials.total_time trials in
  let executions = Trials.executions trials in

  let header_str = pad "Trials" in
  let num_trials_str = Printf.sprintf "Number of trials: %d" num_trials in
  let avg_time_str = Printf.sprintf "Avg running time: %.3fs" avg_time in
  let total_time_str = Printf.sprintf "Total time: %.3fs" total_time in

  let header =
    [""; header_str; ""; num_trials_str; avg_time_str; total_time_str; ""]
    in

  let execs_strs = List.map Execution_printer.pprint executions in
  let output = List.flatten execs_strs in

  List.append header output
