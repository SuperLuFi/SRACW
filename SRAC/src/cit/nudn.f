CNUDN --144 ***CITATION*** POINT NEUTRON DENSITY FOR 1,2-D/ CF-OUTC
C              FOR MACROSCOPIC CROSS SECTION USE
CM    SUBROUTINE NUDN(ONEOV,NCOMP, P2 ,NRGN ,UTIL ,SOURE, IVX,JVX,KBVX,
      SUBROUTINE NUDN(SIG  ,NCOMP, P2 ,NRGN ,UTIL ,SOURE, IVX,JVX,KBVX,
     & KVX,LVX,MVX,NSETVX)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      REAL*8 P2
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
      COMMON/ABURN/BBURN(30),NSIG1(50),NSIG2(50),NSIG3(50),N1N2R(2,ZDX),
     &  NSIG4(50),NSIG5(50),NSIG6(50),NJM(50),NJMM(50),NJNQ(50),NCH(50),
     &  NZON(ZDX),NXSET(ZDX),NXODR(ZDX),IDXSET(ZDX),NCLASS(ZDX),NDP(ZDX)
     & , XNAME(3,ZDX)
C
CM    DIMENSION ONEOV(KVX,NSETVX),NCOMP(LVX),SOURE(JVX,IVX,KBVX), P2
      DIMENSION SIG(KVX,MVX,13)  ,NCOMP(LVX),SOURE(JVX,IVX,KBVX), P2
     & (JVX,IVX, KVX),NRGN (JVX,IVX ),UTIL (JVX,IVX )
C
      DO 102 I = 1,IVX
      DO 101 J = 1,JVX
      L = NRGN (J,I )
      M = NCOMP(L)
CM    NS = NXSET(M)
CM    NR = NXODR(NS)
      UTIL (J,I ) = 0.0
      DO 100 K = 1,KVX
CM    UTIL (J,I ) = UTIL (J,I )+P2(J,I, K)*ONEOV(K,NR)
      UTIL (J,I ) = UTIL (J,I )+P2(J,I, K)*SIG(K,M,13)
  100 CONTINUE
  101 CONTINUE
  102 CONTINUE
      IND = 2
      CALL POUT(P2,UTIL,IND,SOURE,IVX,JVX,KBVX,KVX)
      RETURN
      END