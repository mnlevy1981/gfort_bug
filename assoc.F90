Program assoc

  type :: test_type
    integer :: a
    integer :: b
    integer :: c
  end type test_type

  type(test_type) :: mat_type(3)
  integer, dimension(3,3) :: mat
  integer :: i, j

  do j=1,3
    mat_type(j)%a = j-1
    mat_type(j)%b = 10 + j-1
    mat_type(j)%c = 20 + j-1

    do i=1,3
      mat(i,j) = 10*(i-1) + j-1
    end do
  end do

  ! (1) basic version of bug
  associate(col => mat(1,:))
    print*, 'print a column of a matrix'
    print*, mat(1,:)
    print*, 'pass associated column to function expecting dimension(:)'
    call print_vec_colon(col)
    print*, 'pass associated column to function expecting dimension(3)'
    call print_vec_num(col)
  end associate

  associate(col => mat_type(:)%a)
    print*, 'print an array of derived-type elements'
    print*, mat_type(:)%a
    print*, 'pass associated column to function expecting dimension(:)'
    call print_vec_colon(col)
    print*, 'pass associated column to function expecting dimension(3)'
    call print_vec_num(col)
  end associate

  ! (2) Attempting to mimic the problem in MARBL

contains

  subroutine print_vec_colon(vec)

    integer :: vec(:)

    print*, vec

  end subroutine

  subroutine print_vec_num(vec)

    integer :: vec(3)

    print*, vec

  end subroutine

end Program assoc
