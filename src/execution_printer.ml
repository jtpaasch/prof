(** Implements {!Execution_printer}. *)

let pprint_output title data = 
  let output =
    match List.length data with
    | 0 -> ["- None captured"]
    | _ -> List.map (Printf.sprintf "- %s") data in
  List.append [title] output

let pprint exe =
  let cmd = Execution.cmd exe in
  let stdout = Execution.stdout exe in
  let stderr = Execution.stderr exe in
  let exit_code = Execution.exit_code exe in
  let duration = Execution.duration exe in

  let header_str = "--- Trial" in
  let cmd_str = Printf.sprintf "Command: %s" cmd in
  let exit_code_str = Printf.sprintf "Exit code: %d" exit_code in
  let duration_str = Printf.sprintf "Running time: %.3fs" duration in
  
  let header = [header_str; cmd_str; exit_code_str; duration_str] in
  let stdout_strs = pprint_output "Stdout:" stdout in
  let stderr_strs = pprint_output "Stderr:" stderr in

  List.flatten [header; stdout_strs; stderr_strs; [""]]
