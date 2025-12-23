

// import 'package:flutter/services.dart';
// import 'package:movie_app/constants/common_string.dart';

// String handleExceptionError(error) {
//   if (error is PlatformException) {
//     switch (error.code) {
//       case 'ERROR_OPERATION_NOT_ALLOWED':
//         return CommonString.googleSignInNotEnabled;
//       case 'ERROR_INVALID_CREDENTIAL':
//         return CommonString.invalidGoogleToken;
//       case 'ERROR_NETWORK_REQUEST_FAILED':
//         return CommonString.networkError;
//       case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
//         return CommonString.accountExistsWithDifferentCredential;
//       case 'ERROR_INVALID_EMAIL':
//         return CommonString.invalidEmail;
//       case 'ERROR_WRONG_PASSWORD':
//         return CommonString.wrongPassword;
//       case 'ERROR_TOO_MANY_REQUESTS':
//         return CommonString.tooManyRequests;
//       case 'ERROR_USER_DISABLED':
//         return CommonString.userDisabled;
//       case 'ERROR_USER_NOT_FOUND':
//         return CommonString.userNotFound;
//       case 'ERROR_INVALID_ACTION_CODE':
//         return CommonString.invalidActionCode;
//       case 'ERROR_CANCELED':
//         return CommonString.operationCanceled;
//       case 'ERROR_LOGIN_FAILED':
//         return CommonString.loginFailed;
//       case 'ERROR_NETWORK_ERROR':
//         return CommonString.networkError;
//       case 'ERROR_PERMISSION_DENIED':
//         return CommonString.permissionDenied;
//       case 'ERROR_APP_NOT_AUTHORIZED':
//         return CommonString.appNotAuthorized;
//       default:
//         return CommonString.unknownError;
//     }
//   } else if (error is FirebaseAuthException) {
//     switch (error.code) {
//       case 'email-already-in-use':
//         return CommonString.emailAlreadyInUse;
//       case 'invalid-email':
//         return CommonString.invalidEmail;
//       case 'weak-password':
//         return CommonString.weakPassword;
//       case 'invalid-credential':
//         return CommonString.invalidCredential;
//       case 'account-exists-with-different-credential':
//         return CommonString.accountExists;
//       case 'network-request-failed':
//         return CommonString.networkError;
//       case 'wrong-password':
//         return CommonString.incorrectPassword;
//       case 'user-not-found':
//         return CommonString.userNotFound;
//       case 'too-many-requests':
//         return CommonString.tooManyRequests;
//       case 'user-disabled':
//         return CommonString.userDisabled;
//       case 'operation-not-allowed':
//         return CommonString.operationNotAllowed;
//       default:
//         return CommonString.unknownError;
//     }
//   }
//   return CommonString.somethingWentWrong;
// }
