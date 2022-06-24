      SUBROUTINE READ_XMASK(XMASK,NCOL,NROW,FILENAME,
     $        IROW,ICOL,HEADER,CHARDUM,VOIDVAL)

      INTEGER NCOL,NROW,ICOL,IROW,I,J
      REAL XMASK(NCOL,NROW)
      CHARACTER*72, FILENAME
      CHARACTER HEADER(5)*40
      CHARACTER CHARDUM*14
      REAL VOIDVAL
      OPEN(10, FILE = FILENAME,FORM = 'FORMATTED',
     $     STATUS='OLD',ERR=9001)

      DO I = 1,5
         READ(10,'(A40)') HEADER(I)
      END DO
      READ(10,*) CHARDUM, VOIDVAL

      DO J = IROW,1,-1
         READ(10,*, END=20) (XMASK(I,J), I=ICOL,1,-1) 
      END DO      
      CLOSE(10)

      RETURN
 20   WRITE(*,*) 'REACHED END OF XMASK:  LAST ROW', j
 9001 WRITE(*,*) 'CANNOT OPEN INPUT FILE IN READ_XMASK'
      STOP
      END

