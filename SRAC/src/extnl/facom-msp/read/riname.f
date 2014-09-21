      SUBROUTINE RINAME(MEMBER,MEMBR2)
CKSK  RENAME IS BUILTIN FUNCTION IN G77
CKSK  SUBROUTINE RENAME(MEMBER,MEMBR2)
C
*INCLUDE READPINC
C
      CHARACTER*8     CZMEMB,SCMEMB,FLMODE,DATAKP,MEMBER,MEMBR2
      CHARACTER*12    DDNAME,FILENM
      CHARACTER*68    PATHNM
      INTEGER*4       ECODE,TEMP,PATH
C
      COMMON /PDSPDS/ DDNAME(125),IST(15),IRW(15),IOS(35),NC(5,20),
     &                IFLSW,FILENM,ECODE,TEMP
C
      COMMON /PDSWK3/ PATHNM(15),FLMODE(15),DATAKP(15),CZMEMB(MAXMEM),
     1                SCMEMB(MAXMEM)
      COMMON /PDSWK2/ IZWRIT,IZMXDT,IZWCNT,IZDWTL,ICNTMX,
     1                LENPAT(15),INCORE(15),ICNTSC,
     2                IZDTLN(MAXMEM),IZDTTL(MAXMEM),IDUMZ,
     3                IPOSDD(MAXMEM),IPOSSC(MAXMEM),
     4                RZDATA(MXWORK)
C
C *** START OF RENAME PROCESS
C
      PATH  = 6
      ECODE = 0
      CALL FILSRC(NFILE,FILENM)
C
      IF(IOS(NFILE).EQ.0) THEN
                    WRITE(6,*) ' *** FILE NOT OPENED DD=',DDNAME(NFILE)
                    STOP
                    ENDIF
C
C
      IF(  INCORE(NFILE) .EQ. 1 ) THEN
           DO 100 I=ICNTMX,1,-1
           IF( IPOSDD(I).EQ.NFILE .AND. CZMEMB(I).EQ.MEMBER) GO TO 200
  100      CONTINUE
           ENDIF
C
C *** CASE FOR DIRECT I/O CASE
CFACOMS
      CALL PDSREN(DDNAME(NFILE),MEMBER,MEMBR2,ECODE)
CFACOME
CUNIXS
CM    CALL PDSREN( PATHNM(NFILE),LENPAT(NFILE),MEMBER,MEMBR2 ,ECODE )
CUNIXE
      IF(ECODE.EQ.0) WRITE(6,10) MEMBER,MEMBR2,DDNAME(NFILE)(1:8)
      GO TO 300
C
C *** CASE FOR INCORE MODE
C
  200 CZMEMB(I) = MEMBR2
      ECODE     = 0
      IF(IOS(NFILE).EQ.3) THEN
                          WRITE(6,10) MEMBER,MEMBR2,DDNAME(NFILE)(1:8)
                          RETURN
                          ENDIF
C
CFACOMS
      CALL PDSREN(DDNAME(NFILE),MEMBER,MEMBR2,ECODE)
CFACOME
CUNIXS
CM    CALL PDSREN( PATHNM(NFILE),LENPAT(NFILE),MEMBER,MEMBR2 ,ECODE )
CUNIXE
      IF(ECODE.EQ.0) WRITE(6,10) MEMBER,MEMBR2,DDNAME(NFILE)(1:8)
C
   10 FORMAT(10X,'MEMBER ',A8,' RENAMED INTO ',A8,' ON DD=',A8)
C
  300 CONTINUE
C       MEMBER IN SCRATCH PDS-FILE WILL BE DELETED
      IF( IST(NFILE).EQ.3 .AND. NC(3,NFILE).GT.0 ) THEN
                DO 330 I = ICNTSC,1,-1
                IF(IPOSSC(I).NE.NFILE.OR.SCMEMB(I).NE.MEMBER) THEN
                      ELSE
                      SCMEMB(I) = MEMBR2
                      GO TO 340
                      ENDIF
  330           CONTINUE
  340           CONTINUE
                ENDIF
C
C *** END OF PROCESS
C
      IF(ECODE.EQ.0) RETURN
      CALL PDSERR(ECODE,MEMBER,PATH,DDNAME(NFILE))
      RETURN
      END
