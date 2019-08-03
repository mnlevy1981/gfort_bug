Program assoc

  real, dimension(3,3) :: mat
  integer :: i, j

  do j=1,3
    do i=1,3
      mat(i,j) = real(10*(i-1) + j-1)
    end do
  end do

  associate(col => mat(1,:))
    print*, mat(1,:)
    call print_vec_colon(col)
    call print_vec_num(col)
  end associate

contains

  subroutine print_vec_colon(vec)

    real :: vec(:)

    print*, vec

  end subroutine

  subroutine print_vec_num(vec)

    real :: vec(3)

    print*, vec

  end subroutine

end Program assoc
