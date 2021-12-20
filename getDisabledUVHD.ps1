$paths = ('\\srv-term1\e$','\\srv-term2\e$','\\srv-term3\e$','\\srv-term4\e$\users','\\arm-prog\Profiles$')

foreach ($path in $paths) {
  "------------------------------------------------------------------------------------------------"
  ""
  "{0} [{1}]:" -f $path.Replace("\\","").Split("\")[0].ToUpper(), $path 
  ""

  foreach ($item in (Get-ChildItem -Path $path | Select-Object Name | Sort-Object -Property Name)) {
    if ($item.Name -like 'UVHD-S-1-5-21-4088653738-8641610-406250774-*.vhdx') { 
      $user = Get-ADUser -Identity ($item.Name.Replace("UVHD-","").Replace(".vhdx",""))
      if ( -not $user.Enabled) {
        "Enable: {0} - {1}, {2}" -f $user.Enabled, $user.Name.Trim(), $item.Name
      } 
    }
  }
}
