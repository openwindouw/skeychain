# Skeychain
Simple Wrapper for Keychain

# Example

Create a class to define the data to be protected.

class KeychainWrapper: SKeychain {
    
    // The user's password (stored in the keychain and protected).
    static var password: String? {
        get {
            let value = load(with: "password", prompt: "Autenticarse para iniciar sesión.")
            return value
        }
        set {
            if let newValue = newValue {
                save(with: "password", data: newValue)
            } else {
                delete(with: "password")
            }
        }
    }
}
