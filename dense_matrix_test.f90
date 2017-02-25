#include "scalar.fpp"
!=====================================================================!
! Module to test the dense matrix implementations
!=====================================================================!

module dense_matrix_test

  use, intrinsic :: iso_fortran_env, only : WP => REAL64
  use dense_matrix_interface
  
contains

  subroutine test_dense_matrix(nrows, ncols)

    type(integer)      :: nrows
    type(integer)      :: ncols
    type(dense_matrix) :: A
    type(scalar)       :: val

!    print *, epsilon(1.0_WP)
!    print *, LARGE
!    print *, TINY

    A = dense_matrix(nrows, ncols)

    if (nrows .ne. A % get_row_size()) then
       print *, "Number of row mismatch"
    end if
    
    if (ncols .ne. A % get_col_size()) then
       print *, "Number of col mismatch"
    end if

    do i = 1, nrows
       do j = 1, ncols

          ! Generate a random number
          call random_number(val)

          ! Insert the matrix entries into the block
          call A % add_entry(i, j, val)

          ! Get the matrix entries from the block
          if (val - A % get_entry(i,j) .gt. epsilon(1.0_WP) ) then
             print *, "DENSE MATRIX error", i, j, val, A % get_entry(i,j)
          end if

       end do
    end do

  end subroutine test_dense_matrix

end module dense_matrix_test
