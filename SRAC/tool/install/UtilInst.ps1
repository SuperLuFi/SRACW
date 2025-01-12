<#
    SRAC Installation Conductor for Windows
    Author: Leben Asa (GMU-2014)
    Install utility programs.
    
    NOTE: Feature may differ from original script by Keisuke Okumura.
          I have no responsibility to any trouble regarding this
          script usage.
#>

if($SRAC_Code -eq $null) {
    "Please run this script from PunchMe.ps1."
    exit
}

#
#=== Utility Codes(TXTtoPDS, PDStoTXT) ====================================
#
" XXX Installation of TXTtoPDS and PDStoTXT started."
cd "$SRAC_Code/util/pdscnvt/src/txttopds"
make -f MakeTP
cd "$SRAC_Code/util/pdscnvt/src/pdstotxt"
make -f MakePT
cd "$SRAC_Code/util/pdscnvt/bin"
OutToExe
" XXX Utilitie (TXTtoPDS and PDStoTXT) were installed."

#=== Bickley Function Table Generator =====================================
#
" XXX Installation of Bickley function table generator started."
cd "$SRAC_Code/tool/kintab"
make
OutToExe
" XXX Installation of Bickley function table generator completed."
#
#=== PDS Utility Programs(PDSMDL) =========================================
#
" XXX Installation of PDS utility programs (PDSMDL) started."
cd "$SRAC_Code/util/pdsmdl/main/BnupEdit"
make
cd "$SRAC_Code/util/pdsmdl/main/FluxEdit"
make
cd "$SRAC_Code/util/pdsmdl/main/FluxPlot"
make
cd "$SRAC_Code/util/pdsmdl/main/MacroEdit"
make
cd "$SRAC_Code/util/pdsmdl/main/MicroEdit"
make
cd "$SRAC_Code/util/pdsmdl/main/AnisnXS"
make
cd "$SRAC_Code/util/pdsmdl/bin"
OutToExe

" XXX Installation of PDS utility programs (PDSMDL) completed."

" XXX All processes completed."