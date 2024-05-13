# MapS Flutter Application

## Introduction
The MapS Flutter application provides interface to interact with geolocation data. Users can visualize their location on a map, move markers to adjust their location, and save these locations to a remote server.

## Prerequisites
- Flutter SDK
- An IDE (e.g., Android Studio, VS Code)
- An Android device or emulator

## Setup Instructions

1. Clone the Repository
    Clone the Flutter application repository to your local machine.

2. Install Dependencies
    Navigate to the project directory and install the required Flutter packages:
   
    flutter pub get
    
3. API Configuration
    Update the secrets.dart file with your Google Maps API key and the API URL of your Laravel backend:
    
4. Run the App
    Connect your Android device or start an emulator. Run the app:
   
    flutter run
    
## Features

- Login Screen: Allows users login and interacts with the API 

![IMAGE 2024-05-13 18:28:51](https://github.com/sheyls/MapS-flutter/assets/70074598/48498055-339a-4e48-8d19-4623afdcfb5b)

- Real-time Location Tracking: View your current location on a Google map.
- Marker Management: Drag and drop markers to update your location.

![IMAGE 2024-05-13 18:28:52](https://github.com/sheyls/MapS-flutter/assets/70074598/77befa15-1288-4947-abe0-842e7fd02cbb)

  
- Location Persistence: Save your current location, including additional details like region and comuna, to a remote database.

## Devices used for development and testing 
- MacBook Air M1
- Android 11 
