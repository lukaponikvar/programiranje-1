(* 1. a) *)
let vzporedna (a,b) (c,d) = if ((a,b) = (0,0)) then ((c,d) = (0,0)) else ((a * c + d * b) * (a * c + d * b) / (a * a + b * b) / (c*c + d*d) = 1)

(* 1. b) *)
let zlozi_pocez sez1 sez2 = 
  let rec zlozi acc list1 list2 = match list1 with
    | [] -> acc
    | hd1 :: tl1 -> (let glava1 :: rep1 = list2 in 
    let hd2 :: tl2 = tl1 in 
    let glava2 :: rep2 = rep1 in
    zlozi ((hd2, glava1) :: (hd1,glava2) :: acc) tl2 rep2)
  in
  List.rev (zlozi [] sez1 sez2)


(* 1. c) *)
let zdr f g x = f (g x)

let kompozitumi f n = if n = 0 then [] else
  let rec komp acc m = match m with
    | 1 -> acc
    | _ -> let hd :: tl = acc in komp ((zdr f hd) :: acc) (m-1)
  in
  List.rev (komp [f] n)


(* 1. d) *)
let repi lest = 
  let rec tail acc = function
    | [] -> [] :: acc 
    | hd :: tl -> tail ((hd::tl)::acc) tl
  in
  List.rev (tail [] lest)

(* 1. e) *)

type ('a, 'b) sum = Left of 'a | Right of 'b

let iso1 (x, y) = match y with
| Left a -> Left (x,a)
| Right b -> Right (x,b)

let iso2 x = match x with
| Left (a,b) -> (a, Left b)
| Right (a, b) ->(a,Right b)





let a = [1;2;3;4];;
let b = ['a';'b';'c';'d'];;
let a = fun x -> x+1;;
let x = Left 3
let y = Right ('A', 2)