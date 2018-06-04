# GeoXplore
GeoXplore is a university project game app for mobile platforms with [provided API](https://github.com/djwojtas/geoxplore-api) as well.

 ###### :snail: Early stage of building - the project is still being developed :rocket: :wrench:
![loginRegister](https://user-images.githubusercontent.com/17625089/40444526-e4e18128-5ec9-11e8-9c2e-a642f24463ea.gif)

## About
- Log in/Register user
- Choose your location, around which You will get personalized (in progress) boxes to find
- Unblock the boxes with Augumented Reality by reaching minimal distance between your location and box
- Gain experience, collect badges

![homelocation](https://user-images.githubusercontent.com/17625089/40945962-564bbce4-685b-11e8-8efc-22d5dc71777b.gif)
![boxxx](https://user-images.githubusercontent.com/17625089/40946296-1097cc40-685d-11e8-9571-667e3c1d4571.gif)
![rankinggif](https://user-images.githubusercontent.com/17625089/40443507-d52e52c2-5ec6-11e8-9bb8-1336d003fac0.gif) 



## Prerequisites

Make sure you have the following software installed before beginning:

- Latest version of Xcode (at least 8.2.1)
- Recent version of the iOS SDK (at least 10.0)

You can download these from the [Apple Developer website](https://developer.apple.com/downloads/).

## Getting started

First, clone or download the project from Github and move into its directory:

```
git clone https://github.com/belaab/GeoXplore.git

```

This project uses [CocoaPods](https://cocoapods.org/) as a dependency manager, all used pods listed below:
  - [Alamofire](https://github.com/Alamofire/Alamofire)
  - [Mapbox iOS SDK](https://www.mapbox.com/ios-sdk/)
  - [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
  - [SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper)
  - [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)

If you don't have installed CocoaPods already, install it with the following command:

```
gem install cocoapods
```

Then fetch dependencies and build the workspace:

```
pod install
```

When completed, the project should be ready to open:

```
open "GeoXplore.xcworkspace"
```

