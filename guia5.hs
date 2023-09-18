import Language.Haskell.TH (Lit(IntegerL))
import System.Win32 (xBUTTON1)

doubleMe :: Num a => a -> a
doubleMe x = x+x

--Ejercicio 1--
 

longitud :: [t] -> Integer
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

ultimo :: [t] -> t
ultimo [x] = x
ultimo (_:xs) = ultimo xs

principio :: [t] -> [t]
principio [x] = []
principio (_:xs) = principio xs

reverso :: [t] -> [t]
reverso [] = []
reverso [x] = [x]
reverso (x:xs) = reverso xs ++ [x]

--Ejercicio 2--

{--
1. pertenece :: (Eq t) => t -> [t] -> Bool seg´un la siguiente especificaci´on:
problema pertenece (e: T, s: seq⟨T⟩) : B {
requiere: { T rue }
asegura: { resultado = true ↔ e ∈ s }
}
--}

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece n (x:xs) | n==x = True
                   | otherwise = pertenece n xs

{--
2. todosIguales :: (Eq t) => [t] -> Bool, 
que dada una lista devuelve verdadero s´ı y solamente s´ı todos sus elementos son iguales.
--}

todosIguales :: (Eq t) => [t] -> Bool
todosIguales []=False
todosIguales [x]=True
todosIguales (x:y:xs) |x==y = todosIguales (y:xs)
                      | x/=y = False

{--
3. todosDistintos :: (Eq t) => [t] -> Bool seg´un la siguiente especificaci´on:
problema todosDistintos (s: seq⟨T⟩) : B {
requiere: { T rue }
asegura: { resultado = f alse ↔ existen dos posiciones distintas de s con igual valor }
}
--}

todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] =True
todosDistintos [x] =True
todosDistintos (x:y:xs) | x==y = False
                        | x/=y = todosDistintos (y:xs) && todosDistintos (x:xs)

{--
4. hayRepetidos :: (Eq t) => [t] -> Bool segun la siguiente especificacion:
problema hayRepetidos (s: seq⟨T⟩) : B {
requiere: { True }
asegura: { resultado = true ↔ existen dos posiciones distintas de s con igual valor }
}
--}
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos []=False
hayRepetidos [x]=False
hayRepetidos (x:y:xs) | pertenece x (y:xs)==True =True
                      | otherwise = hayRepetidos (y:xs)

{--
5. quitar :: (Eq t) => t -> [t] -> [t], que dados un entero x y una lista xs, elimina la primera aparici´on de x en
la lista xs (de haberla).
--}

quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar x l  | (pertenece x l) == False = l
            | x==(head l) = (tail l)
            | otherwise = (quitarDesde x l) ++ (quitar x (tail l))

quitarDesde :: (Eq t) => t -> [t] -> [t]
quitarDesde _ [] = []
quitarDesde x l | x== (ultimo l) = (principio l)
                | otherwise = quitarDesde x (principio l)
