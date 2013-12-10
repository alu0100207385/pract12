require "./lib/gcd.rb"

class NumerosRacionales
  attr_reader :a, :b
  
  def initialize (a, b) # Crea un numero racional con numerador a y denominador b
    raise ZeroDivisionError, "Denominador igual a cero" if (b==0)
    if (a<0) and (b<0) #si los dos son negativos => nos queda positivo
      a,b= -a,-b
    end
    simplifica = gcd(a,b)
    @a,@b = a/simplifica,b/simplifica
  end
  
  def num() # Devuelve el valor del numerador
    @a
  end

  def denom()# Devuelve el valor del denominador
    @b
  end
  
  def to_s # Muestra por pantalla el racional
    if (@a == 0) #numerador = 0, racional = 0. El denominador lo controlamos en el constructor
      "0"
    elsif (@b==1)
      "#{@a}"
    else
      "#{@a}/#{@b}"
    end
  end
  
  def to_f # Pasa a flotante un numero racional
    tmp=@a.to_f/@b.to_f
    return tmp
  end
  
  
  def simplificar # Simplifica el numero racional
    simplifica = gcd(@a,@b)
    NumerosRacionales.new(@a/simplifica,@b/simplifica)
  end
  
  def +(other) # Calcula la suma de racionales o racionales con enteros
    if (other.is_a?(Integer))
#       other=self.coerce(other)
      other=NumerosRacionales.new(other,1)
    end
    deno = mcm(@b, other.b)			#MCM para hallar el denominador
    num = ((deno/@b) * @a) + ((deno/other.b) * other.a)
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end

  def -(other)	# Calcula la resta de racionales o racionales con enteros
    if (other.is_a?(Numeric))
      other=self.coerce(other)
      other=other[0]
    end
    deno = mcm(@b, other.b)			#MCM para hallar el denominador
    num = ((deno/@b) * @a) - ((deno/other.b) * other.a)
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end
  
  def *(other)	# Calcula la multiplicaciones de dos racionales
    if (other.is_a?(Numeric))
      other=self.coerce(other)
      other=other[0]
    end
    num = @a*other.a
    deno = @b*other.b
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end
  
   def /(other) # Calcula la division de dos racionales
     num = @a*other.b
     deno = @b*other.a
     simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
     NumerosRacionales.new(num/simplifica,deno/simplifica)
   end
   
   def %(other) # Halla el modulo de una fraccion
     tmp = (self/other).abs
     t = NumerosRacionales.new(1,1)
     tmp= t-tmp
     NumerosRacionales.new(tmp.num, tmp.denom)
   end
   
   def coerce(other) # Hace una conversion de enteros a racionales
     if (other.is_a?(Integer))
       [NumerosRacionales.new(other.to_i,1),self]
     end
   end
   
   def ==(other) # Compara si dos numeros racionales son iguales
     if (self.to_f == other.to_f)
       true
     else
       false
     end
   end
   
  def <(other) # Compara si un numero racional es menor que otro
    if (self.to_f < other.to_f)
      true
    else
      false
    end
  end

  def <=(other) # Compara si un numero racional es menor o igual que otro
    if (self.to_f <= other.to_f)
      true
    else
      false
    end
  end  
  
  def >(other) # Compara si un numero racional es mayor que otro
    if (self.to_f > other.to_f)
      true
    else
      false
    end
  end

  def >=(other) # Compara si un numero racional es mayor o igual que otro
    if (self.to_f >= other.to_f)
      true
    else
      false
    end
  end
  
   def <=>(other) # Compara si un numero racional distinto otro
     self.to_f <=> other.to_f
   end
  
   def abs # Calcula el valor absoluto de un racional
     n, d = @a.abs, @b.abs
     NumerosRacionales.new(n,d)
   end
   
   def reciprocal # Calcula el inverso de un racional
     inv = NumerosRacionales.new(1,1)
     tmp = inv/self
     NumerosRacionales.new(tmp.num,tmp.denom)
   end
   
   def -@ # Calcula el opuesto de un racional
       NumerosRacionales.new(-self.num,self.denom)
   end
   
end
