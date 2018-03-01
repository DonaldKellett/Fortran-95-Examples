# LinkedLists

A module containing a minimal implementation of linked lists (through the custom-defined type `Node`) and its utility functions.

## Type Synopsis

The `Node` type defines a primitive linked list of 32-bit integers (`integer(kind=4)`) (*or the default integer type as specified by your operating system / GNU Fortran compiler*).  For simplicity and ease of usage, linked lists defined in this module are **not** wrapped in a wrapper type (such as `List`).

```fortran
! Fields (and their types) in the Node type
integer :: data
type(Node), pointer :: next ! Can be null()
```

## Utility Functions

### nd(data)

```fortran
type(Node), pointer :: nd(integer :: data)
```

A "constructor" for the `Node` type which accepts an integer `data` and creates a new `Node` with the specified `data` value and a tail of `null()`.  This "constructor" function allocates memory **dynamically** - you should free the list created using repeated applications of `deallocate()` *or* make a call to `ndfree()` with the top-level node once you have finished using the list.

Examples:

```fortran
nd(3) ! => 3 -> null()
nd(10) ! => 10 -> null()
nd(0) ! => 0 -> null()
```

### nd(data, next)

```fortran
type(Node), pointer :: nd(integer :: data, type(Node), pointer :: next)
```

A "constructor" for the `Node` type which accepts an integer `data` and a list `next` and constructs a new `Node` with the specified `data` as its head and `next` as its tail.  Again, this constructor **dynamically** allocates its memory so beware of memory leaks (calling `ndfree()` after you've used the list is a good idea)!

Examples:

```fortran
nd(3, null()) ! => 3 -> null() [Same as calling `nd(3)`]
nd(1, nd(2, nd(3, null()))) ! => 1 -> 2 -> 3 -> null()
nd(1, nd(2, nd(3))) ! => 1 -> 2 -> 3 -> null()
```

### ndinsert(list, item, index)

```fortran
call ndinsert(type(Node), pointer :: list, integer :: item, index)
```

Modifies the `list` passed in by inserting the integer `item` at the specified `index`.  **This subroutine does not validate its arguments (e.g. it may attempt to insert a node at a nonzero index of an empty list) - use with care!**

Example:

```fortran
type(Node), pointer :: myList
myList => nd(1, nd(2, nd(3))) ! => 1 -> 2 -> 3 -> null()
call ndinsert(myList, 8, 1) ! => 1 -> 8 -> 2 -> 3 -> null()
call ndinsert(myList, 11, 4) ! => 1 -> 8 -> 2 -> 3 -> 11 -> null()
call ndinsert(myList, 13, 0) ! => 13 -> 1 -> 8 -> 2 -> 3 -> 11 -> null()
call ndinsert(myList, 0, 7) ! => List index out of range - is likely to cause a program crash
```

### ndremove(list, index)

```fortran
call ndremove(type(Node), pointer :: list, integer :: index)
```

Modifies the `list` passed in by removing the node at the specified `index`.  Note that the behavior of this subroutine is undefined if an out-of-range (or invalid) index is provided.  This subroutine also frees the memory previously allocated to the node removed.  Example:

```fortran
type(Node), pointer :: myList
myList => nd(1, nd(2, nd(3))) ! 1 -> 2 -> 3 -> null()
call ndremove(myList, 1) ! Removes the node located at position 1 (0-indexed)
print *, ndtoa(myList) ! > 1 -> 3 -> null()
call ndfree(myList) ! Don't forget to free the memory allocated to the list afterwards ;)
```

### ndreverse(list)

```fortran
call ndreverse(type(Node), pointer :: list)
```

Reverses the order of the nodes themselves of the `list` provided in place.  If the length of the linked list is `1` or `0` (`null()`) then the list remains unaffected.

Example:

```fortran
type(Node), pointer :: myList
myList => nd(3, nd(2, nd(1)))
print *, ndtoa(myList) ! > 3 -> 2 -> 1 -> null()
call ndreverse(myList)
print *, ndtoa(myList) ! > 1 -> 2 -> 3 -> null()
call ndfree(myList)
```

### len(list)

```fortran
integer :: len(type(Node), pointer :: list)
```

The `len` intrinsic function is overloaded for computing the length/size of a linked list in this module (`LinkedLists`).  The length of a linked list is defined as the number of (non-null) nodes that it contains.  For example:

```fortran
print "(I0)", len(nd(1, nd(2, nd(5)))) ! > 3
```

### ndtoa(list)

```fortran
character(:), allocatable :: ndtoa(type(Node), pointer :: list)
```

Returns a simple, human-readable string representation of the `list` passed in.  The returned string does not contain any leading and/or trailing whitespace.  Example:

```fortran
print *, ndtoa(nd(1, nd(2, nd(3)))) ! > "1 -> 2 -> 3 -> null()"
! Note: if you print the string with the default option * as in the example above, the linked list may be displayed with leading and/or trailing whitespace (due to how Fortran works).
```

### atond(strrep)

```fortran
type(Node), pointer :: atond(character(len=*) :: strrep)
```

Parses a string representation of a linked list `strrep` and returns the corresponding linked list constructed from the `nd()` constructor.  This function allocates memory dynamically (except when it is `null()`) so make sure to call `ndfree()` on the resulting linked list once you have finished using it.  This function assumes that `strrep` is a valid string representation of a linke list - attempts to pass in strings with an invalid format will result in undefined behavior.  A valid representation of a linked list has the format `a0 -> a1 -> a2 -> ... -> an -> null()` where `a0` through `an` are string representations of valid (default) integers, be it positive, zero or negative.

Example:

```fortran
type(Node), pointer :: myList
myList => atond("1 -> 2 -> 3 -> null()") ! => 1 -> 2 -> 3 -> null()
print *, ndtoa(myList) ! > "1 -> 2 -> 3 -> null()"
call ndfree(myList)
```

### ndfree(list)

```fortran
call ndfree(type(Node), pointer :: list)
```

Frees **all** memory allocated to the `list` passed in (including all subsequent child nodes) and *nullifies* the `list` pointer.  E.g.

```fortran
type(Node), pointer :: myList
myList => nd(1, nd(2, nd(3))) ! => 1 -> 2 -> 3 -> null()
call ndfree(myList) ! Free all memory allocated to myList
associated(myList) ! => .false.
```
