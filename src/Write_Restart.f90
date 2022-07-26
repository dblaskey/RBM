SUBROUTINE WRITE_RESTART(nr,ncell,ns,T_0,T_head)
!
Implicit NONE
!
integer :: nr,ncell,ns 
real    :: T_0
real(8) :: time
real    :: T_head
!
write (19,'(3i6,2f8.2)')           &
            nr,ncell,ns,T_0,T_head
close(19)
end SUBROUTINE WRITE_RESTART
