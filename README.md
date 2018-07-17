# Skeychain
Simple Wrapper for Keychain

## Example

Create a class that extend from SKeychain and define the data to be protected.

```swift

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

```

Set the new password

```swift
KeychainWrapper.password = "$up3r$3cr3t"
```

## Install
Copy the file class into your project. In the future, it'll be a cocoapod.


## Requirements
- Xcode 9.4
- Swift 4

## Author

* **[Vladimir Espinola Lezcano](https://www.linkedin.com/in/vladimir-espinola-lezcano-012464a2/)**

## License

The MIT License (MIT)

Copyright (c) 2018 Vladimir Espinola Lezcano

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

