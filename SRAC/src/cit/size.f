CSIZE --058 ***CITATION*** CHECKS PROB. LIMITS AGAINST MAX/ CF-IPTM
C
      SUBROUTINE SIZE(IVX,JVX,KBVX,KVX,MVX,NVX,NSETVX,NRVX)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
C
C+++++ CHANGE 1ST.FEB.1991
C 100 IF (IVX.GT.210) GO TO 101
C     IF (JVX.GT.210) GO TO 101
C     IF (KBVX.GT.210) GO TO 101
  100 IF (IVX.GE.MSX) GO TO 101
      IF (JVX.GE.MSX) GO TO 101
      IF (KBVX.GE.MSX) GO TO 101
C     REMOVED LIMIT ON GROUPS
CC    IF (MVX.GT.1000) GO TO 101
CC    IF (NVX.GT.200) GO TO 101
      IF (MVX.GT.ZNEX) GO TO 101
      IF (NVX.GT.ZDX) GO TO 101
      IF (NSETVX.GT.50) GO TO 101
      IF (NRVX.LE.200) GO TO 102
C----- CHANGE END
  101 NER(15) = 15
      WRITE(IOUT,1000)IVX,JVX,KBVX,KVX,MVX,NVX,NSETVX,NRVX
  102 CONTINUE
      RETURN
 1000 FORMAT(1H0,10I6)
      END
