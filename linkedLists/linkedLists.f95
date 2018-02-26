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
    subroutine ndfree(list)
      type(Node), pointer :: list, temp
      do while (associated(list))
        temp => list%next
        deallocate(list)
        list => temp
      end do
    end subroutine ndfree
end module LinkedLists
