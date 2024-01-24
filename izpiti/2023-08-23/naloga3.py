from functools import cache
polica = [10, 20, 60, 50, 30, 40]

def pomagaj_dedku(polica:list, vnuki:int):
    def napolni(velikost:int):
        prelomi = []
        k = 0
        for i, lonec in enumerate(polica):
            k += lonec
            if k > velikost:
                prelomi.append(i-1)
                k = lonec
        return prelomi
    kandidat = max(polica)
    while True:
        seznamcek = napolni(kandidat)
        if len(seznamcek) <= vnuki-1:
            rezultat = []
            prejsnji = 0
            for indeks in seznamcek:
                rezultat.append(polica[prejsnji:indeks+1])
                prejsnji = indeks+1
            rezultat.append(polica[prejsnji:])
            return (kandidat, rezultat)
        else:
            kandidat += 1

print(pomagaj_dedku(polica, 3))


def pomagaj_babici(vnuki, polica):
    @cache
    def poisci(indeks, stevilo):
        dolzina = len(polica)
        if indeks >= dolzina:
            return (0,[])
        elif stevilo <= 0:
            return (-100, [])
        elif stevilo == 1:
            return (sum(polica[indeks:]), [])
        else:
            mozne = []
            for i in range(indeks+1,dolzina+1):
                if i == dolzina:
                    mozne.append((sum(polica[indeks:]), []))
                else:
                    x = poisci(i, stevilo-1)
                    mozne.append((max(x[0], sum(polica[indeks: i])), [i]+x[1]))
            return min(mozne, key= lambda y: y[0])
        
    x = poisci (0, vnuki)
    rezultat = []
    prejsnji = 0
    for indeks in x[1]:
        rezultat.append(polica[prejsnji:indeks])
        prejsnji = indeks
    rezultat.append(polica[prejsnji:])
    return (x[0],rezultat)

print(pomagaj_babici(3, polica))

