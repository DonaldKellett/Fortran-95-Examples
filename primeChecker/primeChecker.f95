module PrimeChecker
  implicit none
  contains
    function isPrime(n)
      implicit none
      integer :: n, i
      logical :: isPrime
      if (n <= 2) then
        isPrime = n == 2
      else if (modulo(n, 2) == 0) then
        isPrime = .false.
      else
        isPrime = .true.
        do i = 3, floor(sqrt(real(n))), 2
          if (modulo(n, i) == 0) then
            isPrime = .false.
          end if
        end do
      end if
    end function isPrime
end module PrimeChecker
