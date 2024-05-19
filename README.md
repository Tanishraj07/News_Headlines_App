## News Headlines App
Overview
The News Headlines App is a mobile application developed using Flutter that provides the latest news headlines from various sources. The app is built following the Model-View-ViewModel (MVVM) architectural pattern, ensuring a clean separation of concerns, maintainable code, and testability. The news data is fetched from a REST API, specifically the News API, which provides access to a wide range of news articles from various sources around the world.

## Architecture
The app follows the MVVM (Model-View-ViewModel) architecture pattern, which helps in separating the UI logic from the business logic. This ensures that the code is modular, maintainable, and testable.

Model: Represents the data layer of the app, including data models and repository classes responsible for fetching data from the API.
View: Represents the UI layer of the app, which includes Flutter widgets that display the data.
ViewModel: Acts as a mediator between the Model and the View, handling the business logic and preparing data for the View.

## Technologies and Libraries
- Flutter: The UI toolkit used to build the application for both Android and iOS.<br>
-Dart: The programming language used to write Flutter code.<br>
-Provider: A state management solution for managing the app's state and dependency injection.<br>
-HTTP: A package used to make HTTP requests to the News API.<br>
-CachedNetworkImage: A package for displaying images from the network with caching support.<br>
-Google Fonts: For custom fonts to enhance the UI.<br>
-SpinKit: A package for showing loading animations while fetching data.<br>
## REST API
The app uses the News API to fetch news headlines. The API provides various endpoints to get the latest news articles, filter news by category, and search for news articles by keywords.
