# NasaSearchApp


This application is used for searching images using NASA API and to show images as well as details regarding details and metadata for selected image. This application supports paging to keep loading new set of images.

Library: SDWebImage
This library provides an async image downloader with cache support. For convenience, we added categories for UI elements like UIImageView, UIButton, MKAnnotationView.

Application Architecture:
This application follows MVVM architecture, which used ViewModel to loosely bind ViewController (View) with Model. ViewCotntroller has access to viewModel which communicates with model and has way to communicate back to viewcontroller.


Running iOS NasaSearchApp

Using XCode:

   i) Please launch ACMEBrowser.xcproject from application folder.
   ii) Select target simulator
   iii) Run application using Run buton

Using command line:

Tools:
You will need to have Xcode Command Line Tools installed on the machine that will be building the app. If you already have Xcode it is very likely that you have Xcode Command Line Tools installed. Specifically, we will be using the xcodebuild tool . To see if you have it installed you can run:

xcodebuild -help
If you have Xcode and don’t have this tool you can install it by running this in the terminal:

xcode-select --install

1. xcodebuild -list -project <project-name>.xcodeproj
2. xcodebuild clean
3. xcodebuild archive -scheme <scheme-that-you-want-to-use> -sdk iphoneos -allowProvisioningUpdates -archivePath <path-and-name-for-archive>.xcarchive