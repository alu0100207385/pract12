require "./lib/matrices/version"
require "./lib/racionales.rb"
require "./lib/matrices.rb"
require "./lib/matrices_densa.rb"
include Matrices

class Matriz_dispersa < Matriz
  attr_reader :fil, :col, :pos, :dato
  
  def initialize (m,n) #Estructura de datos de la matriz dispersa
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    super
    @pos = Array.new(0){}
    @dato = Array.new(0){}
  end

  def llenar (posciones,datos) #Crea la matriz dispersa a partir del array de posiciones y de datos: posiciones y datos tienen que tener la misma dimension y datos no puede contener ceros
    for i in (0...posciones.size)
      @pos << posciones[i]
      @dato << datos[i]
    end
  end
  
  def to_s #Metodo para mostrar una matriz dispersa
    out_string = ""
    for i in (0...self.fil)
      out_string << "("
#       print "("
      for j in (0...self.col)
	b = buscar(i,j)
	if (b != -1)
	  out_string << " #{self.dato[b]}\t"
# 	  print " #{self.dato[b]}\t"
	else
	  out_string << " 0\t"
# 	  print " 0\t"
	end
      end
      out_string << ")\n"
#       puts ")\n"
    end
    out_string << "\n"
#     puts "\n"
    out_string
  end
  
  def mi_random #Hago esto, pq rand(-10..10) puede generar el valor cero y esto no nos interesa almacenarlo
    if (rand(10) > 4)
      1
    else
      -1
    end
  end
  
  def generar (o) #Segun la opcion elegida (1 o 2) crear la matriz dispersa con valores aleatorios (1)enteros o (2)racionales
    if (@fil*@col) == 1
      elementos = 1
    elsif
      elementos =(rand(60..100)*(@fil*@col))/100 #minimo 60% de ceros
    end
    dim= (@fil*@col)-elementos #num de elementos posibles para introducir valores respetando la dispersion
    @pos = Array.new(dim){[rand(0..(@fil-1)),rand(0..(@col-1))]}
    for i in (0...dim)
      if (o==1) #generamos enteros
	@dato = Array.new(dim){mi_random*rand(1..10)}
      elsif (o==2) #generamos racionales
	@dato = Array.new(dim){NumerosRacionales.new(mi_random*rand(1..10),rand(1..10))}
      end
    end
  end  

  def buscar (i,j) #Devuelve una posicion del array que coincide con los indices de los param
    aux=[i,j]
    posicion= -1
    k=0
    while (k < @pos.size) and (posicion==-1)
      if (@pos[k]==aux)
	posicion=k
      end
      k=k+1
    end
    posicion
  end


  def introducir_datos (o) #El usuario puede elegir los tipos de datos (1.enteros y 2.racionales) y datos que contendra la matriz
    if (@fil*@col)==1
      max=0
    elsif
      max= (@fil*@col*60)/100
      max = (@fil*@col)-max
    end
    total= -1
    while (total<0) or (total>max)
      puts "Cuantos datos va a introducir? [0-#{max}]"
      STDOUT.flush
      total=gets.chomp
      total=total.to_i
    end
    if (o==1) #de numeros enteros
      for k in (0...total)
	i,j= -1,-1
	while (i<0) or (i>(@fil-1))
	  puts "introduce la coordenada i: "
	  STDOUT.flush
	  i=(gets.chomp).to_i
	end
	while (j<0) or (j>(@col-1))
	  puts "introduce la coordenada j: "
	  STDOUT.flush
	  j=(gets.chomp).to_i
	end
	@pos << [i.to_i,j.to_i]
	dato=0
	while (dato == 0)
	  puts "introduce el dato (=/=0) de la casilla (#{i},#{j}): "
	  STDOUT.flush
	  dato=(gets.chomp).to_i
	end
	@dato << dato
      end
    elsif #de numeros racionales
      for k in (0...total)
	i,j= -1,-1
	while (i<0) or (i>(@fil-1))
	  puts "introduce la coordenada i: "
	  STDOUT.flush
	  i=(gets.chomp).to_i
	end
	while (j<0) or (j>(@col-1))
	  puts "introduce la coordenada j: "
	  STDOUT.flush
	  j=(gets.chomp).to_i
	end
	@pos << [i.to_i,j.to_i]
	num=0
	while (num == 0)
	  puts "introduce el dato (=/=0) de la casilla (#{i},#{j}): "
	  puts "numerador: "
	  STDOUT.flush
	  num=(gets.chomp).to_i
	end
	puts "denominador: "
	STDOUT.flush
	den=gets.chomp
	@dato << NumerosRacionales.new(num,den.to_i)
      end
    end
  end
  
  def ==(other) #Compara si dos matrices son iguales o no
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      if (@pos.size == 0) and (other.pos.size == 0)#si ambos estan estan vacios...
	return true
      elsif (@pos.size == other.pos.size)
	for i in (0...@pos.size)
	  k = other.buscar(@pos[i][0],@pos[i][1]) #buscamos esa pos en el otro vector
	  if (k == -1)
	    return false
	  elsif (@dato[i] != other.dato[k])
	    return false
	  end
	end
	return true
      else
	return false
      end
    else
      return false
    end
  end
  
  def coerce(other) #Metodo para hacer la conversion de datos para poder operar con la clase matriz dispersa
    a=Matriz_dispersa.new(other.fil,other.col)
    for i in (0...other.fil)
      for j in (0...other.col)
	if (other.mat[i][j] != 0)
	  a.pos << [i,j]
	  a.dato << other.mat[i][j]
	end
      end
    end
    return[a,self]
  end
  
  def t ##Calcula la traspuesta de la matriz
    nueva = Matriz_dispersa.new(@col,@fil)
    for i in (0...@pos.size)
      nueva.pos << [@pos[i][1],@pos[i][0]]
      nueva.dato << @dato[i]
    end
    nueva
  end
  
  def +(other) #Devuelve la suma de dos matrices
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      nueva= Matriz_dispersa.new(@fil,@col)
      @pos.size.times do |i|		# 0.upto(@pos.size-1) do |i|	# for i in (0...@pos.size)
	k = other.buscar(@pos[i][0],@pos[i][1])
	if (k!= -1) #existe esa pos
	  if (@dato[i]+other.dato[k]) != 0
	    nueva.pos << @pos[i]
	    nueva.dato << (@dato[i]+other.dato[k])
	  end
	else
	  nueva.pos << @pos[i]
	  nueva.dato << @dato[i]
	end
      end #times
       #almacenamos los que no se hayan sumado de la otra matriz
      other.pos.size.times do |i|	# 0.upto(other.pos.size-1) do |i| #for i in (0...other.pos.size)
	k = nueva.buscar(other.pos[i][0],other.pos[i][1])
	if (k==-1)
	  nueva.pos << other.pos[i]
	  nueva.dato << other.dato[i]
	end
      end
    else
      puts "No se pueden sumar, no tienen las mismas dimensiones"
    end #if
    nueva
  end
  
    def -(other) #Devuelve la resta de dos matrices
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      nueva= Matriz_dispersa.new(@fil,@col)
      @pos.size.times do |i|		# 0.upto(@pos.size-1) do |i|	# for i in (0...@pos.size)
	k = other.buscar(@pos[i][0],@pos[i][1])
	if (k!= -1) #existe esa pos
	  if (@dato[i]-other.dato[k]) != 0
	    nueva.pos << @pos[i]
	    nueva.dato << (@dato[i]-other.dato[k])
	  end
	else
	  nueva.pos << @pos[i]
	  nueva.dato << @dato[i]
	end
      end #for
       #almacenamos los que no se hayan sumado de la otra matriz
      other.pos.size.times do |i|	# 0.upto(other.pos.size-1) do |i| #for i in (0...other.pos.size)
	k = nueva.buscar(other.pos[i][0],other.pos[i][1])
	if (k==-1)
	  nueva.pos << other.pos[i]
	  nueva.dato << -other.dato[i]
	end
      end
    else
      puts "No se pueden restar, no tienen las mismas dimensiones"
    end #if
    nueva
  end
  
  def *(other) #Producto: segun clase de other: si es un numero realiza el producto ecalar, si en cambio es otra matriz se realiza el producto de matrices.
    if other.is_a?(Numeric)
      nueva=self
      @dato.size.times do |i| # for i in (0...@dato.size)
	nueva.dato[i] = other*nueva.dato[i]
      end
      nueva
    elsif other.is_a?(Matriz)
      if (self.col == other.fil)
	if (other.is_a?(Matriz_densa))
	  other=self.coerce(other)
	  other=other[0]
	end
	nueva= Matriz_dispersa.new(@fil,other.col)
	@fil.times do |i| # for i in (0...@fil)
	  @col.times do |j| # for j in (0...@col)
	    resul = 0
	    @col.times do |k| # for k in (0...@col)
	      n = self.buscar(i,k)
	      if n != -1
		m = other.buscar(k,j)
		if m != -1
		  resul += self.dato[n] * other.dato[m]
		end
	      end
	     end
	     if resul != 0
	      nueva.dato << resul
	      nueva.pos << [i,j]
	     end
	   end # for j
	 end #for i
	nueva
      else
	puts "Error. No se pueden multiplicar estas matrices. La col de la M1 debe coincidir con la fil de M2"
      end
    end
  end
  
  def max #Devuelve el elemento mayor de la matriz
    r = -999999
    aux=@dato
    aux<< 0
     @dato.each do |i|
     if (i.to_f>r.to_f)
	r=i
      end
    end
    r
  end

  def min #Devuelve el elemento menor de la matriz
    r = 999999
    aux=@dato
    aux<< 0
    @dato.each do |i|
      if (i.to_f<r.to_f)
	r=i
      end
    end
    r
  end
  
end