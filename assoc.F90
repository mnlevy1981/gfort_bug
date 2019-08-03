Program assoc

  real, dimension(3,3) :: mat
  integer :: i, j

  do j=1,3
    do i=1,3
      mat(i,j) = real(10*i + j)
    end do
  end do

  associate(col => mat(2,:), row => mat(:,2))
    call print_vec(mat(2,:))
    call print_vec(col)
    print*, '----'
    call print_vec(mat(:,2))
    call print_vec(row)
  end associate

contains

  subroutine print_vec(vec)

    real :: vec(3)

    print*, vec

  end subroutine

end Program assoc
