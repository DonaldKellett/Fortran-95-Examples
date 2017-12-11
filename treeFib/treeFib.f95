module TreeFib
  implicit none
  contains
    ! NOTE: Computing the fibonacci sequence using
    ! tree recursion is extremely slow - do NOT
    ! use it in production-level code ;)
    recursive function fibonacci(n) result(retval)
      implicit none
      integer :: n, retval
      if (n == 0 .or. n == 1) then
        retval = n
      else
        retval = fibonacci(n - 1) + fibonacci(n - 2)
      end if
    end function fibonacci
end module TreeFib
