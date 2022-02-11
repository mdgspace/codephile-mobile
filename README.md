# Codephile

Codephile is an application specially made for all the competitive coders out there. With features like submission feed, contest reminders, user search, and many more, this app is a perfect companion for stalking your fellow coders and learning from them.

## Screenshots

<img src="https://user-images.githubusercontent.com/60056833/111873783-1ab52900-89b8-11eb-8951-ca6c13249c05.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873786-1c7eec80-89b8-11eb-9625-d19a05b15e25.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873792-1f79dd00-89b8-11eb-9030-e26c91621304.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873795-2143a080-89b8-11eb-9a28-04ea3f216b5b.png" width="200" height="400" />
<img src="https://user-images.githubusercontent.com/60056833/111873771-0ffa9400-89b8-11eb-8be2-2ac328356207.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873773-12f58480-89b8-11eb-8d95-7f905b6d8fa5.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873778-15f07500-89b8-11eb-8b46-79abab630f0d.png" width="200" height="400" />  <img src="https://user-images.githubusercontent.com/60056833/111873781-1852cf00-89b8-11eb-807e-05bf63a82d9b.png" width="200" height="400" />

## Getting Started

Project structure:-

```
|- assets { contains icons, images, illustrations }
|- lib
|    |- data
|    |    |- config { contains configuration variables passed at compile-time }
|    |    |- constants { contains app wide constants like asset strings, colors, routes }
|    |    |- services { contains ApiService and StorageService }
|    |- domain
|    |    |- models { contains object models }
|    |    |- repositories { contains repositories according to BLoC architecture pattern }
|    |- presentation { contains UI and BLoC code arranged in folders according to app flow }
|    |    |- components { contains component widgets used throughout the app }
|    |    |- core { contains important classes including the router and the main_app }
|    |- utils { contains utility methods and classes }
|    |-main_development.dart { development entrypoint }
|    |-main_production.dart { production entrypoint }
|- test { contains widget and unit tests arranged in suites }
```

## Setup for development

#### 0. Clone this repo
```
$ git clone https://github.com/mdgspace/codephile-mobile.git
$ cd codephile-mobile
```

#### 1. Get dependencies

Fetch pub dependencies required by the app.

```
$ flutter pub get
```

#### 2. Generate Freezed models

Some of the code in this app is generate by pub tools.

```
$ flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. Run the app

We've added two `.idea` and `.vscode` folders to help you run the app in your IDE of choice. If those aren't working properly, use the following command.

```
$ flutter build apk --flavor development --target lib/main_development.dart
```

## How to Contribute

We'd love to accept your patches and contributions to this project. There are just a few small
guidelines you need to follow.

- When contributing to this repository, please first discuss the change you wish to make via the issues section before starting any major work.
- Once you have started work on any issue open a WIP pull request addressing that issue so that we know that someone is working on it.
- While writing any code for this project ensure that it is well formatted and consistent with the architecture of the rest of the project.
- Please make sure that you use the standard [dart nomenclature](https://dart.dev/guides/language/effective-dart/style).
- Before committing any change make sure their is no compilation warning or error.

## Commit messages

Please start your commits with these prefixes for better understanding among collaborators, based on the type of commit:

- feat: (addition of a new feature)
- rfac: (refactoring the code: optimization/ different logic of existing code - output doesn't change, just the way of execution changes)
- docs: (documenting the code, be it readme, or extra comments)
- bfix: (bug fixing)
- chor: (chore - beautifying code, indents, spaces, camelcasing, changing variable names to have an appropriate meaning)
- ptch: (patches - small changes in code, mainly UI, for example color of a button, incrasing size of tet, etc etc)
- conf: (configurational settings - changing directory structure, updating gitignore, add libraries, changing manifest etc)
- test: (adding or editting tests)
