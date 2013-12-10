require "./lib/matrices/version"
require "./lib/racionales.rb"
require "./lib/matrices.rb"
require "./lib/matrices_dispersa.rb"

class Matriz_densa < Matriz
  attr_reader :fil, :col, :mat
  
  def initialize (m,n) #Estructura de datos de la matriz densa
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    super
    @mat = Array.new(@fil) {Array.new(@col)}
  end
  
  def to_s #Metodo para mostrar una matriz densa
    out_string = ""
    for i in (0...self.fil)
      out_string << "("
#       print "("
      for j in (0...self.col)
	out_string << " #{self.mat[i][j]}\t"
# 	print " #{self.mat[i][j]}\t"
      end
      out_string << ")\n"
#       puts ")\n"
    end
    out_string << "\n"
    out_string
#     puts "\n"
  end
  
  def generar (o) #Segun la opcion elegida (1 o 2) crear la matriz densa con valores aleatorios (1)enteros o (2)racionales
    if (o==1)
      @mat = Array.new(@fil) {Array.new(@col) {rand(-10..10)}}
    elsif (o==2)
      for i in (0...self.fil)
	for j in (0...self.col)
	  self.mat[i][j]=NumerosRacionales.new(rand(-10..10),rand(1..10))
	end
      end
    end
  end
  
  def llenar (other) #Recoge por parametro el array que formara la nueva matriz
    if other.is_a?(Array)
      for i in (0...self.fil)
	for j in (0...self.col)
	  self.mat[i][j] = other[i][j]
	end
      end
    end
  end
  
  def introducir_datos (o) #El usuario puede elegir los tipos de datos (1.enteros y 2.racionales) y datos que contendra la matriz
    puts "Rellene la matriz..."
    if (o==1)
      for i in (0...self.fil)
	for j in (0...self.col)
	  puts "casilla (#{i},#{j}): "
	  STDOUT.flush
	  dato=gets.chomp
	  self.mat[i][j]= dato.to_i
	end
      end      
    elsif
      for i in (0...self.fil)
	for j in (0...self.col)
	  puts "casilla (#{i},#{j}): "
	  puts "numerador: "
	  STDOUT.flush
	  num=gets.chomp
	  puts "denominador: "
	  STDOUT.flush
	  den=gets.chomp
	  self.mat[i][j]=NumerosRacionales.new(num.to_i,den.to_i)
	end
      end
    end
  end
  
  def coerce (other) #Metodo para hacer la conversion de datos para poder operar con la clase matriz densa
    if (other.is_a?(Matriz_dispersa))
      a=Matriz_densa.new(other.fil,other.col)
      for i in (0...a.fil)
	for j in (0...a.col)
	  a.mat[i][j]=0
	end
      end
      for i in (0...other.pos.size)
	a.mat[other.pos[i][0]][other.pos[i][1]]= other.dato[i]
      end
      return [a,self]
    end
  end
  
  def t #Calcula la traspuesta de una matriz
    nueva = Matriz_densa.new(self.col,self.fil)
    for i in (0...nueva.fil)
      for j in (0...nueva.col)
	nueva.mat[i][j] = self.mat[j][i]
      end
    end
    nueva
  end
  
  def ==(other) #Compara si dos matrices son iguales o no
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      for i in (0...other.fil)
	for j in (0...other.col)
	  if self.mat[i][j] != other.mat[i][j]
	    return false
	  end
	end
      end
      true
    end #if
  end
  
  def +(other) #Devuelve la suma de dos matrices
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      nueva = Matriz_densa.new(self.fil,self.col)
      @fil.times do |i|		# 0.upto(@fil-1) do |i|		# for i in (0...self.fil)
	@col.times do |j|	# 0.upto(@col-1) do |j|		# for j in (0...self.col)
	  nueva.mat[i][j]= self.mat[i][j] + other.mat[i][j]
	end
      end
      nueva
    else
      puts "Error. No se pueden sumar matrices de distintas dimensiones."
    end
  end

  def -(other) #Devuelve la resta de dos matrices
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      nueva = Matriz_densa.new(self.fil,self.col)
      @fil.times do |i|		# 0.upto(@fil-1) do |i| 	# for i in (0...self.fil)
	@col.times do |j|	# 0.upto(@col-1) do |j|		# for j in (0...self.col)
	  nueva.mat[i][j] = self.mat[i][j] - other.mat[i][j]
	end
      end
      nueva
    else
      puts "Error. No se pueden restar matrices de distintas dimensiones."
    end
  end


  def *(other) #Multiplicacion: realiza el producto escalar o por otra matriz segun la clase de other
    if other.is_a?(Numeric)
      nueva = Matriz_densa.new(self.fil,self.col)
      if (self.mat[0][0]).is_a?(NumerosRacionales)
	n=NumerosRacionales.new(other,1)
      else
	n=other
      end
      @fil.times do |i|		# 0.upto(@fil-1) do |i|		# for i in (0...self.fil)
	@col.times do |j|	# 0.upto(@col-1) do |j|		# for j in (0...self.col)
	  nueva.mat[i][j] = n*self.mat[i][j]
	end
      end
      nueva
    elsif other.is_a?(Matriz)
      if (self.col == other.fil)
	if (other.is_a?(Matriz_dispersa))
	  other=self.coerce(other)
	  other=other[0]
	end
	nueva = Matriz_densa.new(self.fil,other.col)
	@fil.times do |i| 	# for i in (0...self.fil)
	  @col.times do |j|	# for j in (0...other.col)
	    if (self.mat[0][0]).is_a?(NumerosRacionales)
	      nueva.mat[i][j] = NumerosRacionales.new(0,1)
	    else
	      nueva.mat[i][j] = 0
	    end
	    @col.times do |k| 	# for k in (0...self.col)
	      nueva.mat[i][j] += self.mat[i][k]*other.mat[k][j]
	    end
	  end
	end
	nueva
      else
	puts "Error. No se pueden multiplicar estas matrices. La col de la M1 debe coincidir con la fil de M2"
      end
    end
  end
  
  def max #Devuelve el elemento mayor de la matriz
    r=-9999999
    @mat.each do |i|
      i.each do |j|
	if (j.to_f > r.to_f)
	  r = j
	end
      end
    end
    r
  end

  def min
    r= 9999999 #Devuelve el elemento menor de la matriz
    @mat.each do |i|
      i.each do |j|
	if (j.to_f < r.to_f)
	  r = j
	end
      end
    end
    r
  end
  
  def encontrar
    @fil.times do |i|
      @col.times do |j|
	valor=mat[i][j]
	if yield(valor)
	  return i,j
	end
      end
    end
    return nil #No supera el numero
  end
  
end