# Boilerplate Project

A boilerplate project created in flutter using Bloc. Boilerplate supports build mobile apps to faster.

## Getting Started

The Boilerplate contains the minimal implementation required to create a new library or project.
## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/zubairehman/flutter_bloc_boilerplate.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Open with Editer VSCode or Android Studio and run

## Boilerplate Features:

* Splash
* Login
* Home
* Routing
* Theme
* Dio
* Database
* Validation
* Logging
* Multiple Theme and Dark Theme
* Multiple language
* Multiple font
* CI/CD github action

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter_bloc_boilerplate/
|- android
|- build
|- ios
|- lib
```

Here is the folder structure we have been using in this project

```
lib/
|- api/
|- blocs/
|- configs/
|- database/
|- models/
|- repositorys/
|- screens/
|- utils/
|- widgets/
```

Now, lets dive into the lib folder which has the main code for the application.

```
Config Files
File locate: ./lib/configs/..

application.dark: main setting for app
config.dark: load app config for app
image.dark: all images use for the app
language.dark: all images use for the app
list.dark: config setting for directory listing data
preferences.dark: define key for storing dta
routes.dark: define router flow
theme.dark: define common FontFamily, FontWeight, Typography system
theme_collection.dark: theme schema for application
Widget
File locate: ./lib/widgets/..

Contains all UI widget of application like: Button, Loading, Star Rating, Item, Card, Message …

Blocs
Contains all Blocs pattern of the application

Screens
File locate: ./lib/screens/..

Contains all screens of the application

All template design of the app are locate in here (./lib/screens/..). You could change or re-structure by matching with your own project structure design.

Assets
File locate: ./assets/..

You can store images, fonts or other file resource in this folder

Models
File locate: ./lib/models/..

We defined data model for each screen, all data will be load through data model class

Utils
File locate: ./lib/utils/..

Contains all utils function like validate form, logger, switch mode theme, color … It looks like helper functions

API
File locate: ./lib/api/..

http_manager.dark: define API url, timeout, post, get, exception code handler
api.dark: define constants Suffix API url for each function
```

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.