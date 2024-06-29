class ServerException implements Exception {}

// class AuthException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class OrderException implements Exception {
  final String message;
  OrderException({required this.message});
}

class ReviewException implements Exception {
  final String message;
  ReviewException({required this.message});
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
