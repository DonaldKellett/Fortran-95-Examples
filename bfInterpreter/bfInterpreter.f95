module BFInterpreter
  implicit none
  contains
    function brainfuck(code, input) result(output)
      implicit none
      character(len=*) :: code, input
      character(:), allocatable :: output
      integer(kind=1), dimension(30000) :: tape
      integer :: ptr, i, inputCharIndex, unmatched
      output = ""
      ptr = 1
      inputCharIndex = 1
      do i = 1, 30000
        tape(i) = 0
      end do
      i = 1
      do while (i <= len(code))
        select case (code(i:i))
          case (',')
            if (inputCharIndex <= len(input)) then
              tape(ptr) = ichar(input(inputCharIndex:inputCharIndex))
            else
              tape(ptr) = 0
            end if
            inputCharIndex = inputCharIndex + 1
          case ('.')
            output = output // char(tape(ptr))
          case ('+')
            tape(ptr) = tape(ptr) + 1
          case ('-')
            tape(ptr) = tape(ptr) - 1
          case ('<')
            ptr = ptr - 1
          case ('>')
            ptr = ptr + 1
          case ('[')
            if (tape(ptr) == 0) then
              unmatched = 1
              do while (unmatched > 0)
                i = i + 1
                if (code(i:i) == '[') then
                  unmatched = unmatched + 1
                else if (code(i:i) == ']') then
                  unmatched = unmatched - 1
                end if
              end do
            end if
          case (']')
            if (tape(ptr) /= 0) then
              unmatched = 1
              do while (unmatched > 0)
                i = i - 1
                if (code(i:i) == '[') then
                  unmatched = unmatched - 1
                else if (code(i:i) == ']') then
                  unmatched = unmatched + 1
                end if
              end do
            end if
        end select
        i = i + 1
      end do
    end function brainfuck
end module BFInterpreter
