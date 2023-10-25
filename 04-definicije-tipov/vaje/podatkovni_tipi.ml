(* ========== Vaja 3: Definicije Tipov  ========== *)

(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 Pri modeliranju denarja ponavadi uporabljamo racionalna števila. Problemi se
 pojavijo, ko uvedemo različne valute.
 Oglejmo si dva pristopa k izboljšavi varnosti pri uporabi valut.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 Definirajte tipa [euro] in [dollar], kjer ima vsak od tipov zgolj en
 konstruktor, ki sprejme racionalno število.
 Nato napišite funkciji [euro_to_dollar] in [dollar_to_euro], ki primerno
 pretvarjata valuti (točne vrednosti pridobite na internetu ali pa si jih
 izmislite).

 Namig: Občudujte informativnost tipov funkcij.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dollar_to_euro;;
 - : dollar -> euro = <fun>
 # dollar_to_euro (Dollar 0.5);;
 - : euro = Euro 0.4305
[*----------------------------------------------------------------------------*)
type euro = {vrednost : float}    (* {im: int; st: int} *)

type dollar = {vrednost' : float}

let euro_to_dollar euro = {vrednost' = euro.vrednost *. 1.06}

let dollar_to_euro dollar = {vrednost = dollar.vrednost' *. 0.94}

type euro = Euro of float
type dollar = Dollar of float

let dollar_to_euro (Dollar x) = Euro (x *. 0.95)
let euro_to_dollar (Euro x) = Dollar (x *. 1.05)

let moja_denarnica = Euro 10.

(*----------------------------------------------------------------------------*]
 Definirajte tip [currency] kot en vsotni tip z konstruktorji za jen, funt
 in švedsko krono. Nato napišite funkcijo [to_pound], ki primerno pretvori
 valuto tipa [currency] v funte.

 Namig: V tip dodajte še švicarske franke in se navdušite nad dejstvom, da vas
        Ocaml sam opozori, da je potrebno popraviti funkcijo [to_pound].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # to_pound (Yen 100.);;
 - : currency = Pound 0.007
[*----------------------------------------------------------------------------*)
type currency = 
  | Yen of float
  | Pound of float
  | Krona of float
  | Swiss_franc of float

let to_pound = function
  | Yen x -> Pound (x *. 0.0055)
  | Pound x -> Pound (x)
  | Krona x -> Pound(x *. 0.074)
  | Swiss_franc x -> Pound(x *. 0.92)
(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 Želimo uporabljati sezname, ki hranijo tako cela števila kot tudi logične
 vrednosti. To bi lahko rešili tako da uvedemo nov tip, ki predstavlja celo
 število ali logično vrednost, v nadaljevanju pa bomo raje konstruirali nov tip
 seznamov.

 Spomnimo se, da lahko tip [list] predstavimo s konstruktorjem za prazen seznam
 [Nil] (oz. [] v Ocamlu) in pa konstruktorjem za člen [Cons(x, xs)] (oz.
 x :: xs v Ocamlu).
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 Definirajte tip [intbool_list] z konstruktorji za:
  1.) prazen seznam,
  2.) člen s celoštevilsko vrednostjo,
  3.) člen z logično vrednostjo.

 Nato napišite testni primer, ki bi predstavljal "[5; true; false; 7]".
[*----------------------------------------------------------------------------*)
type intbool_list = 
  | Nil
  | Int of (int * intbool_list)
  | Bool of (bool * intbool_list) 

let testni_primer = 
  Int(5, Bool(true, Bool(false, Int(7, Nil))))
(*----------------------------------------------------------------------------*]
 Funkcija [intbool_map f_int f_bool ib_list] preslika vrednosti [ib_list] v nov
 [intbool_list] seznam, kjer na elementih uporabi primerno od funkcij [f_int]
 oz. [f_bool].
[*----------------------------------------------------------------------------*)
let rec intbool_map f_int f_bool = function
  | Nil -> Nil
  | Int (x, lst) -> Int (f_int x, intbool_map f_int f_bool lst)
  | Bool (x, lst) -> Bool (f_bool x, intbool_map f_int f_bool lst)


(*----------------------------------------------------------------------------*]
 Funkcija [intbool_reverse] obrne vrstni red elementov [intbool_list] seznama.
 Funkcija je repno rekurzivna.
[*----------------------------------------------------------------------------*)
let intbool_reverse lst = 
let rec intbool_reverse' acc = function
  | Nil -> acc
  | Int (x, lst) -> intbool_reverse' (Int (x, acc)) lst
  | Bool (x, lst) -> intbool_reverse' (Bool (x, acc)) lst 
in
intbool_reverse' Nil lst


let intbool_map f_int f_bool lst =
  let rec intbool_map' acc = function
    | Nil -> acc
    | Int (x, lst) -> intbool_map' (Int (f_int x, acc)) lst
    | Bool (x, lst) -> intbool_map' (Bool (f_bool x, acc)) lst
  in
  intbool_reverse (intbool_map' Nil lst)
(*----------------------------------------------------------------------------*]
 Funkcija [intbool_separate ib_list] loči vrednosti [ib_list] v par [list]
 seznamov, kjer prvi vsebuje vse celoštevilske vrednosti, drugi pa vse logične
 vrednosti. Funkcija je repno rekurzivna in ohranja vrstni red elementov.
[*----------------------------------------------------------------------------*)
let intbool_separate ib_list =
  let rec intbool_separate' acci accb = function
    | Nil -> (acci, accb)
    | Int (x, lst) -> intbool_separate' (x :: acci) accb lst
    | Bool (x, lst) -> intbool_separate' acci (x :: accb) lst
  in
intbool_separate' [] [] (intbool_reverse ib_list)

(* let intbool_separate ib_list =
  let rec intbool_separate' acci accb = function
    | Nil ->(acci accb)
    | Int (x, lst) -> intbool_separate' (Int (x, acci)) accb lst
    | Bool (x, lst) -> intbool_separate' acci (Bool (x, accb)) lst
  in
intbool_separate' Nil Nil (intbool_reverse ib_list) *)
(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 Določeni ste bili za vzdrževalca baze podatkov za svetovno priznano čarodejsko
 akademijo "Effemef". Vaša naloga je konstruirati sistem, ki bo omogočil
 pregledno hranjenje podatkov.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 Čarodeje razvrščamo glede na vrsto magije, ki se ji posvečajo. Definirajte tip
 [magic], ki loči med magijo ognja, magijo ledu in magijo arkane oz. fire,
 frost in arcane.

 Ko se čarodej zaposli na akademiji, se usmeri v zgodovino, poučevanje ali
 raziskovanje oz. historian, teacher in researcher. Definirajte tip
 [specialisation], ki loči med temi zaposlitvami.
[*----------------------------------------------------------------------------*)
type magic =
| Fire
| Frost
| Arcane

type specialisation = 
| Historian
| Teacher 
| Researcher 

type carodej = {magic : magic; specialisation: specialisation}

let carovnik = {magic = Fire ; specialisation = Historian}
(*----------------------------------------------------------------------------*]
 Vsak od čarodejev začne kot začetnik, nato na neki točki postane študent,
 na koncu pa SE lahko tudi zaposli.
 Definirajte tip [status], ki določa ali je čarodej:
  a.) začetnik [Newbie],
  b.) študent [Student] (in kateri vrsti magije pripada in koliko časa študira),
  c.) zaposlen [Employed] (in vrsto magije in specializacijo).

 Nato definirajte zapisni tip [wizard] z poljem za ime in poljem za trenuten
 status.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # professor;;
 - : wizard = {name = "Matija"; status = Employed (Fire, Teacher)}
[*----------------------------------------------------------------------------*)
type status =
| Newbie
| Student of magic * int
| Employed of magic * specialisation

type wizard = {name : string; status : status }

let professor = {name = "Matija"; status = Employed (Fire, Teacher)}
(*----------------------------------------------------------------------------*]
 Želimo prešteti koliko uporabnikov posamezne od vrst magije imamo na akademiji.
 Definirajte zapisni tip [magic_counter], ki v posameznem polju hrani število
 uporabnikov magije.
 Nato definirajte funkcijo [update counter magic], ki vrne nov števec s
 posodobljenim poljem glede na vrednost [magic].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # update {fire = 1; frost = 1; arcane = 1} Arcane;;
 - : magic_counter = {fire = 1; frost = 1; arcane = 2}
[*----------------------------------------------------------------------------*)
type magic_counter = {fire: int; frost: int; arcane: int}

let update counter = function
  | Fire -> { counter with fire = counter.fire + 1}
  | Frost -> { counter with frost = counter.frost + 1}
  | Arcane -> { counter with arcane = counter.arcane + 1}

let counter = {fire = 0; frost = 0; arcane = 0}
(*----------------------------------------------------------------------------*]
 Funkcija [count_magic] sprejme seznam čarodejev in vrne števec uporabnikov
 različnih vrst magij.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # count_magic [professor; professor; professor];;
 - : magic_counter = {fire = 3; frost = 0; arcane = 0}
[*----------------------------------------------------------------------------*)

let count_magic = 
  let rec count counter = function
    | [] -> counter
    | {name; status} :: wizards -> match status with
      | Newbie -> count counter wizards
      | Student (magic, _) -> count (update counter magic) wizards
      | Employed (magic, _) -> count (update counter magic) wizards
  in
count {fire = 0; frost = 0; arcane = 0}

(*----------------------------------------------------------------------------*]
 Želimo poiskati primernega kandidata za delovni razpis. Študent lahko postane
 zgodovinar po vsaj treh letih študija, raziskovalec po vsaj štirih letih
 študija in učitelj po vsaj petih letih študija.
 Funkcija [find_candidate magic specialisation wizard_list] poišče prvega
 primernega kandidata na seznamu čarodejev in vrne njegovo ime, čim ustreza
 zahtevam za [specialisation] in študira vrsto [magic]. V primeru, da ni
 primernega kandidata, funkcija vrne [None].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # let jaina = {name = "Jaina"; status = Student (Frost, 4)};;
 # find_candidate Frost Researcher [professor; jaina];;
 - : string option = Some "Jaina"
[*----------------------------------------------------------------------------*)
type 'a option = None | Some of 'a

let rec find_candidate magic specialisation wizard_list =
  let v_leta = function
    | Historian -> 3
    | Teacher -> 5
    | Researcher -> 4 
  in
  match wizard_list with
    | [] -> None
    | {name; status} :: wizards -> match status with
        | Newbie ->  find_candidate magic specialisation wizards
        | Student (spec, leta) -> if leta >= (v_leta specialisation) && spec = magic then Some name else find_candidate magic specialisation wizards
        | Employed (_, _) -> find_candidate magic specialisation wizards




let jaina = {name = "Jaina"; status = Student (Frost, 4)};;




(*----------------------------------------------------------------------------*]
 Napisi funkcijo izracunaj:
[*----------------------------------------------------------------------------*)

type izraz =
  | Stevilo of int
  | Plus of izraz * izraz
  | Minus of izraz
  | Krat of izraz * izraz

let izraz = Minus (Krat (Stevilo 5, Plus (Stevilo 2, Stevilo 7)))

let rec izracunaj = function
  | Stevilo x -> x
  | Plus (exp1, exp2) -> izracunaj exp1 + izracunaj exp2
  | Minus exp -> - izracunaj exp 
  | Krat (exp1, exp2) -> izracunaj exp1 * izracunaj exp2