require "./lib/matrices/version"
require "./lib/matrices_densa.rb"
require "./lib/matrices_dispersa.rb"

describe Matriz do
  
  before :each do
    @m1 = Matriz_densa.new(2,2)
    @m1.llenar([[1,2],[2,3]])
    @m2 = Matriz_densa.new(2,2)
    @m2.llenar([[-1,1],[2,-5]])
    @m3 = Matriz_densa.new(2,2)
    @m3.llenar([[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)]])
    @m4 = Matriz_densa.new(2,2)
    @m4.llenar([[NumerosRacionales.new(1, 2),NumerosRacionales.new(3, 5)],[NumerosRacionales.new(11, 40),NumerosRacionales.new(49, 150)]])
    
    @m5 = Matriz_dispersa.new(2,2)
    @m5.llenar([[0,1]],[-1])
    @m6 = Matriz_dispersa.new(2,2)
    @m6.llenar([[1,0]],[5])
    @m7 = Matriz_dispersa.new(2,2)
    @m7.llenar([[1,1]],[NumerosRacionales.new(1, 2)])
    @m8 = Matriz_dispersa.new(2,2)
    @m8.llenar([[0,0]],[NumerosRacionales.new(5, 3)])
  end
  
  describe "# Definicion de argumentos: " do
    it " - Las dimensiones son correctas" do
      lambda {@m9.new(-1,1).should raise_error(TypeError)}
      lambda {@m9.new(1,-1).should raise_error(TypeError)}
      @m1.fil.should eq(2)
      @m1.col.should eq(2)
      @m5.fil.should eq(2)
      @m5.col.should eq(2)
    end
    it "- Contenido de la matriz densa" do
        @m9 = Matriz_densa.new(2,2)
	@m9.llenar([[1,2],[2,3]])
        (@m1 == @m9).should eq(true)
    end
    it "- Contenido de la matriz dispersa" do
	@m9 = Matriz_dispersa.new(2,2)
	@m9.llenar([[0,1]],[-1])
	aux= (@m5 == @m9)
        aux.should eq(true)
    end
  end
  
  describe "# Otras operaciones" do
    it "- Traspuesta de una matriz densa" do
      (@m2==@m2.t).should eq (false)
    end
    it "- Traspuesta de una matriz dispersa" do
      (@m5==@m5.t).should eq (false)
    end
    it "- Comparador de igualdad entre densas" do
       (@m1==@m1).should eq(true)
    end
    it "- Comparador de igualdad entre dispersas" do
       (@m5==@m5).should eq(true)
    end
    it "- Comparador de igualdad entre densas y dispersas" do
      	@m9 = Matriz_densa.new(2,2)
	@m9.llenar([[0,-1],[0,0]])
       (@m5==@m9).should eq(true)
    end
  end
  
  describe "# Operaciones de matrices: "do
    
    #SUMAS ENTRE MATRICES
    it "- Se pueden sumar matrices densas de enteros" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[0,3],[4,-2]])
      ((@m1+@m2) == @m9).should eq(true)
    end
    it "- Se pueden sumar matrices densas de racionales" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(3, 2),NumerosRacionales.new(8, 5)],[NumerosRacionales.new(51, 40),NumerosRacionales.new(199, 150)]])
      ((@m3+@m4) == @m9).should eq(true)
    end
    it "- Se pueden sumar matrices dispersas de enteros" do
      @m9 = Matriz_dispersa.new(2,2)
      @m9.llenar([[0,1],[1,0]],[-1,5])
      ((@m5+@m6) == @m9).should eq(true)
    end
    it "- Se pueden sumar matrices dispersas de racionales" do
      @m9 = Matriz_dispersa.new(2,2)
      @m9.llenar([[0,0],[1,1]],[NumerosRacionales.new(5, 3),NumerosRacionales.new(1, 2)])
      ((@m7+@m8) == @m9).should eq(true)
    end  
    it "- Se pueden sumar matrices de enteros entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[-1,1],[7,-5]])
      ((@m2+@m6) == @m9).should eq(true)
    end
    it "- Se pueden sumar matrices de racionales entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(8, 3),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)]])
      ((@m3+@m8) == @m9).should eq(true)
    end
    it "- Se pueden sumar matrices de enteros con racionales entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(2, 3),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(2, 1),NumerosRacionales.new(-5, 1)]])
      ((@m2+@m8) == @m9).should eq(true)
    end
    
    #RESTAS ENTRE MATRICES
    it "- Se pueden restar matrices densas de enteros" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[2,1],[0,8]])
      ((@m1-@m2) == @m9).should eq(true)
    end
    it "- Se pueden restar matrices densas de racionales" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(1, 2),NumerosRacionales.new(2, 5)],[NumerosRacionales.new(29, 40),NumerosRacionales.new(101, 150)]])
      ((@m3-@m4) == @m9).should eq(true)
    end
    it "- Se pueden restar matrices dispersas de enteros" do
      @m9 = Matriz_dispersa.new(2,2)
      @m9.llenar([[0,1],[1,0]],[-1,-5])
      ((@m5-@m6) == @m9).should eq(true)
    end
    it "- Se pueden restar matrices dispersas de racionales" do
      @m9 = Matriz_dispersa.new(2,2)
      @m9.llenar([[0,0],[1,1]],[NumerosRacionales.new(-5, 3),NumerosRacionales.new(1, 2)])
      ((@m7-@m8) == @m9).should eq(true)
    end  
    it "- Se pueden restar matrices de enteros entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[-1,1],[-3,-5]])
      ((@m2-@m6) == @m9).should eq(true)
    end
    it "- Se pueden restar matrices de racionales entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(-2, 3),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)]])
      ((@m3-@m8) == @m9).should eq(true)
    end
    it "- Se pueden restar matrices de enteros con racionales entre las distintas clases" do
      @m9 = Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(-8, 3),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(2, 1),NumerosRacionales.new(-5, 1)]])
      ((@m2-@m8) == @m9).should eq(true)
    end
    
    #PRODUCTO ESCALAR DE MATRICES
    it "- Producto escalar de densas con enteros" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[-2,2],[4,-10]])
      ((@m2*2)==@m9).should eq(true)
    end
    it "- Producto escalar de densas con racionales" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(4, 1),NumerosRacionales.new(4, 1)],[NumerosRacionales.new(4, 1),NumerosRacionales.new(4, 1)]])
      ((@m3*4)==@m9).should eq(true)
    end
    it "- Producto escalar de dispersas con enteros" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[0,1]],[-2])
      ((@m5*2)==@m9).should eq(true)
    end
    it "- Producto escalar de dispersas con racionales" do
       @m9=Matriz_dispersa.new(2,2)
       @m9.llenar([[0,0]],[NumerosRacionales.new(20,3)])
       ((@m8*4)==@m9).should eq(true)
    end

    
    #PRODUCTOS ENTRE MATRICES
    it "- Producto de matrices densas con enteros" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[3,-9],[4,-13]])
      ((@m1*@m2)==@m9).should eq(true)
    end
    it "- Producto de matrices densas con racionales" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[NumerosRacionales.new(31,40),NumerosRacionales.new(139,150)],[NumerosRacionales.new(31,40),NumerosRacionales.new(139,150)]])
      ((@m3*@m4)==@m9).should eq(true)
    end
    it "- Producto de matrices dispersas con enteros" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[0,0]],[-5])
      ((@m5*@m6)==@m9).should eq(true)
    end
    it "- Producto de matrices dispersas con racionales" do
      @m9=Matriz_dispersa.new(2,2)
      ((@m7*@m8)==@m9).should eq(true)
    end
    it "- Producto de matriz densa de enteros por matriz dispersa de enteros" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[0,-1],[0,-2]])
      ((@m1*@m5)==@m9).should eq(true)
    end
    it "- Producto de matriz densa de enteros por matriz dispersa de racionales" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[0,1],[0,NumerosRacionales.new(3,2)]])
      ((@m1*@m7)==@m9).should eq(true)
    end
    it "- Producto de matriz densa de racionales por matriz dispersa de enteros" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[3,0],[NumerosRacionales.new(49,30),0]])
      ((@m4*@m6)==@m9).should eq(true)
    end
    it "- Producto de matriz densa de racionales por matriz dispersa de enteros" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[3,0],[NumerosRacionales.new(49,30),0]])
      ((@m4*@m6)==@m9).should eq(true)
    end
    it "- Producto de matriz densa de racionales por matriz dispersa de racionales" do
      @m9=Matriz_densa.new(2,2)
      @m9.llenar([[0,NumerosRacionales.new(3,10)],[0,NumerosRacionales.new(49,300)]])
      ((@m4*@m7)==@m9).should eq(true)
    end
    it "- Producto de matriz dispersa de enteros por matriz densa de enteros" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[1,0],[1,1]],[-5,5])
      ((@m6*@m2)==@m9).should eq(true)
    end    
    it "- Producto de matriz dispersa de enteros por matriz densa de racionales" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[1,0],[1,1]],[NumerosRacionales.new(5,2),NumerosRacionales.new(3,1)])
      ((@m6*@m4)==@m9).should eq(true)
    end
    it "- Producto de matriz dispersa de racionales por matriz densa de enteros" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[0,0],[0,1]],[NumerosRacionales.new(5,3),NumerosRacionales.new(10,3)])
      ((@m8*@m1)==@m9).should eq(true)
    end
    it "- Producto de matriz dispersa de racionales por matriz densa de racionales" do
      @m9=Matriz_dispersa.new(2,2)
      @m9.llenar([[0,0],[0,1]],[NumerosRacionales.new(5,6),NumerosRacionales.new(1,1)])
      ((@m8*@m4)==@m9).should eq(true)
    end

    
    #CALCULO DE LOS ELEMENTOS MAX Y MIN
    it "- Maximo de densas con enteros" do
      (@m2.max==2).should eq(true)
    end
    it "- Maximo de densas con racionales" do
      (@m3.max==NumerosRacionales.new(1,1)).should eq(true)
    end
    it "- Minimo de densas con enteros" do
      (@m2.min==-5).should eq(true)
    end
    it "- Minimo de densas con racionales" do
      (@m3.min==NumerosRacionales.new(1,1)).should eq(true)
    end
    
    it "- Maximo de dispersas con enteros" do
      (@m5.max==0).should eq(true)
    end
    it "- Maximo de dispersas con racionales" do
      (@m8.max==NumerosRacionales.new(5,3)).should eq(true)
    end
    it "- Minimo de dispersas con enteros" do
      (@m5.min==-1).should eq(true)
    end
    it "- Minimo de dispersas con racionales" do
      (@m8.min==NumerosRacionales.new(0,1)).should eq(true)
    end
    
  end
  
  describe "# Modificaciones en el laboratorio: "do
    it "- Implementamos la funcion encontrar (usando yield)" do
      @m9=Matriz_densa.new(3,3)
      @m9.llenar([[1,2,3],[4,5,6],[7,8,9]])
      (@m9.encontrar{|e| e*e>=16}).should eq([1,0])
    end
  end
  
end