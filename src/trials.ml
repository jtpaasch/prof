(** Implements {!Trials}. *)

type t = {
  executions: Execution.t list;
  avg_time: float;
  total_time: float;
  num_trials: int;
}

let executions t = t.executions
let avg_time t = t.avg_time
let total_time t = t.total_time
let num_trials t = t.num_trials

let last t =
  let execs = executions t in
  let num_execs = List.length execs in
  List.nth execs (num_execs - 1)

let nth t i =
  let execs = executions t in
  List.nth execs i

let rec sumf items acc =
  match items with
  | [] -> acc
  | hd :: tl -> sumf tl (acc +. hd)

let durations execs = List.map (fun x -> Execution.duration x) execs

let calc_total execs =
  let times = durations execs in
  sumf times 0.0

let calc_avg execs total_time =
  let num_trials = List.length execs in
  total_time /. (float_of_int num_trials)

let rec do_executions cmd counter acc =
  match counter > 0 with
  | true ->
    begin
      let res = Execution.run cmd in
      let new_counter = counter - 1 in
      let new_acc = List.append acc [res] in
      do_executions cmd new_counter new_acc
    end
  | false -> acc

(** Run/create a {!Trials.t} record.

    Arguments:
    - A command (a string) to execute in a shell.
    - The number of times (int) to run the command.

    Returns: a {!Trials.t} record. *)
let run cmd num_trials =
  let executions = do_executions cmd num_trials [] in
  let total_time = calc_total executions in
  let avg_time = calc_avg executions total_time in
  { executions; avg_time; total_time; num_trials }