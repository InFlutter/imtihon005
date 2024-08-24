import 'package:firebase_auth/firebase_auth.dart';
import 'package:imtihon005/data/model/forms_status.dart';

class AuthState {
  final String errorMessage;
  final User? user;
  final FormsStatus status;

  AuthState({
    required this.errorMessage,
    required this.user,
    required this.status,
  });

  AuthState copyWith({
    String? errorMessage,
    User? uid,
    FormsStatus? status,
  }) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      user: uid ?? this.user,
      status: status ?? this.status,
    );
  }

  static AuthState initial() {
    return AuthState(
      errorMessage: '',
      user: null,
      status: FormsStatus.pure,
    );
  }
}
