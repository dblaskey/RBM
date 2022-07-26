SUBROUTINE Read_Restart(nyear,nr) ! NOT CURRENTLY USED
!
IMPLICIT NONE
!
integer :: nr,ncell,nseg_temp 
real    :: T_0
real(8) :: time
real    :: T_head

allocate (temp(nreach,0:ns_max,2))
allocate (T_head(nreach))

!
open (19, file = 'data1.dat', status = 'old')
read(19,*) nr,ncell,nseg_temp,T_0,T_head
!
END SUBROUTINE Read_Restart
