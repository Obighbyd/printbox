= PrintBox
:toc: macro
:toclevels: 4
:source-highlighter: pygments

Allows to print nested boxes, lists, arrays, tables in several formats,
including:

- text (assuming monospace font)
- HTML (using https://github.com/ocsigen/tyxml/[tyxml] )
- LaTeX (*not implemented yet*)

image::https://api.travis-ci.org/c-cube/printbox.svg?branch=master[alt="build status", link="https://travis-ci.org/c-cube/printbox"]

A few examples:

importing the module::
+
[source,OCaml]
----
#require "printbox";;

module B = PrintBox;;
----
+
simple box::
+
[source,OCaml]
----
let box = B.(hlist [ text "hello"; text "world"; ]);;

PrintBox_text.output stdout box;;
----
+
====
  hello|world : unit = ()
====
+
less simple boxes::
+
[source,OCaml]
----
let box =
  B.(hlist
  [ text "I love\nto\npress\nenter";
    grid_text [| [|"a"; "bbb"|];
    [|"c"; "hello world"|] |]
  ])
  |> B.frame;;

PrintBox_text.output stdout box;;
----
+
which displays:
+
====
  +--------------------+
  |I love|a|bbb        |
  |to    |-+-----------|
  |press |c|hello world|
  |enter | |           |
  +--------------------+- : unit = ()
====
+
printing a table::
+
[source,OCaml]
----

(* function to make a square *)
let square n =
  Array.init n
    (fun i -> Array.init n (fun j -> B.sprintf "(%d,%d)" i j))
  |> B.grid ;;

let sq = square 5;;

PrintBox_text.output stdout sq;;
----
+
You should obtain something like:
+
====
  (0,0)|(0,1)|(0,2)|(0,3)|(0,4)
  -----------------------------
  (1,0)|(1,1)|(1,2)|(1,3)|(1,4)
  -----------------------------
  (2,0)|(2,1)|(2,2)|(2,3)|(2,4)
  -----------------------------
  (3,0)|(3,1)|(3,2)|(3,3)|(3,4)
  -----------------------------
  (4,0)|(4,1)|(4,2)|(4,3)|(4,4)- : unit = ()
====
+
frame::
+
Why not put a frame around this? That's easy.
+
[source,OCaml]
----
let sq2 = square 3 |> B.frame ;;

PrintBox_text.output stdout sq2;;
----
+
obtaining:
+
====
  +-----------------+
  |(0,0)|(0,1)|(0,2)|
  |-----------------|
  |(1,0)|(1,1)|(1,2)|
  |-----------------|
  |(2,0)|(2,1)|(2,2)|
  +-----------------+- : unit = ()
====
+
tree::
We can also create trees and display them using indentation:
+
[source,OCaml]
----
let tree =
  B.tree (B.text "root")
    [ B.tree (B.text "a") [B.text "a1\na1"; B.text "a2\na2\na2"];
      B.tree (B.text "b") [B.text "b1\nb1"; B.text "b2"; B.text "b3"];
    ];;

PrintBox_text.output stdout tree;;
----
+
====
    root
    `+- a
     |  `+- a1
     |   |  a1
     |   +- a2
     |      a2
     |      a2
     +- b
        `+- b1
         |  b1
         +- b2
         +- b3
====
+
HTML output (with `tyxml`)::
+
[source,OCaml]
----
#require "printbox.html";;

let out = open_out "/tmp/foo.html";;

(* this prints the table, along with a small header
 to make it nicer on the eyes *)
output_string out (PrintBox_html.to_string_doc (square 5));;
----
+
which prints some HTML in the file link:docs/foo.html[foo.html].
Note that trees are printed in HTML using nested lists, and
that `PrintBox_html.to_string_doc` will insert some javascript to
make sub-lists fold/unfold on click (this is useful to display very large
trees compactly and exploring them incrementally).


== Documentation

See https://c-cube.github.io/printbox/

== Build

Ideally, use http://opam.ocaml.org/[opam] :

----
opam install printbox
----

Manually:

----
make install
----