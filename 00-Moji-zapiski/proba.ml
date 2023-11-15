let languages = "OCaml,Perl,C++,C";;

let dashed_languages =
  let language_list = String.split languages ~on:',' in
  String.concat ~sep:"-" language_list;;


