type player = White | Black

type game_tree =
  | Winner of player
  | Tie
  | Decision of player * (float * game_tree) list

let primer =
  Decision
    ( White,
      [
        (0.3, Decision (Black, [ (0.5, Winner White); (0.5, Winner Black) ]));
        (0.7, Decision (Black, [ (0.5, Tie); (0.5, Winner Black) ]));
      ] )

(* 1. a) *)
let rec prestej_zmage = function 
  | Winner White -> 1
  | Winner Black -> 0
  | Tie -> 0
  | Decision (_ ,seznam) -> List.fold_left ( + ) 0 (List.map prestej_zmage (List.map snd seznam))



(* 1. b) *)
type result = { white_wins : float; black_wins : float; ties : float }

let rezultat igra = 
  let rec posodobi trenutna rez = function
    | (verjetnost, Winner White) -> {rez with white_wins = (rez.white_wins +. trenutna *. verjetnost) }
    | (verjetnost, Winner Black) -> {rez with black_wins = (rez.black_wins +. trenutna *. verjetnost) }
    | (verjetnost, Tie) -> {rez with ties = (rez.ties +. trenutna *. verjetnost) }
    | (verjetnost, Decision (_ ,seznam)) -> List.fold_left (posodobi (trenutna *. verjetnost)) rez seznam
in posodobi 1. { white_wins = 0.; black_wins = 0.; ties = 0. } (1., igra)

(* 1. c) *)
let je_veljavno igra = 
  let rec poglej = function
    | Winner White -> true
    | Winner Black -> true
    | Tie -> true
    | Decision (x ,seznam) when (x = White || x = Black) -> (((List.fold_left ( +. ) 0. (List.map fst seznam)) = 1.) && (List.fold_left ( && ) true (List.map poglej (List.map snd seznam))))
    |_ -> false
  in
  poglej igra


(* 1. d) *)
let odigraj_igro igra seznam_odlocitev = 
  let rec pomozna ver seznam = function
    | Winner White -> Some (White, ver)
    | Winner Black -> Some (Black, ver)
    | Tie -> None
    | Decision (_ ,seznam) when seznam_odlocitev <> [] -> 
      (let hd :: tl = seznam_odlocitev in 
      let x = List.nth_opt seznam hd in
      if x = None then None else let (a,b) = Option.get x in 
      pomozna (a *. ver) tl b)
    | _ -> None
  in
  pomozna 1. seznam_odlocitev igra