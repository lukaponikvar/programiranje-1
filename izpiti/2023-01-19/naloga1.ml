(* 1. a) *)
let permutacije a b c = [(a,b,c);(a,c,b);(b,c,a);(b,a,c);(c,a,b);(c,b,a)]
(* 1. b) *)
let zip_opt sez1 sez2 = 
  let rec pomozna acc list1 list2 = match (list1, list2) with
    | ([], []) -> acc
    | (hd1 :: tl1, hd2 :: tl2) -> pomozna ((Some hd1, Some hd2) :: acc) tl1 tl2
    | (hd1 :: tl1, _) -> pomozna ((Some hd1, None) :: acc) tl1 []
    | (_, hd2 :: tl2) -> pomozna ((None, Some hd2) :: acc) [] tl2
  in
  List.rev (pomozna [] sez1 sez2)

(* 1. c) *)
let zip_default sez1 sez2 vrednost1 vrednost2 = 
  let rec pomozna acc list1 list2 = match (list1, list2) with
    | ([], []) -> acc
    | (hd1 :: tl1, hd2 :: tl2) -> pomozna (( hd1,  hd2) :: acc) tl1 tl2
    | (hd1 :: tl1, _) -> pomozna (( hd1, vrednost2) :: acc) tl1 []
    | (_, hd2 :: tl2) -> pomozna ((vrednost1,  hd2) :: acc) [] tl2
  in
  List.rev (pomozna [] sez1 sez2)

(* 1. d) *)

type response = Left | Middle | Right

let distribute f = 
  let rec pomozna acc1 acc2 acc3 = function
    | [] -> (List.rev acc1),(List.rev acc2), (List.rev acc3)
    | hd :: tl when (f hd) == Middle -> pomozna acc1 (hd :: acc2) acc3 tl
    | hd :: tl when (f hd) == Right -> pomozna (hd :: acc1) acc2 acc3  tl
    | hd :: tl-> pomozna acc1 acc2 (hd :: acc3) tl
  in
  pomozna [] [] [] 


(* 1. e) *)

type ('a, 'b) sum = Left of 'a | Right of 'b

let iso1 f = 
  let prva = function 
    | x -> f (Left x) in
  let druga = function
    | y -> f (Right y) in
    (prva, druga)



let iso2 (f, g )= 
  let sestavljena = function
    | Left x -> f x
    | Right x -> g x
  in
  sestavljena