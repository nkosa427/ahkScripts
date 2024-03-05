taskkill /F /IM "Razer Central.exe"
taskkill /F /IM "RazerCentralService.exe"
taskkill /F /IM "Razer Synapse Service.exe"
taskkill /F /IM "Razer Synapse Service Process.exe"
taskkill /F /IM "GameManagerService.exe"
taskkill /F /IM "Razer Synapse 3.exe"

timeout /t 3 /nobreak  >nul

start "" "C:\Program Files (x86)\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe"