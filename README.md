<h1 align="center">
  APOD - Nasa
</h1>

# :rocket: How to build?

1. Be sure to have flutter installed: https://flutter.dev/

2. Clone the project and go to root the folder.

3. Exec `flutter pub get` to download the dependencies.

4. Be sure to have an emulator or an plugged phone with developer tools activated.

5. Done. To run in debug, exec `flutter run`. In release `flutter run --release`. To build an apk, exec `flutter build apk`.

# :computer: Implementation

## Techs

1. Flutter Modular [https://github.com/Flutterando/modular] for Dependency Injection.
2. Mobx [https://pub.dev/packages/mobx] for state management and reactive.
3. Slidy [https://github.com/Flutterando/slidy] as tool. 
4. Dio [https://pub.dev/packages/dio] for HTTP requests.
5. Shared Preferences [https://pub.dev/packages/shared_preferences] for local storage.

I really like how Flutter Modular is structured (inspired in Angular) combined with the simplicity to deal with reactivity of Mobx. Slidy does'n count as implementation, but this tool helps a lot generating Pages, Modules, and etc.. Flutterando's community has been done a great job maintaining those techs.

## Architecture
I've been studying even more about how to build an software architecture maintainable and scalable. Clean Architecture promotes the independent implementation of each layer of the application, facilitating project maintenance.  

References:
1. Flutter, TDD, Clean Architecture, SOLID e Design Patterns
 [https://www.udemy.com/course/flutter-com-mango/]
2. Flutter TDD Clean Architecture Course [https://www.youtube.com/watch?v=KjE2IDphA_U&list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech]
3. Clean Dart [https://github.com/Flutterando/Clean-Dart]

## Folder structure:
```
├── lib
│   ├── app
│   │   ├── shared
│   │   └── modules
│   ├── core
│   ├── data
│   │   ├── repositories
│   │   ├── models
│   │   ├── local_storage
│   │   └── http
│   ├── domain
│   │   ├── entities
│   │   ├── helpers
│   │   ├── repositories
│   │   └── usecases
│   ├── infra
│   │   ├── shared_preferences
│   │   └── dio
│   └── shared

```

## Abstraction:
<img src="https://github.com/Flutterando/Clean-Dart/raw/master/imgs/img1.png" />

Obs.: I prefere to call `data` what is called `infra` in this image and call `infra` what is called `external`.


## :mailbox_with_mail: License

This project was created for study, fell free to test and use it.
