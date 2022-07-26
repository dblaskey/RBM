SUBROUTINE WRITE_RESTART(outPrefix,year,nr,ncell,ns,T_0,T_head)
!
Implicit NONE
!
integer :: year,nr,ncell,ns 
real    :: T_0
real(8) :: time
real    :: T_head
character (len=200 ):: restart_file
character(len=10) :: file_id
character (len=200 ):: outPrefix
!
! Write the integer into a string:
write(file_id, '(i0)') year
!
restart_file=TRIM(outPrefix)//'_'//TRIM(ADJUSTL(file_id))//'.r'
open(19,file=TRIM(restart_file),status='NEW')
write (19,'(3f8.2,4f25.1,f8.1,f8.4)')           &
            nr,ncell,ns,T_0,T_head
close(19)
end SUBROUTINE WRITE_RESTART
