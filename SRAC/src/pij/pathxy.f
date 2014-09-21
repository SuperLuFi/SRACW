      SUBROUTINE PATHXY
      COMMON / PIJ1C / NX,NY,NTPIN,NAPIN,NCELL,NM,NGR,NGA,NDPIN,
     1                 IDIVP,BETM,NX1,NY1,IDUM(6),NDPIN1,
     2                 NDR,NDA,LL,L0,RO1,DRO,IDUM27(9),NMESH
      COMMON / PIJ2C / IGT,NZ,NR,NRR,NXR,IBOUND,IDRECT,ICOUNT,IEDPIJ,
     1                 IFORM,NTTAB,NUTAB,SZ,IDUM1(26),
     2                 LCMMR,LCNREG,LCIRR,LCIXR,LCMAR,LCMAT,LCVOL,
     3                 LCVOLR,LCVOLX,LCVOLM,NO2,AA(950)
      COMMON / PIJC /  L00,L01,L02,L03,L04,L05,L06,L07,L08,L09,
     1                 L10,L11,L12,L13,L14,L15,L16,L17,L18,L19,L20,L21,
     2                 L22,L23,L24,L25,L26,L27,L28,L29,L30,L31,L32,L33,
     3                 L34,L35,L36,L37,L38,L39,L40,L41,L42,L43,L44,L45,
     4                 DD(55)
      COMMON /WORK /A(30000)
      COMMON /MAINC/ DUM1(63),NOUT1,NOUT2,IT0,DUM67(29),MXDIM,DM97(4),
     1               CASENM(2),TITLE(18),DUM3(880)
      NMESH = NX*NY
      IF(NGR*NDA.NE.0) GO TO 10
      NGR = 5
      NDA = 10
   10 CONTINUE
   20 CONTINUE
C     L01=1
C 1   RX  BY L01
C     L02 =L01 + NX1+NAPIN
C 2   RPP BY L02
C     IF(IGT.GE.11 .AND IGT.LE.16) L03 = L02 + NTPIN
C 3   RDP BY L03
C     IF(IGT.GE.11 .AND. IGT.LE.16  .AND. IGT.NE.14)
C    &                              L04 = L03 + NDPIN1*NTPIN
C 4   NPIN  BY L04
C     FOR IGT=13,15,16 NTPX AND NTPY
C     L05=L04+2*MAX0(NTPIN,NAPIN)
C 5   THETA BY L05
C     L06 = L05 + NTPIN
C 6   TY    BY L06
C     L08 = L06 + NY1
C 8   D     BY L08
C     L09 = L08 + NTTAB
C 9   IM    BY L09
C     L10 = L09 + NTTAB
C 10  IP    BY L10
C     L11 = L10 + NTTAB
C 11  II    BY L11
C     L12 = L11 + NTTAB
C 12  X     BY L12
C     L14 = L12 + NTTAB
C 14  S     BY L14
C     L25 = L14 + NR
C 25  XX          LENGTH NUTAB
C     L26 = L25 + NUTAB
C 26  III         LENGTH NUTAB
C     L27 = L26 + NUTAB
C 27 VMESH        LENGTH MAXIMUM SUB-ZONE
      L28 = L27 + NX*NY+NDPIN*NTPIN
      IF(IDIVP.EQ.2)
     &L28=  L27 + 4*NDPIN*NTPIN+NX*NY
C 28  MESHX       LENGTH NX*NY
      L29 = L28 + NX*NY
C 29  MESHP       LENGTH NDPIN*NX1*NY1
      L30=  L29 + NDPIN*NX1*NY1
      IF(IDIVP.EQ.2)
     &L30=  L29 + 4*NDPIN*NX1*NY1
C 30  DX          LENGTH NX1 #16 1994/01/07
      L31 = L30 + 2*NX1
C 31  DY          LENGTH NY1 #16   1994/01/07
      L32  = L31 + 2*MAX0(NX1,NY1)
C 32  IIJJ
      L33  = L32 + 4*NTPIN
C 33  NSRPIN  S-REGION BY PIN
      LAST = L33 +   NTPIN+1
C
      WRITE(NOUT1,990)           ' L01= ',L01,' L02= ',L02,' L03= ',L03,
     & ' L04= ',L04,' L05= ',L05,' L06= ',L06,' L08= ',L08,' L09= ',L09,
     & ' L10= ',L10,' L11= ',L11,' L12= ',L12,' L14= ',L14,' L25= ',L25,
     & ' L26= ',L26,' L27= ',L27,' L28= ',L28,' L29= ',L29,' L30= ',L30,
     & ' L31= ',L31,' L32= ',L32,' L33= ',L33,' LST= ',LAST
  990 FORMAT(10X,10(A,I5)/10X,10(A,I5)/10X,10(A,I5))
      IF(LAST.LE.MXDIM) GO TO 100
      LAST=LAST-MXDIM
      WRITE(NOUT1,9000) LAST,MXDIM
      WRITE(NOUT2,9000) LAST,MXDIM
      STOP
  100 CONTINUE
      WRITE(NOUT1,9010) LAST,MXDIM
      WRITE(NOUT2,9010) LAST,MXDIM
 9000 FORMAT(' *** DIMENSION OVER FOUND IN PATHXY ',I7,' FROM ',I7)
 9010 FORMAT(1H0,9X,' STORAGE USED',I7,' WITHIN ',I7,' IN PATHXY STEP')
CKO *****ADD PREXR PREXQ FOR IGT=16
      IF(IGT.EQ.16)   THEN
      IF(IDIVP.LT.2) THEN
        CALL PREXR(A(L01),A(L02),A(L03),A(L04),A(L04+NTPIN),
     1             A(L05),A(L06),A(L27),A(L28),A(L29)
     2            ,AA(LCNREG),AA(LCIXR),AA(LCMMR),AA(LCIRR))
                     ELSE
        CALL PREXZ(A(L01),A(L03),A(L04),A(L04+NTPIN),A(L06)
     1            ,A(L27),A(L28),A(L29),A(L32),A(L33)
     2            ,AA(LCNREG),AA(LCIXR),AA(LCMMR),AA(LCIRR))
                     ENDIF
                      ENDIF
      IF(IGT.EQ.13)   THEN
      IF(IDIVP.LT.2) THEN
        CALL PREXY(A(L01),A(L02),A(L03),A(L04),A(L04+NTPIN),
     1             A(L05),A(L06),A(L27),A(L28),A(L29)
     2            ,AA(LCNREG),AA(LCIXR),AA(LCMMR),AA(LCIRR))
                     ELSE
        CALL PREXQ(A(L01),A(L02),A(L03),A(L04),A(L04+NTPIN),
     1             A(L05),A(L06),A(L27),A(L28),A(L29),A(L32),A(L33)
     2            ,AA(LCNREG),AA(LCIXR),AA(LCMMR),AA(LCIRR))
                     ENDIF
                      ENDIF
CKO *************************
      CALL VOLPIJ(
     1  AA(LCNREG),AA(LCIRR),AA(LCIXR),AA(LCMMR),
     2  A(L27),AA(LCVOL),AA(LCVOLR),AA(LCVOLX),AA(LCVOLM))
C
C     SUBROUTINE PREXY(RX,TY,RDP,NPTX,NPTY,MESHP,
C    1  MESHX,VMESH,NZONE,IXR,V,MMR,IRR)
C
      IF(NTPIN.NE.0 .AND. IDIVP.EQ.0) NMESH=1
      CALL MAKETX(AA(LCNREG),AA(LCIRR),AA(LCMMR),AA(LCVOL)
     1 ,A(L01),A(L02),A(L03),A(L04),A(L04+NTPIN),A(L05),A(L06)
     2 ,A(L08),A(L09),A(L10),A(L11),A(L12),A(L14),A(L25),A(L26)
     3 ,A(L28),A(L29),A(L30),A(L31),A(L33))
C     SUBROUTINE MAKETX(NZONE,IRR,MMR,VOL,
C    &  A01,A02,A03,A041,A042,A05,A06,
C    &  D  ,IM ,IP ,II ,XX ,S, X, III,
C    &  A28,A29,A30,A31,A33)
      RETURN
      END
