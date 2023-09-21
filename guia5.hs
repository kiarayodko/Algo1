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
            | otherwise = (quitarDesde x l) ++ (quitarHasta x l)

quitarHasta :: (Eq t) => t -> [t] -> [t]
quitarHasta _ []=[]
quitarHasta a (x:xs) | pertenece a (x:xs)==False = (x:xs)
                     | a==x = xs
                     | otherwise = quitarHasta a xs

quitarDesde :: (Eq t) => t -> [t] -> [t]
quitarDesde _ []=[]
quitarDesde a (x:xs) | pertenece a (x:xs)==False = (x:xs)
                     | a==x = []
                     | otherwise = (x:quitarDesde a xs)

--Esto es la mejor forma???? probablemente no

{--
6. quitarTodos :: (Eq t ) => t -> [t] -> [t], que dados un entero x y una lista xs, elimina todas las apariciones
de x en la lista xs (de haberlas). Es decir:
problema quitarTodos (e: T, s: seq⟨T⟩) : seq⟨T⟩ {
requiere: { T rue }
asegura: { resultado es igual a s pero sin el elemento e. }
}
--}

quitarTodos :: (Eq t ) => t -> [t] -> [t]
quitarTodos _ [] = []
quitarTodos a (x:xs) | pertenece a (x:xs) == False = (x:xs)
                     | otherwise = quitar a (quitar a (x:xs))

{--
7. eliminarRepetidos :: (Eq t) => [t] -> [t] que deja en la lista una ´unica aparici´on de cada elemento, eliminando
las repeticiones adicionales
--}
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos []=[]
eliminarRepetidos [x]=[x]
eliminarRepetidos (x:y:xs) | pertenece x (y:xs)==False = (x:eliminarRepetidos(y:xs))
                           | otherwise= eliminarRepetidos (y:xs)

{--
8. mismosElementos :: (Eq t) => [t] -> [t] -> Bool, que dadas dos listas devuelve verdadero s´ı y solamente s´ı
ambas listas contienen los mismos elementos, sin tener en cuenta repeticiones, es decir:
problema mismosElementos (s: seq⟨T⟩, r: seq⟨T⟩) : B {
requiere: { T rue }
asegura: { resultado = true ↔ todo elemento de s pertenece r y viceversa}
}
--}

mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos x y = contenido (eliminarRepetidos x) (eliminarRepetidos y) && contenido (eliminarRepetidos y) (eliminarRepetidos x)

-- contenido es como en algebra, cuando A estaba contenido en B
contenido :: (Eq t) => [t] -> [t] -> Bool
contenido [] _ = True
contenido [x] (y:xs) = pertenece x (y:xs)
contenido x y | pertenece (head x) y==False =False
              | otherwise = contenido (tail x) y

{--
9. capicua :: (Eq t) => [t] -> Bool seg´un la siguiente especificaci´on:
problema capicua (s: seq⟨T⟩) : B {
requiere: { T rue }
asegura: { (resultado = true) ↔ (s = reverso(s)) }
}
Por ejemplo capicua [´a’,’c’, ’b’, ’b’, ’c’, ´a’] es true, capicua [´a’, ’c’, ’b’, ’d’, ´a’] es false.
--}

capicua :: (Eq t) => [t] -> Bool
capicua x = reverso x==x

--------------
--Ejercicio 3
--------------

{--
1. sumatoria :: [Integer] -> Integer seg´un la siguiente especificaci´on:
problema sumatoria (s: seq⟨Z⟩) : Z {
requiere: { T rue }
asegura: { resultado =
P|s|−1
i=0 s[i] }
}
--}

sumatoria :: [Integer] -> Integer
sumatoria []=0
sumatoria [x]=x
sumatoria [x,y]=x+y
sumatoria (x:y:xs)= x+y+sumatoria xs

{--
2. productoria :: [Integer] -> Integer seg´un la siguiente especificaci´on:
problema productoria (s: seq⟨Z⟩) : Z {
requiere: { T rue }
asegura: { resultado =
Q|s|−1
i=0 s[i] }
}
--}

productoria :: [Integer] -> Integer
productoria [x]=x
productoria [x,y]=x*y
productoria (x:y:xs)= x*y*productoria xs

{--
3. maximo :: [Integer] -> Integer seg´un la siguiente especificaci´on:
problema maximo (s: seq⟨Z⟩) : Z {
requiere: { |s| > 0 }
asegura: { resultado ∈ s ∧ todo elemento de s es menor o igual a resultado }
}
--}

maximo :: [Integer] -> Integer
maximo [x]=x
maximo (x:y:xs) | x>=y =maximo(x:xs)
                | otherwise= maximo (y:xs)

{--
4. sumarN :: Integer -> [Integer] -> [Integer] seg´un la siguiente especificaci´on:
problema sumarN (n: Z, s: seq⟨Z⟩) : seq⟨Z⟩ {
requiere: { T rue }
asegura: {|resultado| = |s| ∧ cada posici´on de resultado contiene el valor que hay en esa posici´on en s sumado
n }
}
--}

sumarN :: Integer -> [Integer] -> [Integer]
sumarN _ []=[]
sumarN n (x:xs)= (x+n) : sumarN n xs

{--
5. sumarElPrimero :: [Integer] -> [Integer] seg´un la siguiente especificaci´on:
problema sumarElPrimero (s: seq⟨Z⟩) : seq⟨Z⟩ {
requiere: { |s| > 0 }
asegura: {resultado = sumarN(s[0], s) }
}
Por ejemplo sumarElPrimero [1,2,3] da [2,3,4]
--}

sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero x= sumarN (head x) x

{--
6. sumarElUltimo :: [Integer] -> [Integer] seg´un la siguiente especificaci´on:
problema sumarElUltimo (s: seq⟨Z⟩) : seq⟨Z⟩ {
requiere: { |s| > 0 }
asegura: {resultado = sumarN(s[|s| − 1], s) }
}
--}

sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo x = sumarN (ultimo x) x

{--
7. pares :: [Integer] -> [Integer] seg´un la siguiente especificaci´on:
problema pares (s: seq⟨Z⟩) : seq⟨Z⟩ {
requiere: { T rue }
asegura: {resultado s´olo tiene los elementos pares de s en el orden dado, respetando las repeticiones}
}
--}

pares :: [Integer] -> [Integer]
pares [] = []
pares (x:xs) | mod x 2==0 = x: (pares xs)
             | otherwise = pares xs

{--
8. multiplosDeN :: Integer -> [Integer] -> [Integer] que dado un n´umero n y una lista xs, devuelve una lista
con los elementos de xs m´ultiplos de n.
--}

multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN _ []=[]
multiplosDeN n (x:xs) | mod x n ==0 = x : (multiplosDeN n xs)
                      | otherwise = multiplosDeN n xs

{--
9. ordenar :: [Integer] -> [Integer] que ordena los elementos de la lista en forma creciente
--}

ordenar :: [Integer] -> [Integer]
ordenar []=[]
ordenar [x]=[x]
ordenar (x:y:xs) = ordenar (quitar (maximo (x:y:xs)) (x:y:xs)) ++ [maximo (x:y:xs)]


---------------
--Ejercicio 4
---------------

{--
1. sacarBlancosRepetidos :: [Char] -> [Char], que reemplaza cada subsecuencia de blancos contiguos de la primera
lista por un solo blanco en la lista resultado.
--}

sacarBlancosRepetidos :: [Char] -> [Char]
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos [x]=[x]
sacarBlancosRepetidos (x:y:xs) | x==y && x==' ' =sacarBlancosRepetidos (y:xs)
                             | otherwise = x:(sacarBlancosRepetidos xs)
                             --esto no anda ARREGLAR!!!!!!!!!!!!!!!
