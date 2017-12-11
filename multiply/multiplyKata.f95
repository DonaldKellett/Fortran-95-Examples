module MultiplyKata
  implicit none
  contains
    function multiply(a, b) result(product)
      implicit none
      integer :: a, b, product
      product = a * b
    end function multiply
end module MultiplyKata
