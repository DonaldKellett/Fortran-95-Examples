module Greetings
  implicit none
  contains
    function greet(name) result(greeting)
      implicit none
      character(len=*) :: name
      character(:), allocatable :: greeting
      greeting = "Hello, " // name // "!"
    end function greet
end module Greetings
