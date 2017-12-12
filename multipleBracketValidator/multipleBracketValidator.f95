module MultipleBracketValidator
  implicit none
  contains
    function validBrackets(s)
      implicit none
      character(len=*) :: s
      logical :: validBrackets
      character, dimension(:), allocatable :: stack, temp
      integer :: i
      allocate(stack(0))
      myLoop: do i = 1, len(s)
        select case (s(i:i))
          case ('(')
            allocate(temp(size(stack) + 1))
            temp = stack
            deallocate(stack)
            temp(size(temp)) = s(i:i)
            allocate(stack(size(temp)))
            stack = temp
            deallocate(temp)
          case ('[')
            allocate(temp(size(stack) + 1))
            temp = stack
            deallocate(stack)
            temp(size(temp)) = s(i:i)
            allocate(stack(size(temp)))
            stack = temp
            deallocate(temp)
          case ('{')
            allocate(temp(size(stack) + 1))
            temp = stack
            deallocate(stack)
            temp(size(temp)) = s(i:i)
            allocate(stack(size(temp)))
            stack = temp
            deallocate(temp)
          case (')')
            if (size(stack) > 0) then
              if (stack(size(stack)) == '(') then
                allocate(temp(size(stack) - 1))
                temp(1:(size(stack) - 1)) = stack(1:(size(stack) - 1))
                deallocate(stack)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              else
                allocate(temp(size(stack) + 1))
                temp = stack
                deallocate(stack)
                temp(size(temp)) = s(i:i)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              end if
            else
              allocate(temp(size(stack) + 1))
              temp = stack
              deallocate(stack)
              temp(size(temp)) = s(i:i)
              allocate(stack(size(temp)))
              stack = temp
              deallocate(temp)
            end if
          case (']')
            if (size(stack) > 0) then
              if (stack(size(stack)) == '[') then
                allocate(temp(size(stack) - 1))
                temp(1:(size(stack) - 1)) = stack(1:(size(stack) - 1))
                deallocate(stack)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              else
                allocate(temp(size(stack) + 1))
                temp = stack
                deallocate(stack)
                temp(size(temp)) = s(i:i)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              end if
            else
              allocate(temp(size(stack) + 1))
              temp = stack
              deallocate(stack)
              temp(size(temp)) = s(i:i)
              allocate(stack(size(temp)))
              stack = temp
              deallocate(temp)
            end if
          case ('}')
            if (size(stack) > 0) then
              if (stack(size(stack)) == '{') then
                allocate(temp(size(stack) - 1))
                temp(1:(size(stack) - 1)) = stack(1:(size(stack) - 1))
                deallocate(stack)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              else
                allocate(temp(size(stack) + 1))
                temp = stack
                deallocate(stack)
                temp(size(temp)) = s(i:i)
                allocate(stack(size(temp)))
                stack = temp
                deallocate(temp)
              end if
            else
              allocate(temp(size(stack) + 1))
              temp = stack
              deallocate(stack)
              temp(size(temp)) = s(i:i)
              allocate(stack(size(temp)))
              stack = temp
              deallocate(temp)
            end if
        end select
      end do myLoop
      validBrackets = size(stack) == 0
    end function validBrackets
end module MultipleBracketValidator
