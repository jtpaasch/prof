(** Utility for pretty printing executions. *)
  
(** Generate a string list from an {!Execution.t} record.
    
    Arguments:
    - An {!Execution.t} record.
    
    Returns: a string list.
    
    For example, suppose [execution] is an {!Execution.t} instance.
    Then [pprint execution] will return a list of strings that can
    be printed to, say, a TTY or other target. *)
val pprint : Execution.t -> string list
