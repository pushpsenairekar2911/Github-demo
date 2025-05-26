

# GitHub-Demo iOS App
<br></br>
<div style="
    display: flex;
    align-items: center;
    justify-content: center;">
   <img src="https://github.com/pushpsenairekar2911/Github-demo/blob/main/Assets/screenshots.png" />
</div>

<br></br>

This project contains the source code for the GitHub-Demo iOS app. It demonstrates fetching and displaying GitHub user data and repositories using a modular, scalable architecture. The app is built using Swift and SwiftUI.

---

## Structure Overview

### Libraries

* **GHKit**: A foundational UI library that includes reusable styles such as colors, fonts, icons, and shared UI components used throughout the app.

* **GHFoundation**: Contains utility extensions and helpers for multiple components.

### Services

Services provide reusable functionality and business logic, including networking and data transformation.

* **GHNetworkingService**: A low-level networking layer that handles all API requests and responses. This is used by higher-level services to interact with the GitHub API.

* **UserService**: A feature-specific service that exposes methods like `fetchUsers()`, `fetchUserDetails(userName:)`, and `fetchUserRepos(userName:)`. It consumes `GHNetworkingService` to retrieve and decode GitHub data.

> Services are implemented as Swift packages and injected into feature modules using protocol interfaces, promoting decoupling and testability.

### Features

Each screen in the app is treated as a distinct feature, with its own View, ViewModel, and supporting logic. Features do not contain networking or persistent storage logic directly.

#### Screens:

1. **Onboarding Screen**: Entry point for the user.
2. **UsersView**: Displays a list of GitHub users.
3. **UserDetailsView**: Shows detailed information about a selected user.
4. **UserReposView**: Lists repositories owned by the selected user.

### App Architecture

The app uses **Model-View-ViewModel-Router (MVVM-R)** architecture, designed for modularity, reusability, and separation of concerns.

* **Model**: Encapsulates raw data structures such as `GHUser`, `GHUserDetail`, and `GHRepo`.
* **View**: SwiftUI views like `UsersView`, `UserDetailsView`, and `UserReposView` for UI representation.
* **ViewModel**: Acts as a bridge between model and view. Processes raw data from services and exposes a presentation model for views.
* **Router (AppRouter)**: Manages the navigation between features. Reduces tight coupling between views and enables flexible routing logic.

---


## How to Build the App

1. Open the project in Xcode.
2. Make sure the scheme `Github-Demo` is selected.
3. Choose a simulator of your choice.
4. Build and run the app using the play button or `Cmd + R`.

---

## Unit Testing and Code Coverage

Tests are added to demonstrate how to mock and validate functionality for select modules:

* **UserServiceTests**: Tests the networking integration of `UserService` using mock data.

> Tests are limited to core components for demonstration purposes.

To run tests:

1. Open the **Test Navigator** in Xcode (left panel).
2. Run individual test modules or all tests using the test button.

---

## Summary

The GitHub-Demo iOS app demonstrates clean architectural principles using SwiftUI and modern iOS development patterns. It is built for extensibility and serves as a solid foundation for larger production-grade applications.

For feedback or contributions, please open an issue or submit a pull request.


## Design Files

If you want to see the deign files for this app then [click here](https://sketch.com/s/dc3a06ea-cd79-4e74-af19-56e1bd653da3)

-----


## Demo 

If you want to see the actual working of the application then [click here.]()

-----
