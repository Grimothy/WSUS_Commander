#Vars

$Scriptname = "NSClient-Push"
Write-Host -ForegroundColor Green -BackgroundColor Black "Building Run List for NSCLIENTPUSH"
#Input File Location
$IPC = "C:\Arraya\staging\$Scriptname\infiles.txt" 
#Get Content of Input File
$ICPC = get-content $IPC #Get 
#On Machine list Location
$OnCP =  "C:\Arraya\staging\$Scriptname\outfiles\$Scriptname-On_$(get-date -Format MM-dd-yyy).txt"
#Off Machine list Location
$OffCP = "C:\Arraya\staging\$Scriptname\outfiles\$Scriptname-off_$(get-date -Format MM-dd-yyy).txt"
$NiOn = New-Item -ItemType File -Path $OnCP -ErrorAction SilentlyContinue
$NiOff = New-Item -ItemType File -Path $OffCP -ErrorAction SilentlyContinue

#accept EULA

Write-Host -ForegroundColor Green -BackgroundColor Black "There are " $ICPC.count "Workstations in this File"

Foreach ($i in $ICPC){ 
    #$iv = $i -replace "\\","" #COMMENT FOR FIRST RUN THROUGH
    $tc = Test-Connection $i -Quiet
        if ($tc -like $true) {
            
            write-host -ForegroundColor Green $i machine is on
            write-host -ForegroundColor Magenta Appending values and building run list
            $i +" " + "Proccessed" | Add-Content -Path $OnCP
            $iva = "\\" +$i
            
            C:\Arraya\staging\PsExec.exe  $iva -h -s -c "\\wsus3.trumark.org\NSPUSH\installer.bat"

           
        


        } else { 
            #$iv = $i -replace "\\","" #COMMENT FOR FIRST RUN THROUGH
            Write-Host -ForegroundColor Red $i machine is off
            write-host -ForegroundColor Magenta Appending values and building run list for later
            #$iV | Add-Content -Path $OffCP
            $i | Add-Content -Path $OffCP
            
            }
  }

