C     MAIN PROGRAM TO GET LIBRARY INFORMATION
C     FROM SRAC95 PUBLIC LIBRARY (ONLY FOR UNIX VERSION)
C     BY KEISUKE OKUMURA (ORIGINALLY BY K.KANEKO)
C
      CHARACTER*4     IDENT(2)
      CHARACTER*8     NMKEEP(500)
      CHARACTER*20    LIBNAM
      CHARACTER*80    INFORM(500)
      CHARACTER       DIRNAM*120,MEMBER*8
      CHARACTER*30    PREFIX 
C
      COMMON /WORK  / WORK(20000)
      DIMENSION       WEIT(100),ENBND(100)
      DIMENSION       IWORK(20000)
      EQUIVALENCE (IWORK(1),WORK(1))
C
C *** START OF PROCESS
C
      CALL UIOSET
C
      READ(5,10) LIBNAM
   10 FORMAT(A20)
      LIBLEN = INDEX(LIBNAM," ") - 1
      IF(LIBLEN.LE.0) THEN
        LIBNAM = 'PUBLIC'
        LIBLEN = 6
      ENDIF
C
C*******************
C  FAST    LIBRARY 
C*******************
C
      PREFIX = 'FASTP'
      CALL GETDIR (PREFIX,DIRNAM,LENDIR)
      IOUT = 99
      IPRN = 1
CMEMO LENG = 5+NGF*2
      LENG = 0
      MEMBER = 'FASTLIB '
      CALL PDSIN(DIRNAM,MEMBER,WORK,LENG,IOUT,IPRN,IRC)
      CALL PDSER(' MAIN ',DIRNAM,MEMBER,IRC,IOUT)
C
      NGF  = IWORK(1)
      NGF1 = IWORK(2)
      NGF2 = IWORK(3)
      NGF3 = IWORK(4)
      WRITE(6,701) NGF,NGF1,NGF2,NGF3
C
      DO 310 I = 1,NGF
      WEIT(I)  = WORK(4+I)
  310 CONTINUE
      ISW      = 4 + NGF
      DO 320 I = 1,NGF+1
      ENBND(I) = WORK(ISW+I)
  320 CONTINUE
      WRITE(6,702) (WEIT(I),I=1,NGF)
      WRITE(6,704)
      WRITE(6,703) (ENBND(I),I=1,NGF+1)
C
      LOUT   = 10
      NGDOWN = 107
CM    REWIND LOUT
C     WRITE(LOUT,'(A)')  '******* FAST LIBRARY INFORMATION ***** '
C     WRITE(LOUT,'(A)') '* #1  NG  NGDWON , 2I4 ) *** '
C     WRITE(LOUT,'(2I4)') NGF,NGDOWN
C     WRITE(LOUT,'(A)') '* #2  ENERGY BOUNDARY (HIGH TO LOW ) *** '
C     WRITE(LOUT,'(1P6E12.5)') (ENBND(I),I=1,NGF+1)
C
  701 FORMAT(1H1///1H ,20X,'## FAST LIBRARY ## ',
     1 /1H ,1X,'NGF : NO. OF ENERGY GROUPS -------------- ',I3,
     2 /1H ,1X,'NGF1: GROUP NO. AT 1.0 MEV -------------- ',I3,
     3 /1H ,1X,'NGF2: GROUP NO. AT 50. KEV -------------- ',I3,
     4 /1H ,1X,'NGF3: GROUP NO. AT 130.07 EV ------------ ',I3//)
  702 FORMAT(1H ,1X,'WEIGHTS : ',1P5E12.5)
  703 FORMAT(1H ,1X,'ENBND   : ',1P5E12.5)
  704 FORMAT(1H0//)
  705 FORMAT(2A4)
C
      NISO = 0
  100 CONTINUE
      READ(5,705,END=900) IDENT
      IF(IDENT(1).EQ.'    ') GO TO 900
      NISO = NISO + 1
      NMKEEP(NISO) = IDENT(1)//IDENT(2)
      GO TO 100
C
 900  CONTINUE
C     WRITE(LOUT,'(A)') '* #3  NISO ( NO O FNUCLIDE , I4 ) *** '
C     WRITE(LOUT,'(I4)') NISO
C
      DO 1000 LOP = 1  , NISO
C     WRITE(LOUT,'(A)') '* #4  IDENT (NUCLIDE NAME) , A8 ) *** '
C     WRITE(LOUT,'(A8)') NMKEEP(LOP)
      IDENT(1)    = NMKEEP(LOP) (1:4)
      IDENT(2)    = NMKEEP(LOP) (5:8)
      ISWFT       =  0
      NTFT        =  0
      IIRES       = -1
      CALL DPREAD(IDENT,DIRNAM,ISWFT,NTFT,IIRES,IOUT,IPRN)
      IF(ISWFT.EQ.0)  NTFT = 0
CM    CALL PRINT (IDENT,LOUT)
CM                          1234567890123456789012345678901234567890
CM    INFORM( 1: 40) = 40H       NO  NUCLIDE          NO     0
CM    INFORM(41: 80) = 40H   NO        NO      0     P0,P1
C
      INFORM(LOP)(1:40)= '        O                   NO          '
CKSK  INFORM(LOP)(1:40)=40H        O                   NO
      INFORM(LOP)(41:80) = '   NO                                   '
CKSK  INFORM(LOP)(41:80) = 40H   NO
      WRITE(INFORM(LOP)(6:9),'(I4)') LOP
CKSK  INFORM(LOP)(12:18) = NMKEEP(LOP)(2:8)
      INFORM(LOP)(12:19) = 'X'//NMKEEP(LOP)(2:8)
      WRITE(INFORM(LOP)(33:36),'(I4)') NTFT
      IF(ISWFT.EQ.1) INFORM(LOP)(29:31) ='YES'
      IF(IIRES.EQ.1) INFORM(LOP)(44:46) ='YES'
      IF(IIRES.EQ.-1)THEN
      INFORM(LOP)(21:40) = 'NO DATA IN FASTLIB            '
      INFORM(LOP)(51:80) = '                              '
CKSK  INFORM(LOP)(21:40) = 30H  NO DATA IN FASTLIB
CKSK  INFORM(LOP)(51:80) = 30H
                     ENDIF
 1000 CONTINUE
C
C*******************
C  THERMAL LIBRARY 
C*******************
C
      PREFIX = 'THERMALP'
      CALL GETDIR (PREFIX,DIRNAM,LENDIR)
CMEMO LENG = 2+NGT*2
      LENG = 0
      MEMBER = 'THERMAL1'
      CALL PDSIN(DIRNAM,MEMBER,WORK,LENG,IOUT,IPRN,IRC)
      CALL PDSER(' MAIN ',DIRNAM,MEMBER,IRC,IOUT) 
C
      NGT  = IWORK(1)
      DO 1310 I = 1,NGT
      WEIT(I)   = WORK(1+I)
 1310 CONTINUE
      ISW       = NGT + 1
      DO 1320 I = 1,NGF+1
      ENBND(I) = WORK(ISW+I)
 1320 CONTINUE
C
      WRITE(6,1701)  NGT
      WRITE(6,1702) (WEIT(I),I=1,NGT)
      WRITE(6, 704)
      WRITE(6,1703) (ENBND(I),I=1,NGT+1)
C
C     LOUT   = 11
C     REWIND LOUT
C
C     WRITE(LOUT,'(A)')  '*****THERNAL LIBRARY INFORMATION ***** '
C     WRITE(LOUT,'(A)') '* #1  NG (NO OF ENERGY GROUP) , I4 ) *** '
C     WRITE(LOUT,'(I4)') NGT
C     WRITE(LOUT,'(A)') '* #2  ENERGY BOUNDARY (HIGH TO LOW ) *** '
C     WRITE(LOUT,'(1P6E12.5)') (ENBND(I),I=1,NGT+1)
C
 1701 FORMAT(1H1///1H ,20X,'## THERMAL LIBRARY ## ',
     1 /1H ,1X,'NGT : NO. OF ENERGY GROUPS -------------- ',I3//)
 1702 FORMAT(1H ,1X,'WEIGHTS : ',1P5E12.5)
 1703 FORMAT(1H ,1X,'ENBND   : ',1P5E12.5)
C
C     WRITE(LOUT,'(A)') '* #3  NISO ( NO O FNUCLIDE , I4 ) *** '
C     WRITE(LOUT,'(I4)') NISO
C
      DO 2000 LOP = 1  , NISO
C     WRITE(LOUT,'(A)') '* #4  IDENT (NUCLIDE NAME) , A8 ) *** '
C     WRITE(LOUT,'(A8)') NMKEEP(LOP)
      IDENT(1)    = NMKEEP(LOP) (1:4)
      IDENT(2)    = NMKEEP(LOP) (5:8)
      ISWFT       = 0
      NT          = 0
      LORD        = 0
      CALL TLIB(IDENT,LOUT,DIRNAM,NGT,ISWFT,NT,LORD,IOUT,IPRN)
CM                        1234567890123456789012345678901234567890
CM    INFORM( 1: 40) = 40H       NO  NUCLIDE          NO     0
CM    INFORM(41: 80) = 40H   NO        NO      0     P0,P1
C
      WRITE(INFORM(LOP)(60:62),'(I3)') NT
      IF(ISWFT.EQ.0) INFORM(LOP)(54:56) ='NO '
      IF(ISWFT.EQ.1) INFORM(LOP)(54:56) ='YES'
      IF(LORD .EQ.0) INFORM(LOP)(68:80) =' NO DATA     '
      IF(LORD .EQ.1) INFORM(LOP)(68:80) =' P0          '
      IF(LORD .EQ.2) INFORM(LOP)(68:80) =' P0,P1       '
      IF(LORD .EQ.3) INFORM(LOP)(68:80) =' P0-P2       '
      IF(LORD .EQ.4) INFORM(LOP)(68:80) =' P0-P3       '
      IF(LORD .EQ.5) INFORM(LOP)(68:80) =' P0-P4       '
      IF(LORD .EQ.6) INFORM(LOP)(68:80) =' P0-P5       '
 2000 CONTINUE
C
      REWIND LOUT
      NPAGE  = (49+NISO)/50
      IPAGE  = 0
CKSK
      WRITE(LOUT,7891)  LIBNAM(1:LIBLEN)
      WRITE(LOUT,7892)
      WRITE(LOUT,7894)
      WRITE(LOUT,7892)
      DO 7890 LOP = 1 , NISO
CKSK  IF(MOD(LOP,50).EQ.1)  THEN
CKSK    IPAGE = IPAGE + 1
CKSK    WRITE(LOUT,7891)  LIBNAM,IPAGE,NPAGE
CKSK    WRITE(LOUT,7892)
CKSK    WRITE(LOUT,7894)
CKSK    WRITE(LOUT,7892)
CKSK  ENDIF
      WRITE(LOUT,'(A76)')   INFORM(LOP)(5:80)
CKSK  IF(MOD(LOP,50).EQ.0)  THEN
CKSK    WRITE(LOUT,7892)
CKSK    WRITE(LOUT,7893)
CKSK  ENDIF
 7890 CONTINUE
                            WRITE(LOUT,7892)
CM    REWIND LOUT
C
C7891 FORMAT(1H ,' NUCLIDE LIST FOR ',A8,' LIBRARY'
C    @     /1H ,50X,' PAGE ',I2,' OF ',I2/)
 7891 FORMAT(1H ,' NUCLIDE LIST FOR ',A, ' LIBRARY')
C7892 FORMAT(1H ,1X,19(4H----))
 7892 FORMAT(1H ,1X,70(1H-))
C7893 FORMAT(1H ,52X,'TO BE CONTINUED ')
 7894 FORMAT(1H ,2X,'NO ','  NUCLIDE    ','     FAST F-TABLE   MCROSS ',
     @                  ' THERMAL  NTEMP   THERMAL ',
     @      /1H ,2X,'   ','             ','     DATA  NTEMP    LIBRARY',
     @                  ' F-TAB.           KERNEL  ')
C
C *** END OF PROCESS
C
      STOP
      END
