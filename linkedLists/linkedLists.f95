module LinkedLists
  implicit none
  private :: ndWithData, ndWithDataAndNext
  type Node
    integer :: data
    type(Node), pointer :: next
  end type Node
  interface nd
    module procedure ndWithData, ndWithDataAndNext
  end interface nd
  contains
    function ndWithData(data) result(list)
      integer :: data
      type(Node), pointer :: list
      allocate(list)
      list%data = data
      list%next => null()
    end function ndWithData
    function ndWithDataAndNext(data, next) result(list)
      integer :: data
      type(Node), pointer :: next, list
      allocate(list)
      list%data = data
      list%next => next
    end function ndWithDataAndNext
    recursive subroutine ndinsert(list, item, index)
      type(Node), pointer :: list, temp
      integer :: item, index
      if (index == 0) then
        allocate(temp)
        temp%data = item
        temp%next => list
        list => temp
      else
        call ndinsert(list%next, item, index - 1)
      end if
    end subroutine ndinsert
    recursive subroutine ndremove(list, index)
      type(Node), pointer :: list, temp
      integer :: index
      if (index == 0) then
        temp => list%next
        deallocate(list)
        list => temp
      else
        call ndremove(list%next, index - 1)
      end if
    end subroutine ndremove
    recursive function ndtoa(list) result(strrep)
      type(Node), pointer :: list
      character(:), allocatable :: strrep, tailrep
      character(len=11) :: itoa
      if (associated(list)) then
        tailrep = ndtoa(list%next)
        write(itoa, "(I0)") list%data
        strrep = trim(itoa) // " -> " // tailrep
      else
        strrep = "null()"
      end if
    end function ndtoa
    subroutine ndfree(list)
      type(Node), pointer :: list, temp
      do while (associated(list))
        temp => list%next
        deallocate(list)
        list => temp
      end do
    end subroutine ndfree
end module LinkedLists
