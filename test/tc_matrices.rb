require "./lib/matrices/version"
# require "./lib/matrices.rb"
require "./lib/matrices_densa.rb"
require "./lib/matrices_dispersa.rb"
require "test/unit"

class Test_Matriz < Test::Unit::TestCase
  
  def setup
    @m1=Matriz_densa.new(2,2)
    @m1.llenar([[1,2],[2,3]])
    @m2=Matriz_densa.new(2,2)
    @m2.llenar([[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)]])
    @m3=Matriz_dispersa.new(2,2)
    @m3.llenar([[0,1]],[-1])
    @m4=Matriz_dispersa.new(2,2)
    @m4.llenar([[1,1]],[NumerosRacionales.new(1, 2)])
  end
     
  def teardown
  end
  
  def test_typecheck        #En caso de que las dimensiones sean negativas
    assert_raise( TypeError ) {Matriz_densa.new(-2,2)}
    assert_raise( TypeError ) {Matriz_dispersa.new(2,-2)}
    assert_equal(true, @m3.is_a?(Matriz_dispersa))
    assert_kind_of(Matriz_densa,@m1)
  end
  
  def test_datacheck
    assert_equal(@m1.fil,2)
    assert_equal(@m1.col,2)
    assert_equal(@m3.fil,2)
    assert_equal(@m3.col,2)
  end
  
  def test_operations
    assert_equal(@m2.max,NumerosRacionales.new(1, 1))
    assert_equal(@m2.min,NumerosRacionales.new(1, 1))
    assert_equal(@m3.max,0)
    assert_equal(@m3.min,-1)
    @mr=Matriz_densa.new(2,2)
    @mr.llenar([[1,1],[2,3]])
    assert_equal(@mr,@m1+@m3)
    @mr.llenar([[1,3],[2,3]])
    assert_equal(@mr,@m1-@m3)
    @mr.llenar([[NumerosRacionales.new(3, 1),NumerosRacionales.new(3, 1)],[NumerosRacionales.new(3, 1),NumerosRacionales.new(3, 1)]])
    assert_equal(@mr,(@m2*3))
  end
   
end