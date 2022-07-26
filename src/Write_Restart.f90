SUBROUTINE WRITE_RESTART(outPrefix,nyear,nr,ncell,ns,T_0,T_head)
!
Implicit NONE
!
integer :: nyear,nr,ncell,ns 
real    :: T_0
real(8) :: time
real    :: T_head
character (len=200 ):: restart_file
character(len=10) :: file_id
character (len=200 ):: outPrefix
!
! Write the integer into a string:
write(file_id, '(i0)') nyear
!
restart_file=TRIM(outPrefix)//'_'//TRIM(ADJUSTL(file_id))//'.r'
write(*,*) ' File Name - ',TRIM(restart_file)
open(19,file=TRIM(restart_file),status='unknown')
write (19,'(3i6,2f8.2)')           &
            nr,ncell,ns,T_0,T_head
close(19)
end SUBROUTINE WRITE_RESTART
