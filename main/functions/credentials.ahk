; Credential Management System
; Handles loading and managing sensitive credentials from environment files

class CredentialManager {
    ; Static class to manage credential loading and storage
    static credentials := Map()
    
    ; Load credentials from .env file
    static LoadCredentials() {
        try {
            envFile := A_ScriptDir . "\.env"
            if FileExist(envFile) {
                content := FileRead(envFile)
                lines := StrSplit(content, "`n", "`r")
                
                for line in lines {
                    line := Trim(line)
                    if (line && !InStr(line, "#") && InStr(line, "=")) {
                        parts := StrSplit(line, "=", 2)
                        key := Trim(parts[1])
                        value := Trim(parts[2])
                        this.credentials[key] := value
                    }
                }
            }
        } catch as e {
            ; Silently fail if .env file doesn't exist or can't be read
            ; This allows the script to continue with default/empty values
        }
    }
    
    ; Get a specific credential by key
    static Get(key, defaultValue := "") {
        return this.credentials.Has(key) ? this.credentials[key] : defaultValue
    }
    
    ; Check if a credential exists
    static Has(key) {
        return this.credentials.Has(key)
    }
    
    ; Get all credentials (for debugging/development)
    static GetAll() {
        return this.credentials.Clone()
    }
}

; Load credentials when the script starts
CredentialManager.LoadCredentials()