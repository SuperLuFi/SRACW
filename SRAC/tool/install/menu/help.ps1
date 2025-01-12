<#
    SRAC Installation Conductor for Windows
    Author: Leben Asa (GMU-2014)
    
    NOTE: Feature may differ from original script by Keisuke Okumura.
          I have no responsibility to any troubles regarding this
          script usage.
#>

if($SRAC_Code -eq $null) {
    "Please run this script from PunchMe.ps1."
    exit
}

$menu = " "
while($menu -ne "q") {
@"
  +++++++++++++++++++++++< Help Menu >++++++++++++++++++++++++++++
  +                                                              +
  +  1 : about the SRAC code system                              +
  +  2 : about file structure                                    +
  +  3 : about installation                                      +
  +  4 : about contact to consultants                            +
  +  5 : output all contents of help in file (help.txt)          +
  +  6 : show current version number                             +
  +  q : bye-bye                                                 +
  +                                                              +
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"@
[string]$number = Read-Host "Set number"
switch($number) {
    '1' { Get-Content "$SRAC_Code/tool/install/help/help1.txt"; Read-Host "Return" }
    '2' { Get-Content "$SRAC_Code/tool/install/help/help2.txt"; Read-Host "Return" }
    '3' { Get-Content "$SRAC_Code/tool/install/help/help3.txt"; Read-Host "Return" }
    '4' { Get-Content "$SRAC_Code/tool/install/help/help4.txt"; Read-Host "Return" }
    '5' { 
        Get-Content "$SRAC_Code/tool/install/help/help`*.txt" >> "$SRAC_Code/help.txt"
        "Saved to $SRAC_Code/help.txt"
        Read-Host "Return"
     }
    '6' { Get-Content "$SRAC_Code/src/srac/stamp.f" }
    'q' { "Bye"; $menu="q" }
    default { "$number is invalid number. " }
}
}