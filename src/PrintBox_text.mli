
(* This file is free software. See file "license" for more details. *)

(** {1 Render to Text}

    This module should be used to output boxes directly to a terminal, or
    another  area of monospace text *)

val set_string_len : (String.t -> int -> int -> int) -> unit
(** Set which function is used to compute string length. Typically
    to be used with a unicode-sensitive length function
    An example of such function for utf8 encoded strings is the following
    (it uses the [Uutf] and [Uucp] libraries):
    {[
      let string_leng s i len =
        Uutf.String.fold_utf_8 ~pos:i ~len
          (fun n _ c -> n+ max 0 (Uucp.Break.tty_width_hint c)) 0 s
    ]}
    Note that this function assumes there is no newline character in the given string.
*)

val to_string : PrintBox.t -> string
(** Returns a string representation of the given structure. *)

val output : ?indent:int -> out_channel -> PrintBox.t -> unit
(** Outputs the given structure on the channel. *)

val pp : Format.formatter -> PrintBox.t -> unit
(** Pretty-print the box into this formatter.
    @since 0.2 *)
