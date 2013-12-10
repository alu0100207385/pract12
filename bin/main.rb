require "./lib/matrices/version"
require './lib/matrices_densa.rb'
require './lib/matrices_dispersa.rb'
require './lib/matricesDSL.rb'

def menu1
  system ("clear")
  z=0
  while (z<1 or z>5)
    op=["\t\tMENU","\t1. Crear matrices","\t2. Generar matrices con valores aleatorios","\t3. Operaciones con matrices","\t4. Mostrar matrices","\t5. Salir"]
    op.each{|op| puts op}
    z=gets.chomp
    z=z.to_i
    if (z<1 or z>5)
      puts ("Escoja una opcion entre [1..5]")
    end
  end
  z
end

def menu2
  system ("clear")
  z=0
  while (z<1 or z>5)
    op=["\t\tOPERACIONES CON MATRICES","\t1. Suma y resta de matrices","\t2. Producto escalar y entre matrices","\t3. Traspuesta de una matriz","\t4. Calcular maximo y minimo", "\t5. Volver"]
    op.each{|op| puts op}
    z=gets.chomp
    z=z.to_i
    if (z<1 or z>5)
      puts ("Escoja una opcion entre [1..4]")
    end
  end
  z
end

def menu3
  z=0
  while (z<1 or z>2)
    op=["\tQuiere trabajar con enteros o fracciones?","\t1. Numeros enteros","\t2. Numeros racionales"]
    op.each{|op| puts op}
    z=gets.chomp
    z=z.to_i
    if (z<1 or z>2)
      puts ("Escoja una opcion entre [1..2]")
    end
  end
  z
end

def menu4
  z=0
  while (z<1 or z>2)
    op=["\tIntroducir matriz densa o dispersa?","\t1. Matriz densa","\t2. Matriz dispersa"]
    op.each{|op| puts op}
    z=gets.chomp
    z=z.to_i
    if (z<1 or z>2)
      puts ("Escoja una opcion entre [1..2]")
    end
  end
  z
end

#Esta funcion la utilizamos para pausar del programa
def pausa
#     while line=gets
     while gets
      break
    end
end

#Ejecucion del programa principal
def principal
   op=0
  while (op!=5)
    op= menu1
    case op
      when 1
	puts "CREAR MATRICES"
	puts "Introduce la dimension de las matriz 1: "
	print "Filas? "
	STDOUT.flush
	f=gets.chomp
	print "Columnas? "
	c=gets.chomp
	op4=menu4
	case op4
	  when 1
	    a= Matriz_densa.new(f.to_i,c.to_i)
	  when 2
	    a= Matriz_dispersa.new(f.to_i,c.to_i)
	end
	op3=menu3
	case op3
	  when 1
	    a.introducir_datos(1)
	  when 2
	    a.introducir_datos(2)
	end

	puts "Introduce la dimension de las matriz 2: "
	print "Filas? "
	STDOUT.flush
	f=gets.chomp
	print "Columnas? "
	c=gets.chomp
	op4=menu4
	case op4
	  when 1
	    b= Matriz_densa.new(f.to_i,c.to_i)
	  when 2
	    b= Matriz_dispersa.new(f.to_i,c.to_i)
	end
	op3=menu3
	case op3
	  when 1
	    b.introducir_datos(1)
	  when 2
	    b.introducir_datos(2)
	end
	puts a.to_s
	puts b.to_s
	
      when 2
	puts "GENERAR MATRICES CON VALORES ALEATORIOS"
	puts "Introduce la dimension de la matriz 1: "
	print "Filas? "
	STDOUT.flush
	f=gets.chomp
	print "Columnas? "
	c=gets.chomp	
	op4=menu4
	case op4
	  when 1
	    a= Matriz_densa.new(f.to_i,c.to_i)
	  when 2
	    a= Matriz_dispersa.new(f.to_i,c.to_i)
	end
	op3=menu3
	case op3
	  when 1
	    a.generar(1)
	  when 2
	    a.generar(2)
	end
	
	puts "Introduce la dimension de la matriz 2: "
	print "Filas? "
	STDOUT.flush
	f=gets.chomp
	print "Columnas? "
	c=gets.chomp
	op4=menu4
	case op4
	  when 1 #matriz densa
	    b= Matriz_densa.new(f.to_i,c.to_i)
	  when 2 #matriz dispersa
	    b= Matriz_dispersa.new(f.to_i,c.to_i)
	end
	op3=menu3
	case op3
	  when 1
	    b.generar(1)
	  when 2
	    b.generar(2)
	end
	puts a.to_s
  	puts b.to_s

      when 3
	  op2=0
	  while (op2!=5)
	    op2= menu2
	    case op2
	      when 1
		puts "Suma"
		puts "M1 + M2 = M3"
		puts a.to_s
		puts "+" 
		puts b.to_s
		puts "="
		c = a+b
		puts c.to_s
	
		puts "Resta"
		puts "M1 - M2 = M3"
		puts a.to_s
		puts "-" 
		puts b.to_s
		puts "="
		c = a-b
		puts c.to_s
		pausa
		
	      when 2
		puts "Mutiplicacion por un escalar"
		print "Numero a multiplicar?: "
		STDOUT.flush
		num=gets.chomp
		num = num.to_i
		puts "#{num.to_i} * M1 = M3"
		puts a.to_s
		c= a*num
		puts c.to_s
		puts "Producto de matrices"
		puts "M1 * M2 = M3"
		puts a.to_s
		puts "*"
		puts b.to_s
		puts "="
		d=a*b
		puts d.to_s
		pausa

	      when 3
		puts "Traspuesta de matrices"
		puts "M1"
		puts a.to_s
		puts "traspuesta M1"
		puts "#{a.t.to_s}"
		puts "M2"
		puts b.to_s
		puts "traspuesta M2"
		puts "#{b.t.to_s}"
		pausa

	      when 4
		puts "Elementos maximos y minimos"
		puts "Maximo y minimo de M1"
		puts a.to_s
		puts "Max= #{a.max}"
		puts "Min= #{a.min}"
		puts "Maximo y minimo de M2"
		puts b.to_s
		puts "Max= #{b.max}"
		puts "Min= #{b.min}"
		pausa
	    end
	  end
      when 4
	
    nueva = MatrizDSL.new("suma") do
	option("densa","densa")
	resul(operand([[1,2,3],[4,5,6],[7,8,9]]),operand([[1,1,1],[1,1,1],[1,1,1]]))
    end
# puts "#{nueva.class}"
    puts nueva
# 	m=MatrizDSL.new("suma")
# 	puts m.to_s
	puts "MOSTRAR"
	puts "M1 = "
	puts a.to_s
	puts "M2 = "
	puts b.to_s
	if a==b
	  puts "Las matrices son iguales"
	else
	  puts "Las matrices son diferentes"
	end
    end
  pausa
  end
end

principal