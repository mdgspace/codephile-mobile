fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android internal

```sh
[bundle exec] fastlane android internal
```

Push a new internal build to Play Store

### android beta

```sh
[bundle exec] fastlane android beta
```

Push a new beta build to Play Store

### android prod

```sh
[bundle exec] fastlane android prod
```

Push a new production build to Play Store

### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android beta_test

```sh
[bundle exec] fastlane android beta_test
```

Submit a new Beta Build to Crashlytics Beta

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
