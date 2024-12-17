Setup Instructions
Follow these steps to run the Weather Tracker app on your local machine:

1. Clone the Repository
bash
Copy code
git clone https://github.com/your-username/WeatherTracker.git
cd WeatherTracker
2. Open the Project in Xcode
Make sure you have Xcode 14+ installed.
Open the WeatherTracker.xcodeproj file.
3. Add API Key
Go to the Constants.swift file located in the project directory.
Replace YOUR_API_KEY_HERE with your WeatherAPI key:
swift
Copy code
struct Constants {
    static let API = [
        "weatherURL": "https://api.weatherapi.com/v1/current.json?key=",
        "key": "YOUR_API_KEY_HERE"
    ]
}
4. Build and Run
Select the iOS Simulator or a physical device in Xcode.
Press ⌘ + R to build and run the app.
How to Use the App
Search: Use the search bar to enter a city name.
View Weather: The weather details for the selected city will appear.
Tap on the Card: The card refreshes the data for the saved city.
Persistence: Relaunching the app will display the last searched city’s weather automatically.
Dependencies

5.Testing
Unit tests are included for the WeatherViewModel to test core functionalities.
To run tests:
Select Product → Test in Xcode.
Ensure all tests pass successfully.
