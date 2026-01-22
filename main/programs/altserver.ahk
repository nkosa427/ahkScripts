#HotIf WinActive("ahk_exe AltServer.exe")
F13:: Send(CredentialManager.Get("ALT_SERVER_EMAIL", ""))
F16:: Send(CredentialManager.Get("ALT_SERVER_PASSWORD", ""))
#HotIf