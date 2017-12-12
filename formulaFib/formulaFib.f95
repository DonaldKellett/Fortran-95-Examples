module FormulaFib
  implicit none
  real(kind=8), parameter, private :: phi = 1.618033988749894848204586834365638117720309179805762862135D0
  contains
    ! NOTE: Only works for small `n` (upto and including n = 46);
    ! otherwise, interger overflow occurs
    function fibonacci(n) result(retval)
      implicit none
      integer :: n, retval
      retval = nint((phi ** n - (-phi) ** -n) / (2 * phi - 1))
    end function fibonacci
end module FormulaFib
