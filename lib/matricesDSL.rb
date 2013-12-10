require "./lib/matrices/version"
require './lib/matrices_densa.rb'
require './lib/matrices_dispersa.rb'

class MatrizDSL < Matriz
    attr_reader :operacion, :salida, :tipo_m1, :tipo_m2, :m1, :m2, :mr #densa o dispersa
    
    def initialize (operador, &block) #Estructura de datos de la matriz DSL
      @operacion = operador.downcase
      @tipo_m1,@tipo_m2 = nil,nil
      @salida = "console" #la salida puede ser por fichero o por consola, esta opcion se ejecuta por defecto
#       yield self 		# Para la version 2
#       instance_eval &block	# Para la version 3
      
      if block_given?  		# Para la version 3 y 4
	if block.arity == 1
	  yield self
	else
	  instance_eval &block 
	end
      end
    end 

    def option(cadena) #Recoge la opcion de tipo de matriz
      case cadena.downcase
      when "densas"
	  @tipo_m1,@tipo_m2 = "densa","densa"
      when "dispersas"
	  @tipo_m1,@tipo_m2 = "dispersa","dispersa"
      when "fix","fich","fichero"
	  @salida = "fichero"
      end
      if (@tipo_m1==nil)
	if cadena=="densa"
	  @tipo_m1 = "densa"
	else
	    @tipo_m1 = "dispersa"
	end
      end
      if (@tipo_m2==nil)
	if cadena=="densa"
	  @tipo_m2 = "densa"
	else
	  @tipo_m2 = "dispersa"
	end
      end
    end
    
    def to_s # Muestra por pantalla el valor del objeto
      out_string = "";
      control=0
      out_string << @m1.to_s
      case @operacion
	when "suma","sum"
	  out_string << "+\n"
	when "resta","res"
	  out_string << "-\n"
	when "producto","multiplicacion","multi"
	  out_string << "*\n"
	when "traspuesta","tras"
	  out_string << "traspuesta\n"
	  control=1
	when "maximo","max"
	  out_string << "elemento max\n"
	  control=1
	when "minimo","min"
	  out_string << "elemento min\n"
	  control=1
      end
      if control==0
	out_string << @m2.to_s
      end
      out_string << "=\n"
      out_string << @mr.to_s
      out_string
    end
    
   
    def operand(contenido) #construye una matriz a partir del array que recoge por parámetro
      if (@m1.is_a?(Matriz_densa) or @m1.is_a?(Matriz_dispersa)) == false
	if @tipo_m1=="densa"
	  @m1= Matriz_densa.new(contenido.size,contenido[0].size)
	  @m1.llenar(contenido)
	else
	  @m1= Matriz_dispersa.new(contenido.size,contenido[0].size)
	  @m1.llenar(contenido)
	end
      else
	if @tipo_m2=="densa"
	  @m2= Matriz_densa.new(contenido.size,contenido[0].size)
	  @m2.llenar(contenido)
	else
	  @m2= Matriz_dispersa.new(contenido.size,contenido[0].size)
	  @m2.llenar(contenido)
	end
      end
    end
    
    def operar # Realiza la operacion
      case @operacion.downcase
	when "suma","sum"
	  @mr=@m1+@m2
	when "resta","res"
	  @mr=@m1-@m2
	when "producto","multiplicacion","multi"
	  @mr=@m1*@m2
	when "traspuesta","tras"
	  @mr=@m1.t
	when "maximo","max"
	  @mr=@m1.max
	when "minimo","min"
	  @mr=@m1.min
	else #error
	  nil
	end #case
	if @salida == "fichero"
	  mats=[@m1,@m2,@mr]
	  mats.each do |i|
	    crear_fichero(i)
	  end
	  puts "Fichero <salida.txt> creado"
	end
    end
      
    def fraccion (num,den) # Siguiendo la forma de programar DSL, renombramos esta funcion para que sea mas facil e intuintiva al programador
      NumerosRacionales.new(num,den)
    end
    
    def crear_fichero (matriz)# Crea un nuevo fichero, y escribe
      if File.exist?("salida.txt")==false
	File.open('salida.txt', 'w')
      end
      File.open('salida.txt', 'r+') do |f|
	while f.eof == false
# 	    f.readline
	    f.gets
	end
	if matriz.is_a?(Fixnum)
	  f.print "#{matriz}\n"
	else
	  f.print "["
	  for i in (0...matriz.fil)
	    f.print "["
	    for j in (0...matriz.col)
	      f.print "#{matriz.mat[i][j]}"
	      if j!=(matriz.col-1)
		f.print ","
	      end
	    end
	    f.print "]"
	  end
	  f.print "]\n"
	end
      end
    end

end


# version 3,4: Estas son las mejores versiones, pues se elimina la redundancia y hace un codigo mas entendible y facil de usar
# -----------
ejemplo = MatrizDSL.new("max") do
  option "Densas"
  option "fichero"
#   operand [[1,2,3],[4,5,6],[7,8,9]]
  operand [[1,fraccion(2,3),3],[4,5,6],[7,8,9]]
  operand [[1,1,1],[1,1,1],[1,1,1]]
  operar
end

# version 2: Mejoramos la version 1, usando iteradores, pero esto aun puede ser mejorado.
# ---------
# ejemplo = MatrizDSL.new("sum") do |i|
#   i.option "Densas"
#   i.option "console"
# #   i.option "fich"
#   i.operand [[1,2,3],[4,5,6],[7,8,9]]
# #   i.operand [[1,i.fraccion(2,3),3],[4,5,6],[7,8,9]]
#   i.operand [[1,1,1],[1,1,1],[1,1,1]]
#   i.operar
# end
  

# version 1: la forma habitual, puede hacerse redundante. Hasta ahora hemos programado de esta forma.
# ---------
# ejemplo = MatrizDSL.new("sum")
# ejemplo.option "Densas"
# # ejemplo.option "fich"
# # ejemplo.operand [[1,ejemplo.fraccion(2,3),3],[4,5,6],[7,8,9]]
# ejemplo.operand [[1,1,1],[1,1,1],[1,1,1]]
# ejemplo.operar

puts ejemplo
