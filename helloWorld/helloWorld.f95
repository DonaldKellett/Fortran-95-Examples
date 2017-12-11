module HelloWorld
  implicit none
  contains
    ! A function which simply returns the string "Hello World!"
    ! (i.e. does NOT print anything to the screen directly)
    ! To print "Hello World!", use this module and do
    ! print *, sayHello()
    function sayHello() result (hello)
      implicit none
      character(len=12) :: hello
      hello = "Hello World!"
    end function sayHello
end module HelloWorld
