C             INPT15              LEVEL=4        DATE=82.10.13
      SUBROUTINE INPT15
C
      COMMON /TW1C/ DD(1),LIM1,IA(210)
      DIMENSION D(212)
      EQUIVALENCE (D(1),DD(1))
C
C     INPUT INTEGERS
C
CKSK  EQUIVALENCE (D(1),NA(1))
      EQUIVALENCE (DD(1),NA(1))
      EQUIVALENCE (IA(2),ISCT),(IA(4),IGM),(IA(5),IM),(IA(6),JM),
     &(IA(7),IBL),(IA(8),IBR),(IA(9),IBB),(IA(10),IBT),(IA(11),IEVT),
     &(IA(12),ISTART),(IA(13),MT),(IA(15),MS),(IA(29),IXM),(IA(30),IYM),
     &(IA(31),IEDOPT),(IA(32),IGEOM),(IA(35),ISDF),(IA(209),NXRW)
C
C     INPUT FLOATING POINT NUMBERS
C
      EQUIVALENCE (IA(44),EPSI)
C
C     COMPUTED INTEGERS
C
      EQUIVALENCE (IA(56),IMJM),(IA(57),MM),(IA(60),IP),(IA(61),JP),
     &(IA(64),IT),(IA(65),JT),(IA(66),ITJT)
C
C     FIRST WORD ADDRESSES
C
      EQUIVALENCE (D(171),LIHX),(D(172),LIHY),(D(173),LXDF),
     &(D(174),LYDF),(D(181),LDC),(D(182),LXR),(D(183),LYR),(D(187),LW),
     &(D(195),LMN),(D(196),LMC),(D(197),LMD),(D(198),LF),(D(199),LFU),
     &(D(200),LYM),(D(201),LXM),(D(202),LXRA),(D(203),LYRA),
     &(D(180),LFLA)
C
C     DEFINITION OF MATERIAL MESH (WHEN SEPARATE FROM REBALANCE MESH)
C
      EQUIVALENCE (IA(25),IMC),(IA(27),JMC),(D(175),LIHXC),
     &(D(176),LIHYC),(D(177),LDXC),(D(178),LDYC),(D(179),LDYAC),
     &(D(82 ),MESH),(D(204),LFGP)
C
C     EQUIVALENCE FOR EDIT
C
      EQUIVALENCE (IEDIT(1),NZ), (IEDIT(2),NORMZ)
C
C    /FWBGN1/ , /FWBGN2/ , /LOCAL/ , /UNITS/
C
      EQUIVALENCE (D(168),IEDIT(1)),(D(150),IEDOPS),(D(143),ITLIM),
     &(D(105),LAST),(D(162),NEDIT),(D(142),NERROR),(D(156),NINP),
     &(D(157),NOUT),(D(137),TIMOFF)
C
      DIMENSION NA(1),IEDIT(2)
      DIMENSION E16(3),E17(3),E18(6),E19(5),E20(3),E24(5),E25(7),E26(9),
     &E28(6)
      DIMENSION NXYZ01(3),NXYZ02(3),NXYZ03(3),NXYZ04(3),NXYZ05(3),
     &NXYZ06(3)
C
CSASA REAL*8 E16,E17,E18,E19,E20,E24,E25,E26,E28,NXYZ01,NXYZ02,NXYZ03,
CSASA&NXYZ04,NXYZ05,NXYZ06
      CHARACTER*8
     &       E16,E17,E18,E19,E20,E24,E25,E26,E28,NXYZ01,NXYZ02,NXYZ03,
     &NXYZ04,NXYZ05,NXYZ06
C
      DATA E16/'NONMON','OTONE ','X MESH'/
      DATA E17/'NONMON','OTONE ','Y MESH'/
      DATA E18/'CROSS ','SECTIO','N ID N','UMBER ','TOO LA','RGE   '/
      DATA E19/'WEIGHT','S DO N','OT SUM',' TO UN','ITY   '/
      DATA E20/'FATAL ','INPUT ','ERROR '/
      DATA E24/'CROSS ','SECTIO','N ID N','UMBER ','ZERO  '/
      DATA E25/'EDIT R','EGION ','NUMBER',' EXCEE','DS MAX','IMUM N',
     &'Z     '/
      DATA E26/ 'POWER ','NORMAL','IZATIO','N REGI','ON NUM','BER EX',
     & 'CEEDS ','MAXIMU','M NZ  '/
      DATA E28 /'CORE S','TORAGE',' EXCEE','DED BY',' EDIT ',
     & 'MN    '/
      DATA NXYZ01/' XMESH',' RMESH',' RMESH'/
      DATA NXYZ02/' YMESH',' ZMESH',' TMESH'/
      DATA NXYZ03/'X MESH','R MESH','R MESH'/
      DATA NXYZ04/'Y MESH','Z MESH','T MESH'/
      DATA NXYZ05/'X DENS','R DENS','R DENS'/
      DATA NXYZ06/'Y DENS','Z DENS','T DENS'/
C     IMJMC=IMC*JMC
C     CHECK RESTART
      IF ( IABS ( ISTART ) .EQ. 6 ) GO TO 221
C
C     READ REMAINING INPUT
C
CKSK  CALL LOAD ('COARSE',NXYZ01(IGEOM),D(LXR),D(LXR),IP,1)
      CALL LOAD ('COARSE',NXYZ01(IGEOM),DD(LXR),DD(LXR),IP,1)
CKSK  CALL LOAD ('COARSE',NXYZ02(IGEOM),D(LYR),D(LYR),JP,1)
      CALL LOAD ('COARSE',NXYZ02(IGEOM),DD(LYR),DD(LYR),JP,1)
C     CALL LOAD ('CROSS ','SEC ID',D(LDC),D(LDC),IMJMC,-1)
CKSK  CALL LOAD ('CROSS ','SEC ID',D(LDC),D(LDC),IMJM,-1)
      CALL LOAD ('CROSS ','SEC ID',DD(LDC),DD(LDC),IMJM,-1)
C
C     CHECK FOR MIXTURES
C
      IF (MS.EQ.0) GO TO 100
CKSK  CALL LOAD ('MIX NU','MBERS ',D(LMN),D(LMN),MS,-1)
      CALL LOAD ('MIX NU','MBERS ',DD(LMN),DD(LMN),MS,-1)
CKSK  CALL LOAD ('MIX CO','MMANDS',D(LMC),D(LMC),MS,-1)
      CALL LOAD ('MIX CO','MMANDS',DD(LMC),DD(LMC),MS,-1)
CKSK  CALL LOAD ('MIX DE','NSITY ',D(LMD),D(LMD),MS,1)
      CALL LOAD ('MIX DE','NSITY ',DD(LMD),DD(LMD),MS,1)
C
C     CHECK FOR DELTA OPTION
C
  100 IF (IEVT.NE.4) GO TO 120
      IF (IXM.EQ.0) GO TO 110
CKSK  CALL LOAD (NXYZ03(IGEOM),' MODS ',D(LXM),D(LXM),IMC,1)
      CALL LOAD (NXYZ03(IGEOM),' MODS ',DD(LXM),DD(LXM),IMC,1)
  110 IF (IYM.EQ.0) GO TO 120
CKSK  CALL LOAD (NXYZ04(IGEOM),' MODS ',D(LYM),D(LYM),JMC,1)
      CALL LOAD (NXYZ04(IGEOM),' MODS ',DD(LYM),DD(LYM),JMC,1)
C
C     CHECK DENSITY FACTOR INPUT
C
  120 CONTINUE
CKSK  CALL CLEARW(1.0,D(LXDF),IT)
      CALL CLEARW(1.0,DD(LXDF),IT)
CKSK  CALL CLEARW(1.0,D(LYDF),JT)
      CALL CLEARW(1.0,DD(LYDF),JT)
      IF (ISDF.EQ.0) GO TO 130
CKSK  CALL LOAD (NXYZ05(IGEOM),'ITY F ',D(LXDF),D(LXDF),IT,1)
      CALL LOAD (NXYZ05(IGEOM),'ITY F ',DD(LXDF),DD(LXDF),IT,1)
CKSK  CALL LOAD (NXYZ06(IGEOM),'ITY F ',D(LYDF),D(LYDF),JT,1)
      CALL LOAD (NXYZ06(IGEOM),'ITY F ',DD(LYDF),DD(LYDF),JT,1)
  130 CONTINUE
C     IF (MESH.NE.0) GO TO 140
C
C     DRAW COARSE MESH MAP
C
      L1=LAST-IP
CKSK  CALL MAPPER ( D(LXR),D(LYR),D(L1 ),D(LDC),D(LIHX),D(LIHY),IM,IP,
CKSK &JM,JP,IMJM,IBL,IBT,IBR,IBB,IGEOM,1 )
      CALL MAPPER ( DD(LXR),DD(LYR),DD(L1 ),DD(LDC),DD(LIHX),DD(LIHY),
     &IM,IP,JM,JP,IMJM,IBL,IBT,IBR,IBB,IGEOM,1 )
C     GO TO 170
C
C     READ MATERIAL MESH INTEGERS AND MESH BOUNDARIES
C
C 140 CALL LOAD ('MATERL',NXYZ01(IGEOM),D(LIHXC),D(LIHXC),IMC,-1)
C     CALL LOAD (6HMATERL,NXYZ02(IGEOM),D(LIHYC),D(LIHYC),JMC,-1)
C     CALL LOAD (6HMATBND,NXYZ01(IGEOM),D(LXRA),D(LXRA),IMC+1,1)
C     CALL LOAD (6HMATBND,NXYZ02(IGEOM),D(LYRA),D(LYRA),JMC+1,1)
C
C     TEMPORARY STORAGE
C
C     L1=LAST-IP-IMJM
C     L2=L1+IMJM
C
C     GENERATE MESH PARAMETERS
C
C     CALL CSMESH ( D(LIHXC),D(LIHYC),D(LDXC),D(LDYC),D(LDYAC),D(L1),
C    1IMC,JMC,IT,JT,IMJM )
C
C     DRAW COARSE MESH MAP
C
C     CALL MAPPER ( D(LXR),D(LYR),D(L2),D(L1),D(LIHX),D(LIHY),IM,IP,JM,
C    1JP,IMJM,IBL,IBT,IBR,IBB,IGEOM,1 )
C
C     DRAW MATERIAL MAP
C
C     CALL MAPPER ( D(LXRA),D(LYRA),D(L2),D(LDC),D(LIHXC),D(LIHYC),IMC,
C    1IMC+1,JMC,JMC+1,IMJMC,IBL,IBT,IBR,IBB,IGEOM,2 )
C
C     MOVE MATERIAL MESH INTO XRAD AND YRAD
C
C     IMP=IMC+1
C     DO 150 I=1,IMP
C 150 D(LXR+I-1)=D(LXRA+I-1)
C     IMP=JMC+1
C     DO 160 I=1,IMP
C 160 D(LYR+I-1)=D(LYRA+I-1)
C 170 CONTINUE
C
C     DATA CHECKING
C
      DO 180 I=1,IM
CK180 IF (D(LXR+I).LE.D(LXR+I-1)) CALL ERROR (2,E16,3)
  180 IF (DD(LXR+I).LE.DD(LXR+I-1)) CALL ERROR (2,E16,3)
      DO 190 I=1,JM
CK190 IF (D(LYR+I).LE.D(LYR+I-1)) CALL ERROR (2,E17,3)
  190 IF (DD(LYR+I).LE.DD(LYR+I-1)) CALL ERROR (2,E17,3)
      DO 200 I=1,IMJM
      IFWB=NA(LDC+I-1)
      IF (IFWB.EQ.0) CALL ERROR (2,E24,5)
      IF (IFWB.LT.0) IFWB=IABS(IFWB)+ISCT
C 200 IF (IFWB.GT.MT) CALL ERROR (2,E18,6)
  200 CONTINUE
  210 T=0.0
      DO 220 M=1,MM
CK220 T=T+D(LW+M-1)
  220 T=T+DD(LW+M-1)
      IF (ABS(4.*T-1.0).GT.EPSI) CALL ERROR (2,E19,5)
C     TIME OFF
  221 CONTINUE
      TIMOFF=0.0
      IF (ITLIM.NE.0) TIMOFF=FLOAT(ITLIM)
      IF (IABS(IEDOPS).EQ.5) GO TO 280
C
C     OBTAIN  EDIT INPUT
C
      IF (IEDOPT.EQ.0) GO TO 280
CKH   READ (NINP,290)NEDS
      CALL REAM(NEDS,NEDS,NEDS,0,1,0)
      WRITE (NOUT,300)NEDS
      CALL RITE (NEDIT,0,NEDS,1,3)
      IF ((IEDOPT.EQ.1).OR.(IEDOPT.EQ.3)) GO TO 230
CKH   READ (NINP,290)MN
      CALL REAM(MN,MN,MN,0,1,0)
      WRITE (NOUT,310)MN
      ITEMP = LFU + MN
      IF ( ITEMP .GT. LAST ) CALL ERROR ( 2, E28, 6 )
CKSK  CALL LOAD ('MICRO ','XS IDS',D(LFU),D(LFU),MN,-1)
      CALL LOAD ('MICRO ','XS IDS',DD(LFU),DD(LFU),MN,-1)
CKSK  CALL RITE (NEDIT,0,D(LFU),MN,3)
      CALL RITE (NEDIT,0,DD(LFU),MN,3)
  230 IF (NEDS.LE.0) GO TO 270
      DO 260 N=1,NEDS
CKH   READ (NINP,290)NZ,NORMZ
      CALL REAM(IEDIT,IEDIT,IEDIT,0,2,0)
      WRITE (NOUT,320)NZ,NORMZ
CKSK  CALL LOAD ( 'EDIT Z','ONES  ', D(LFLA), D(LFLA), IMJM, -1)
      CALL LOAD ( 'EDIT Z','ONES  ', DD(LFLA), DD(LFLA), IMJM, -1)
      CALL RITE (NEDIT,0,IEDIT,2,3)
CKSK  CALL RITE ( NEDIT, 0, D(LFLA), IMJM, 3 )
      CALL RITE ( NEDIT, 0, DD(LFLA), IMJM, 3 )
C
C     CHECK ZONE SPECIFICATIONS
C
      IERRED=0
      DO 240 I=1,IMJM
      IF ( NZ .LT. NA ( LFLA + I - 1 ) ) IERRED = 1
      IF ( NA ( LFLA + I - 1 ) .LE. 0 ) IERRED = 1
  240 CONTINUE
      IF (IERRED.NE.0) CALL ERROR (3,E25,7)
      IF (IEDOPT.EQ.3) GO TO 250
      IF (IEDOPT.NE.4) GO TO 260
  250 CONTINUE
      IF (NORMZ.EQ.0) GO TO 260
      IF (NORMZ.LT.0) CALL ERROR (3,E26,9)
      IF (NORMZ.GT.NZ) CALL ERROR (3,E26,9)
  260 CONTINUE
  270 CONTINUE
      CALL RITE (NEDIT,0,0.0,0,4)
  280 CONTINUE
CKSK  CALL LOAD('X-REG ','/ ZONE',D(LFGP),D(LFGP),IMJM,-1)
      CALL LOAD('X-REG ','/ ZONE',DD(LFGP),DD(LFGP),IMJM,-1)
CKH
      NXRW=0
      DO 285 I=1,IMJM
      KEYNO=NA(LFGP+I-1)
      IF (KEYNO.EQ.0) GO TO 285
      IF(I.EQ.1)  GO TO 284
      DO 283 J=1,I-1
      IF(KEYNO.EQ.NA(LFGP+J-1)) GO TO 285
  283 CONTINUE
  284 NXRW=NXRW+1
  285 CONTINUE
CKH
CKH   WRITE(6,600) NXRW,(NA(LFGP+I-1),I=1,IMJM)
CK600 FORMAT(' TOTAL NO. OF X-REGION =',I2/' X-REG. ID. =',(40I3))
CKH
C
C     INPUT COMPLETED
C
      IF ( NERROR .EQ. 2 ) CALL ERROR ( 1, E20, 3 )
C
      RETURN
C
CK290 FORMAT (12I6)
  300 FORMAT (1H0////,1X,I4,' NEDS   NUMBER OF EDITS '//)
  310 FORMAT (1H0,I4,' MN   NUMBER OF MICROSCOPIC ACTIVITIES TO BE C',
     &'OMPUTED ')
  320 FORMAT (1H0,I4,' NZ     NUMBER OF EDIT ZONES '/1X,I4,' NORMZ',
     &' ZONE TO WHICH POWER DENSITY IS NORMALIZED ')
      END
