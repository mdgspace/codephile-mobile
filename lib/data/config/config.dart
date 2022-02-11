class Environment {
  /// URL that is common to most outgoing requests.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://codephile-test.herokuapp.com/v1/',
  );

  /// Project identifier for Sentry error logging.
  static const String sentryDSN = String.fromEnvironment('SENTRY_DSN');
}
