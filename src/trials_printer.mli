(** Utility for pretty printing trials. *)
  
(** Generate a string list from a {!Trials.t} record.

    Arguments:
    - A {!Trials.t} record.

    Returns: a string list.

    For example, suppose [trials] is a {!Trials.t} instance.
    Then [pprint trials] will return a list of strings that can
    be printed to, say, a TTY or other target. *)
val pprint : Trials.t -> string list
