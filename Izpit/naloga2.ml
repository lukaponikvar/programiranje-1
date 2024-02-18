type 'a dict = (string * 'a) list

type primitive = Bool of bool | Int of int | String of string | Null

type json = Primitive of primitive | Object of json dict | Array of json list
(*  Primitive (Int 1); Primitive (Int 2); Primitive (Int 3)  *)
let json_example2 =
  Object
    [
      ("name", Primitive (String "Matija"));
      ("age", Primitive (Int 20));
      ("friends", Array [Primitive (Int 1); Primitive (Int 2); Primitive (Int 3)]);
      ("is_student", Primitive (Bool true));
      ("is_professor", Primitive (Bool false));
      ("is_ta", Primitive Null);]
let json_example =
  Object
    [
      ("name", Primitive (String "Matija"));
      ("age", Primitive (Int 20));
      ("friends", Array [ Primitive (Int 1); Primitive (Int 2); Primitive (String "Nemo") ]);
      ("is_student", Primitive (Bool true));
      ("is_professor", Primitive (Bool false));
      ("is_ta", Primitive Null);
    ]
let primer = json_example
let primer2 = json_example2

(* 2. a) *)
let rec prestej_stevila = function
  | Primitive (Int x) -> 1
  | Primitive y -> 0
  | Object list -> (List.fold_left ( + ) 0 (List.map prestej_stevila (List.map snd list)))
  | Array list -> (List.fold_left ( + ) 0 (List.map prestej_stevila list))

(* 2. b) *)
let rec izloci_nize globina json = match (globina, json) with
  | (0, Primitive (String x)) -> [x]
  | (_, Primitive y) -> [""]
  | (0, Object list)-> List.filter (( <> ) "") (List.flatten (List.map (izloci_nize 0) (List.map snd list)))
  | (0, Array list) -> List.filter (( <> ) "") (List.flatten (List.map (izloci_nize 0) list))
  | (x, Object list)-> List.filter (( <> ) "") (List.flatten (List.map (izloci_nize (x-1)) (List.map snd list)))
  | (x, Array list) -> List.filter (( <> ) "") (List.flatten (List.map (izloci_nize (x-1)) list))

(* 2. c) *)
let rec dodaj_predpono stringg = function
  | Object list ->
    (
      let (sez1, sez2) = List.split list in
      let sez11 = List.map  (( ^ ) stringg) sez1 in
      Object (List.combine sez11 sez2)
    )
  | Primitive y -> Primitive y
  | Array list -> Array (List.map (dodaj_predpono stringg) list)
(* 2. d) *)


let rec izpisi = function
  | Primitive (Int y) -> print_string ("Primitive (Int " ^ (string_of_int y) ^ ")")
  | Primitive (String y) -> print_string ("Primitive (String \"" ^ y ^ "\")")
  | Primitive (Bool y) -> print_string ("Primitive (Int " ^ (string_of_bool y) ^ ")")
  | Primitive (Null) -> print_string ("Primitive Null")
  | Array list -> 
    (
      print_string ("Array [\n");
      List.map izpisi list;
      print_string ("\n]\n")
    )
  | Object list -> let izpisi2 = function 
        | (x, y) -> print_string ("(\"" ^ x ^ "\", "); (izpisi y); print_string (");\n")
      in
    (
      print_string ("Object\n[\n");
      List.map izpisi2 list;
      print_string ("\n]\n")
    )

(* 2. e *)
let rec je_konsistenten = function
  | Primitive x -> true
  | Object list -> List.fold_left ( && ) true (List.map je_konsistenten (List.map snd list))
  | Array list -> 
    let pomozna tip = function
    | Primitive (Int x) -> (tip = "int")
    | Primitive (String x) -> (tip = "string")
    | Primitive (Bool x) -> (tip = "bool")
    | Primitive Null -> (tip = "null")
    | _ -> false in
    ((List.for_all (pomozna "int") list) || (List.for_all (pomozna "string") list) || 
    (List.for_all (pomozna "bool") list) || (List.for_all (pomozna "null") list))




(* ChatGPT predlaga sledečo rešitev: *)
  let rec same_type_elements lst =
    match lst with
    | [] -> true
    | [x] -> true
    | hd :: tl -> List.for_all (fun el -> (type_of_primitive hd) = (type_of_primitive el)) tl
  
  (* Helper function to get the type of a primitive value *)
  and type_of_primitive = function
    | Bool _ -> "bool"
    | Int _ -> "int"
    | String _ -> "string"
    | Null -> "null"
  
  (* Main function to check consistency of an object *)
  let rec je_konsistenten_gpr objekt =
    match objekt with
    | Primitive _ -> true (* Primitives are always consistent *)
    | Object dict -> List.for_all (fun (_, v) -> je_konsistenten v) dict
    | Array lst -> same_type_elements lst

(* Rešitev ni dobra, saj se v Array list ( v tem seznamu desno tipa json list) lahko pojavijo tudi reči, ki niso, tipa Primitive, ker funkcija
   type_of_primitive ni definirana drugje kot na tipu primitive _, na primer tip Object, ki se tehnično tam lahko nahaja, sproži izjemo, 
   to pa ni dobro :) Tipi so pomembni!!! *)