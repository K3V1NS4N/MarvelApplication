# Marvel Application
The Marvel app is an iOS app that uses the official Marvel API to search through all Marvel characters, and also provides access to the details of each one.

# Requirements
- CocoaPods 1.11.2
- Xcode 12 or above
- iOS 12.0 +
- Swift 5
# Build Instructions
Install Xcode [developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
Clone the repository:
```sh
git clone https://github.com/K3V1NS4N/MarvelApplication.git
```
Then access to the root cloned folder through your terminal and install the pod dependencies:
```sh
pod install
```
Open MarvelApplication.xcworkspace in Xcode.
## Features
- [x] List of characters with an end scroll.
- [x] UISearchController to search for your favorite characters.
- [x] Detail screen to show up characters description.
- [ ] Search by comics, series, events, stories....
- [ ] Display character comics, series, events on detail screen
- [ ] Save your favorite character

## Technical description
This app is based on the `VIPER` architecture, it separates the code further by single responsibility.

The application has two targets, `MarvelApplication` which is the one that makes the calls to the official API and `MarvelApplication MOCK`, which mocks the responses with a stored json, to be able to continue developing even if there is no connection with the server.

Among the libraries it uses, we have the HTTP network library `Alamofire`, which is used to make the Marvel API calls.

The app also needs to download the photos of all characters asynchronously, as well as cache them to improve performance, for this, we have the `AlamofireImage` library, which simplifies this whole process.

In order to serialize and deserialize data, the app makes use of the `CodableAlamofire` that lets you serialize and deserialize custom data types without writing any special code and without having to worry about losing your value types.

Regarding the secure connection to the Marvel API, there are a `Public key` and a `private key` in the environment configuration of the app, these two keys are sent together with a `Timestamp` after being hashed with MD5, for which we use the `CryptoSwift` library.

# UnitTest and UITest
The project includes a total of `22` unit tests and `4` automated tests to test the UI.
