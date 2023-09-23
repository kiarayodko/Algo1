{--
problema relacionesValidas (relaciones: seq⟨String × String⟩) : Bool {
requiere: {True}
asegura: {(res = true) ↔ no hay tuplas en relaciones con ambas componentes iguales ni tuplas repetidas (sin considerar
el orden)}
}
--}
relacionesValidas :: [(String, String)] -> Bool
relacionesValidas []= True
relacionesValidas (x:xs) | ambasComponentesIguales x || repetidas (x:xs)  = False
                         | otherwise = relacionesValidas xs

ambasComponentesIguales :: (String, String) -> Bool
ambasComponentesIguales (a,b) | a==b =True
                              | otherwise = False

repetidas :: [(String, String)] -> Bool
repetidas []=False
repetidas [x]=False
repetidas (x:xs) | x==head xs || invertidas x (head xs) =True
                 | otherwise= repetidas xs 

invertidas :: (String, String) -> (String, String) -> Bool
invertidas x y | fst x == snd y && fst y == snd x =True
               | otherwise= False


{--
problema personas (relaciones: seq⟨String × String⟩) : seq⟨String⟩ {
requiere: {relacionesV alidas(relaciones)}
asegura: {resu tiene exactamente los elementos que figuran en alguna tupla de relaciones en cualquiera de las dos
posiciones, sin repetir}
}
--}

personas :: [(String, String)] -> [String]
personas x = sacaRepetidos (personasConRepes x)

personasConRepes :: [(String, String)] -> [String]
personasConRepes []=[]
personasConRepes (x:xs) = [fst x, snd x] ++ personasConRepes xs

sacaRepetidos :: [String] -> [String]
sacaRepetidos []=[]
sacaRepetidos [x]=[x]
sacaRepetidos (x:y:xs) | pertenece x (y:xs)==False = (x:sacaRepetidos(y:xs))
                       | otherwise= sacaRepetidos (y:xs)

--arreglar los tipos de esto--
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece n (x:xs) | n==x = True
                   | otherwise = pertenece n xs


{--
problema amigosDe (persona: String, relaciones: seq⟨String × String⟩) : seq⟨String⟩ {
requiere: {relacionesV alidas(relaciones)}
asegura: {resu tiene exactamente los elementos que figuran en alguna tupla de relaciones en las que alguna de las
componentes es persona}
}
--}

amigosDe :: String -> [(String, String)] -> [String]
amigosDe _ [] = []
amigosDe a (x:xs) = devuelveAmigo a x ++ amigosDe a xs


devuelveAmigo :: String -> (String, String) -> [String]
devuelveAmigo a (x,y) | a == x = [y]
                      | a == y = [x]
                      | otherwise = []


{--
problema personaConMasAmigos (relaciones: seq⟨String × String⟩) : String {
requiere: {relaciones no vac´ıa}
requiere: {relacionesV alidas(relaciones)}
asegura: {resu es el Strings que aparece m´as veces en las tuplas de relaciones (o alguno de ellos si hay empate)}
}
--}
 personaConMasAmigos :: [(String, String)] -> String
personaConMasAmigos [x]=fst x
personaConMasAmigos (x:y:xs)=personaConMasAmigos1 (personas (x:y:xs)) (personasConRepes (x:y:xs))

cantidadDeApariciones :: String -> [String] -> Integer
cantidadDeApariciones _ []=0
cantidadDeApariciones a (x:xs) | a==x =1+cantidadDeApariciones a xs
                               | otherwise = cantidadDeApariciones a xs

personaConMasAmigos1 :: [String] -> [String] -> String              --se fija que persona aparece mas veces en personasconrepes
personaConMasAmigos1 [x,y] xs | cantidadDeApariciones x xs>= cantidadDeApariciones y xs =x
                              | otherwise=y
personaConMasAmigos1 a b | cantidadDeApariciones (head a) b>= cantidadDeApariciones (head(tail a)) b = personaConMasAmigos1 (head a:tail(tail a)) b
                         | otherwise=personaConMasAmigos1 (tail a) b

