class NotAuthenticatedException implements Exception {
  const NotAuthenticatedException();

  @override
  String toString() =>
      'NotAuthenticatedException: user is not authenticated in the app';
}
