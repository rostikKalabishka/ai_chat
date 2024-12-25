import 'package:firebase_auth/firebase_auth.dart';

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

String mapErrorToMessage({required Object error}) {
  if (error is ApiClientException) {
    switch (error.type) {
      case ApiClientExceptionType.network:
        return 'The server is not available. Check your internet connection';
      case ApiClientExceptionType.auth:
        return 'Incorrect username or password!';
      case ApiClientExceptionType.other:
        return 'There has been an error. Try again';
    }
  }

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'Invalid email format';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'account-exists-with-different-credential':
        return 'An account already exists with different credentials';
      case 'email-already-in-use':
        return 'This email is already in use';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Password should be at least 8 characters';
      case 'invalid-credential':
        return 'The supplied auth credential is malformed or has expired';
      default:
        return 'Unknown Firebase error. Please try again';
    }
  }

  return 'Unknown error, try again';
}
