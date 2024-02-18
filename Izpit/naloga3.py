from functools import cache
def sranga(cenilni_sez, dolzina, rezi):
    najdaljsi = len(cenilni_sez)
    @cache
    def pomozna(do_konca, preostali_rezi):
        if do_konca <= 0:
            return ([],0)
        elif preostali_rezi <= 0:
            return ([], cenilni_sez[do_konca-1])
        else:
            mozni = []
            for indeks in range(1, min(najdaljsi+1, do_konca+1)):
                (x,y) = pomozna(do_konca-indeks, preostali_rezi-1)
                mozni.append(([indeks]+x, y + cenilni_sez[indeks-1]))
            mozni.sort(key= lambda x : x[1] )
            return mozni[-1]
    return pomozna(dolzina, rezi)[0]

print(
    sranga(
        [3, 5, 8, 9, 10, 17, 17, 20],
        8, 3
    )
)

