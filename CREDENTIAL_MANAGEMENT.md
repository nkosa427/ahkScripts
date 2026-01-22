# Credential Management System

## Overview

This system provides a secure way to manage sensitive credentials in your AutoHotkey scripts without exposing them in the repository.

## How It Works

1. **Environment Files**: Credentials are stored in `.env` files (never committed to git)
2. **Credential Manager**: A centralized system loads and manages credentials from environment files
3. **Secure Access**: Scripts access credentials through the CredentialManager class

## File Structure

```
├── .env                    # Your actual credentials (DO NOT COMMIT)
├── .env.template          # Template for creating new .env files
├── .gitignore             # Excludes .env files from git
├── main/
│   ├── functions/
│   │   └── credentials.ahk    # Credential management system
│   └── programs/
│       └── altserver.ahk      # Updated to use credentials
└── main.ahk               # Updated to include credential system
```

## Setup Instructions

### 1. Create Your Environment File

Copy the template and fill in your actual credentials:

```bash
cp .env.template .env
```

Edit `.env` with your credentials:

```ini
# AltServer Credentials
ALT_SERVER_EMAIL=your_email@example.com
ALT_SERVER_PASSWORD=your_password_here
```

### 2. Verify .gitignore

Ensure `.gitignore` contains:
```
# Environment files - contain sensitive credentials
.env
.env.*
```

### 3. Using Credentials in Scripts

#### Basic Usage
```autohotkey
; Get a credential with a default value if not found
email := CredentialManager.Get("ALT_SERVER_EMAIL", "")
password := CredentialManager.Get("ALT_SERVER_PASSWORD", "")

; Check if a credential exists
if CredentialManager.Has("ALT_SERVER_EMAIL") {
    ; Use the credential
    Send(CredentialManager.Get("ALT_SERVER_EMAIL"))
}
```

#### In altserver.ahk
```autohotkey
#HotIf WinActive("ahk_exe AltServer.exe")
F13:: Send(CredentialManager.Get("ALT_SERVER_EMAIL", ""))
F16:: Send(CredentialManager.Get("ALT_SERVER_PASSWORD", ""))
#HotIf
```

## Security Best Practices

1. **Never commit .env files** to version control
2. **Add .env to .gitignore** (already done)
3. **Use descriptive credential names** (e.g., `ALT_SERVER_EMAIL` instead of `EMAIL`)
4. **Provide default values** for optional credentials
5. **Keep .env files secure** with appropriate file permissions

## Adding New Credentials

1. Add the credential to your `.env` file:
   ```ini
   NEW_SERVICE_API_KEY=your_api_key_here
   ```

2. Use it in your script:
   ```autohotkey
   apiKey := CredentialManager.Get("NEW_SERVICE_API_KEY", "")
   ```

## Troubleshooting

### Credentials not loading?
- Ensure `.env` file exists in the script directory
- Check file permissions
- Verify the credential key name matches exactly
- Look for syntax errors in the `.env` file

### Getting "File not found" errors?
- Make sure the credential manager is included in your main script
- Check that the file paths are correct
- Ensure the credential manager is loaded before trying to access credentials

## Migration from Hardcoded Credentials

To migrate existing scripts:

1. **Identify hardcoded credentials** in your scripts
2. **Add them to .env** with descriptive names
3. **Replace hardcoded values** with `CredentialManager.Get("KEY_NAME", "")`
4. **Test thoroughly** to ensure functionality is preserved

## Example: Complete Migration

**Before:**
```autohotkey
F13:: Send("nickchase5146@gmail.com")
F16:: Send("6h{#}hJRlX0gGMXv")
```

**After:**
```autohotkey
F13:: Send(CredentialManager.Get("ALT_SERVER_EMAIL", ""))
F16:: Send(CredentialManager.Get("ALT_SERVER_PASSWORD", ""))
```

## Benefits

- ✅ **Security**: Credentials never touch the repository
- ✅ **Flexibility**: Easy to add new credential keys
- ✅ **Maintainability**: Clean separation of concerns
- ✅ **Portability**: Works with existing workflows
- ✅ **Version Control**: No sensitive data in git history