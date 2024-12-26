import 'package:ai_chat/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

String mapErrorToMessage(
    {required Object error, required BuildContext context}) {
  if (error is ApiClientException) {
    switch (error.type) {
      case ApiClientExceptionType.network:
        return S.of(context).theServerIsNotAvailableCheckYourInternetConnection;
      case ApiClientExceptionType.auth:
        return S.of(context).incorrectUsernameOrPassword;
      case ApiClientExceptionType.other:
        return S.of(context).thereHasBeenAnErrorTryAgain;
    }
  }

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return S.of(context).invalidEmailFormat;
      case 'user-not-found':
        return S.of(context).noUserFoundWithThisEmail;
      case 'wrong-password':
        return S.of(context).incorrectPassword;
      case 'account-exists-with-different-credential':
        return S.of(context).anAccountAlreadyExistsWithDifferentCredentials;
      case 'email-already-in-use':
        return S.of(context).thisEmailIsAlreadyInUse;
      case 'operation-not-allowed':
        return S.of(context).operationNotAllowed;
      case 'weak-password':
        return S.of(context).passwordShouldBeAtLeast8Characters;
      case 'invalid-credential':
        return S.of(context).theSuppliedAuthCredentialIsMalformedOrHasExpired;
      default:
        return S.of(context).unknownFirebaseErrorPleaseTryAgain;
    }
  }

  return 'Unknown error, try again';
}
