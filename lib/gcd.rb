def gcd(u,v)	#Calcula el maximo comun divisor entre dos numeros
  u, v = u.abs, v.abs
  while (v != 0)
    u, v = v, u % v
  end
  u
end

def mcm (a, b)	#Calcula el minimo comun multiplo entre dos numeros
 (a*b)/gcd(a,b)
end
