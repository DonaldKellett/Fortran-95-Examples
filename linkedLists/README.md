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
