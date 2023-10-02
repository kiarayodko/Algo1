
import math
####Ejercicio 1#####
#1
def holaMundo ():
    print("hola mundo")

#3
def raizDe2() -> float:
    res=math.sqrt (2)
    return res

#4
def factorial_de_dos ()-> int:
    res=2
    return res

#5
def perimetro ()->float:
    res=math.pi*2
    return res

def tests_ejercicio1 ():
    print("tests de todo el ejercicio 1")

tests_ejercicio1()
test1=raizDe2()
print("raizDe2",test1)
test2=factorial_de_dos()
print("factorial_de_dos", test2)
test3=perimetro()
print("perimetro",test3)




####Ejercicio 2
#1
def imprimir_saludo (nombre:str):
    print ("hola", nombre)

#2
def raiz_cuadrada_de (numero:float)->float:
    res=math.sqrt(numero)
    return res

#3
def fahrenheit_a_celsius (temp_far:float)->float:
    res=((temp_far-32)*5)/9
    return res

#4
def imprimir_dos_veces (estribillo:str):
    print(estribillo, estribillo)
    
# 5
def es_multiplo_de (n:int, m:int) -> bool :
    res:bool = n%m==0
    return res

#6
def es_par (numero:int)->bool:
    res=es_multiplo_de(numero,2)
    return res

#7
def cantidad_de_pizzas (comensales:int, min_cant_de_porciones:int)->int:
    res= int(((comensales*min_cant_de_porciones)/8)+0.9)
    return res

def tests_ejercicio2 ():
    print("tests de todo el ejercicio 2")

tests_ejercicio2 ()
test1=imprimir_saludo("kiara")
test2=raiz_cuadrada_de(4)
print("raiz_cuadrada_de(4)", test2)
test3=fahrenheit_a_celsius(85)
print("fahrenheit a celsius(85)", test3)
test4=imprimir_dos_veces ("me quiero irrrrrrrr")
test5=es_multiplo_de (5,6)
print("es_multiplo_de(5,6)",test5)
test6 = es_multiplo_de (2,3)
print ("Resultado de es_multiplo_de(2,3):" , test6)
test7 = es_multiplo_de (2,4)
print ("Resultado de es_multiplo_de(2,4):", test7)
test8 = es_multiplo_de (-4,2)
print ("Resultado de es_multiplo_de(-4,2):", test8)
test9=es_par (8)
print("es_par(8)", test9)
test10=es_par (3)
print("es_par(3)",test10)
test11=cantidad_de_pizzas (3,5)
print("cantidad_de_pizza(3,5)",test11)
test12=cantidad_de_pizzas (1,3)
print ("cantidad_de_pizzas (1,3)", test12)




###Ejercicio 3
#1
def alguno_es_0 (numero1:float, numero2:float)->bool:
    res= numero1==0 or numero2==0
    return res

#2
def ambos_son_0 (numero1:float, numero2:float)->bool:
    res= numero1==0 and numero2==0
    return res

# 3
def es_nombre_largo (nombre:str) -> bool:
    l:int =len (nombre)
    res:bool = 3<=l and l<=8
    return res

#4
def es_bisiesto (año: int)-> bool:
    res= año%400==0 or (año%4==0 and año%100!=0)
    return res

def tests_ejercicio3 ():
    print ("todos los tests del ejercicio 3")

tests_ejercicio3 ()
test1=alguno_es_0(1,1)
print("alguno_es_0 (1,1)", test1)
test2=alguno_es_0(0,1)
print("alguno_es_0 (0,1)", test2)
test3=alguno_es_0(1,0)
print ("alguno_es_0 (1,0)", test3)
test4=ambos_son_0(0,0)
print("ambos_son_0 (0,0)", test4)
test5 = ambos_son_0 (8,0)
print("ambos_son_0 (8,0)", test5)
test6 = es_nombre_largo ("kiara")
print ("Resultado de es_nombre_largo (kiara)" ,test6)
test7 = es_nombre_largo ("kwghlghwrghrouiwgirwu")
print (test7 )
test6 = es_nombre_largo ("kia")
print (test7)
test8 = es_nombre_largo ("a")
print (test8)
test9=es_bisiesto (2024)
print("es_bisiesto (2024)", test9)
test10= es_bisiesto(2022)
print("es_bisiesto (2022)", test10)


####Ejercicio 5.1
def devolver_el_doble_si_es_par (numero: int) -> int:
    if numero%2==0:
        res=2*numero
    else: 
        res=numero
    return res

holaMundo()
test8 = devolver_el_doble_si_es_par (2)
print ("resultado de devolver_el_doble_si_es_par (2)", test8)
test9= devolver_el_doble_si_es_par (9)
print ("resultado de devolver_el_doble_si_es_par (9)", test9)

#2
