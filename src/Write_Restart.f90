SUBROUTINE WRITE_RESTART(nr,ncell,nseg_temp,T_0,T_head)
!
Implicit NONE
!
integer :: nr,ncell,nseg_temp 
real    :: T_0
real(8) :: time
real    :: T_head
!
write (19,'(3i6,2f8.2)')           &
            nr,ncell,nseg_temp,T_0,T_head
close(19)
end SUBROUTINE WRITE_RESTART
