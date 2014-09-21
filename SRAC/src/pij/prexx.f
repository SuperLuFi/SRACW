C     PREXX FOR OCTANT SYMMETRIC GEOMETRY #09 IDIVP=2
      SUBROUTINE PREXX(RX,RDP,NPTX,VMESH,MESHX,
     1  MESHP,IIJJ,NSRPIN,NZONE,IRR,IXR,MMR)
      DIMENSION NZONE(1),RX(1),MESHX(NX,NX),IXR(1),
     1        VMESH(1),IRR(1),MMR(1),NPTX(NAPIN)
     2       ,RDP(NDPIN1,NTPIN),MESHP(4,NDPIN,NX1,NX1)
     3       ,NSRPIN(NTPIN+1),IIJJ(4,NTPIN)
      COMMON / PIJ1C / NX,NY,NTPIN,NAPIN,NCELL,NM,NGR,NGD,NDPIN,
     1                 IDIVP,BETM,NX1,NY1,DUM(6),NDPIN1,
     2                 NDR,NDA,LL,L0,RO1,DRO,FVOL,IDUM28(8),NMESH
      COMMON / PIJ2C / IGT,NZ,NR,NRR,NXR,IBOUND,IDRECT,ICOUNT,IEDPIJ,
     1                 IFORM,NTTAB,NUTAB,SZ
      COMMON /MAINC/   DUMMY1(63),NOUT1,NOUT2
      COMMON /IGEOM/   DUMMY2( 5),PINR,RANGE,DUMMY3,NPINZ
      DATA PI/3.1415927/
      NDIVP=IDIVP**2
      FNDIVP=1.
      IF(IDIVP.GT.0) FNDIVP=FLOAT(NDIVP)
CXX          MESH NUMBER OF MODERATOR REGION
      NX2=(NX1*NX)/2
      IJ=0
      DO 100 J=1,NX
      DO 100 I=J,NX
      IJ=IJ+1
      MESHX(I,J)=IJ
      VMESH(IJ )=(RX(J+1)-RX(J))*(RX(I+1)-RX(I))
      IF(I.NE.J) VMESH(IJ)=2.*VMESH(IJ)
  100 CONTINUE
      NMESH=IJ
CXZ   IF(NTPIN.EQ.0) GO TO 350
      CALL ICLEA(MESHP,4*NDPIN*NX1*NX1,0)
      CALL ICLEA(IIJJ,4*NTPIN,0)
CXZ   PIN REGION COUNT  NSRPIN
      L=0
CXX   DO 300 N=1,NTPIN
      DO 300 N=1,NAPIN
      FACT2=1.
      DO 300 K=N,NAPIN
      L=L+1
      NSRPIN(L)=IJ
CXZ   FACT=0.
CXZ   IIJJ(3) IIJJ(4) REGION AROUND PIN N  LEFT UPPER,  RIGHT UPPER
CXZ   IIJJ(1) IIJJ(2 )                     LEFT LOWER,  RIGHT UPPER
      VP=PI*RDP(NDPIN1,L )**2/4.
      IF(N.NE.K) VP=2.*VP
C
      IF(NPTX(K).GT.1   .AND. NPTX(N).GT.1  ) THEN
C11   FACT=FACT+0.25
CXX   IIJJ(1,N)=NPTX(K)-1+NX*(NPTX(N)-2)
      IIJJ(1,L)=LOCF(NPTX(K)-1,NPTX(N)-1,NX,NMESH)
CXZ   IF(IDIVP.EQ.0) IIJJ(1)=1
                                VMESH(IIJJ(1,L))=VMESH(IIJJ(1,L))-VP
                                              ENDIF
      IF(NPTX(K).LT.NX1 .AND. NPTX(N).GT.1  ) THEN
C22   FACT=FACT+0.25
CXX   IIJJ(2,N)=NPTX(K) +NX*(NPTY(N)-2)
      IIJJ(2,L)=LOCF(NPTX(K)  ,NPTX(N)-1,NX,NMESH)
CXZ   IF(IDIVP.EQ.0) IIJJ(2)=1
                                VMESH(IIJJ(2,L))=VMESH(IIJJ(2,L))-VP
                                              ENDIF
      IF(NPTX(K).GT.1   .AND. NPTX(N).LT.NX1) THEN
C33   FACT=FACT+0.25
CXX   IIJJ(3,N)=NPTX(K)-1+NX*(NPTY(N)-1)
      IIJJ(3,L)=LOCF(NPTX(K)-1,NPTX(N)  ,NX,NMESH)
CXZ   IF(IDIVP.EQ.0) IIJJ(3)=1
                                VMESH(IIJJ(3,L))=VMESH(IIJJ(3,L))-VP
                                              ENDIF
      IF(NPTX(K).LT.NX1 .AND. NPTX(N).LT.NX1) THEN
C44   FACT=FACT+0.25
CXX   IIJJ(4,N)=NPTX(K) +NX*(NPTY(N)-1)
      IIJJ(4,L)=LOCF(NPTX(K)  ,NPTX(N)  ,NX,NMESH)
CXZ   IF(IDIVP.EQ.0) IIJJ(4)=1
                                VMESH(IIJJ(4,L))=VMESH(IIJJ(4,L))-VP
                                              ENDIF
      RR=0.
      DO 210 NP=1,NDPIN
      RP=RDP(NP+1,N)**2
      DO 200 I=1,NDIVP
      IF(I.EQ.3 .AND. K.EQ.N) GO TO 200
      IF(IIJJ(I,L).NE.0) THEN
      IJ=IJ+1
      VMESH(IJ)=PI*FACT2*(RP-RR)/FNDIVP
      IF(I.EQ.2 .AND. K.EQ.N) VMESH(IJ)=2.*VMESH(IJ)
      MESHP(I,NP,NPTX(K),NPTX(N))=IJ
                       ENDIF
  200 CONTINUE
  210 RR=RP
      FACT2=2.
  300 CONTINUE
      NSRPIN(NTPIN+1)=IJ
  350 IF(NZ.NE.IJ) THEN
                   WRITE(NOUT1,9100) NZ,IJ
                   STOP
                   ENDIF
C
CXX   SEVERAL QUANTITIES FOR NUMERICAL INTEGRATION
      IF(NPTX(1) .EQ.1) THEN
      NPINZ=1
      PINR=RDP(NDPIN1,1)
                        ELSE
      NPINZ=0
                        ENDIF
CXX   NDR=NGR*(NX+NY)/2
      NDR=  NGR*NX
      IF(NDR     .GT. 2000) WRITE(NOUT1,9101)
CXY   RANGE : HALF OF DIAGONAL
      RANGE =   SQRT(2.*RX(NX1)**2)
C     DRO =RANGE/FLOAT(NDR)
      RO1= RANGE
CXY
      FVOL=0.25
CXY   SZ : QUARTER OF SURFACE AREA BY FVOL
      SZ=2.*RX(NX1)
       IF(BETM.GT.PI/4.)THEN
      WRITE(6,*) ' ** ANGULAR INTEGRATION RANGE IS MODIFIED TO 45 DEG '
       BETM=PI/4.
                        ENDIF
CXX   DO 80 NT=1,NTPIN
CXX   RPP(NT)=RX(NPTX(NT))
CXX   THETA(NT)=TY(NPTY(NT))
CXX80 CONTINUE
C
C
C * * PRINT MESH NUMBER AND REGION NUMBER
CXZ   IF(NTPIN.EQ.0) CALL IPRTX('S-RE','GION',NX,NY,MESHX)
                     CALL IPRTXX('S-REGION',MESHX,MESHP)
      IF(NR.EQ.NZ) GOTO 140
      IJ=0
      DO 135 J=1,NX
      DO 135 I=J,NX
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHX(I,J) = IT
  135 CONTINUE
CXZ   IF(NTPIN.EQ.0) GO TO 140
      IJ=NMESH
CXX   DO 136 NT=1,NTPIN
      NT=0
      DO 136 N =1,NAPIN
      DO 136 K =N,NAPIN
      NT=NT+1
      DO 136 ND=1,NDPIN
      DO 136 I=1,NDIVP
      IF(N.EQ.K .AND. I.EQ.3) GO TO 136
      IF(IIJJ(I,NT).NE.0) THEN
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHP(I,ND,NPTX(K),NPTX(N))=IT
                          ENDIF
  136 CONTINUE
  140 CONTINUE
C     IF(NTPIN.EQ.0) CALL IPRTX('S-RE','GION',NX,NY,MESHX)
                     CALL IPRTXX('T-REGION',MESHX,MESHP)
C
      IF(NRR.EQ.NR) GO TO 151
      IJ=0
      DO 145 J=1,NX
      DO 145 I=J,NX
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHX(I,J) = IRR(IT)
CXZ   IF(NTPIN.EQ.0 .OR. IDIVP.NE.0)  IJ=IJ+1
  145 CONTINUE
CXZ   IF(NTPIN.EQ.0) GO TO 150
      IJ=NMESH
CXX   DO 146 NT=1,NTPIN
      NT=0
      DO 146 N =1,NAPIN
      DO 146 K =N,NAPIN
      NT=NT+1
      DO 146 ND=1,NDPIN
      DO 146 I=1,NDIVP
      IF(N.EQ.K .AND. I.EQ.3) GO TO 146
      IF(IIJJ(I,NT).NE.0) THEN
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHP(I,ND,NPTX(K),NPTX(N))=IRR(IT)
                          ENDIF
  146 CONTINUE
  150 CONTINUE
CXZ   IF(NTPIN.EQ.0) CALL IPRTX('R-RE','GION',NX,NY,MESHX)
                     CALL IPRTXX('R-REGION',MESHX,MESHP)
  151 IF(NXR.LT.2 .OR. NXR.EQ.NRR) GOTO 171
      IJ=0
      DO 155 J=1,NX
      DO 155 I=1,NX
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHX(I,J) = IXR(IRR(IT))
CXZ   IF(NTPIN.EQ.0 .OR. IDIVP.NE.0)  IJ=IJ+1
  155 CONTINUE
CXZ   IF(NTPIN.EQ.0) GO TO 170
      IJ=NMESH
CXX   DO 160 NT=1,NTPIN
      NT=0
      DO 160 N =1,NAPIN
      DO 160 K =N,NAPIN
      NT=NT+1
      DO 160 ND=1,NDPIN
      DO 160 I=1,NDIVP
      IF(N.EQ.K .AND. I.EQ.3) GO TO 160
      IF(IIJJ(I,NT).NE.0) THEN
      IJ=IJ+1
      IT=NZONE(IJ)
      MESHP(I,ND,NPTX(K ),NPTX(N ))=IXR(IRR(IT))
                          ENDIF
  160 CONTINUE
  170 CONTINUE
CXZ   IF(NTPIN.EQ.0) CALL IPRTX('X-RE','GION',NX,NY,MESHX)
                     CALL IPRTXX('X-REGION',MESHX,MESHP)
  171 IF(NM.EQ.NRR) GO TO 9999
      IF(NM.EQ.  1) GO TO 9999
      IJ=0
      DO 180 J=1,NX
      DO 180 I=J,NX
      IJ=IJ+1
      IREG=NZONE(IJ)
      MESHX(I,J) = MMR(IRR(IREG))
CXZ   IF(NTPIN.EQ.0 .OR. IDIVP.NE.0)  IJ=IJ+1
  180 CONTINUE
CXZ   IF(NTPIN.EQ.0) GO TO 195
      IJ=NMESH
CXX   DO 190 NT=1,NTPIN
      NT=0
      DO 190 N =1,NAPIN
      DO 190 K =N,NAPIN
      NT=NT+1
      DO 190 ND=1,NDPIN
      DO 190 I=1,NDIVP
      IF(N.EQ.K .AND. I.EQ.3) GO TO 190
      IF(IIJJ(I,NT).NE.0) THEN
      IJ=IJ+1
      IT=NZONE(IJ)
      IR=IRR(IT)
      MESHP(I,ND,NPTX(K ),NPTX(N ))=MMR(IR)
                         ENDIF
  190 CONTINUE
      CALL IPRTXX('M-REGION',MESHX,MESHP)
 9999 RETURN
 9100 FORMAT(' **** UNMATCH IN TOTAL S-REGION NUMBER ***',2I10)
 9101 FORMAT(30H**** TIME CONSUMING CASE       )
      END
