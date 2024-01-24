type 'a tape = Tape of { left : 'a list; head : 'a; right : 'a list }

type 'a command = Left | Do of ('a -> 'a) | Right

let example = Tape { left = [ 3; 2; 1 ]; head = 4; right = [ 5; 6 ] }

(* 2. a) *)

let map tape f = match tape with
  | Tape x -> Tape { left = List.map f x.left; head = f x.head; right = List.map f x.right }


(* 2. b) *)

let izvedi (trak: 'a tape) (comm: 'a command) = 
  match trak with
  | Tape trak ->
  match comm with
  | Left when trak.left = [] -> None
  | Right when trak.right = [] -> None
  | Left -> let hd :: tl = trak.left in Some (Tape { left = tl; head = hd; right = trak.head :: trak.right })
  | Right -> let hd :: tl = trak.right in Some (Tape { left = trak.head:: trak.left ; head = hd; right = tl })
  | Do f -> Some (Tape { left = trak.left ; head = f trak.head; right = trak.right })
(* 2. c) *)

let rec izvedi_ukaze trak = function
  | [] -> trak
  | comm :: commi -> let x = izvedi trak comm in 
    match x with
    | None -> trak 
    | Some x -> izvedi_ukaze x commi 



(* 2. d) *)

let naberi_in_pretvori trakec pravila= 
  let rec naberi_in_pretvori' trak acc commands = 
match commands with
  |[] -> (acc, trak)
  |x :: xs -> match (izvedi trak x) with
    | None -> (acc, trak)
    | Some trakq ->
    match x with 
    | Do f -> 
      (match trak with
      | Tape tape -> naberi_in_pretvori' (trakq) (acc @ [tape.head, f tape.head]) xs)
    | _ -> naberi_in_pretvori' (trakq) acc xs
      in
  naberi_in_pretvori' trakec [] pravila
(* 2. e) *)

let pripravi_ukaze trak f = 
  let rec premakni_na_zacetek acc trak1 =
    match trak1 with
      | Tape x -> (match x.left with
        | [] -> acc
        | _ -> premakni_na_zacetek (Left :: acc) (izvedi_ukaze trak1 [Left])) in
  let rec konec acc3 trak3 =
    match trak3 with
    | Tape x -> (match x.right with
    | [] -> acc3
    | _ -> konec (Left :: acc3) (izvedi_ukaze trak3 [Right])) in
  let akumulator = (premakni_na_zacetek [] trak) in
  let novi = izvedi_ukaze trak (premakni_na_zacetek [] trak) in
  match novi with Tape x -> let n = List.length x.right in
  let akumulator = akumulator @ [Do f] in
  let rec dokoncaj acc n = match n with
   | 0 -> acc
   | _ -> dokoncaj (acc @ [Right; Do f]) (n-1) in
  (dokoncaj akumulator n) @ (konec [] trak)



  