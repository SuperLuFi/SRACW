       SUBROUTINE  HOLPOS(IPOS,IDENT,MAXNUB,IHOL)
C
       CHARACTER*8 IDENT
       CHARACTER*8 IHOL(MAXNUB)
C
       IPOS     = -1
       DO 100 I = 1 , MAXNUB
       II       = I
       IF(IDENT.EQ.IHOL(I)) GO TO 110
  100  CONTINUE
       WRITE(6,101) IDENT
       STOP 806
  101  FORMAT(1H ,' ERROR STOP AT HOLPOS ]]] ',A8,' IS UNDEFINED.')
C
  110  IPOS     = II
       RETURN
       END