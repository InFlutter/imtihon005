import 'package:imtihon005/data/model/forms_status.dart';

import '../../data/model/user_model/user_model.dart';

class UserState {
  final String errorMessage;
  final FormsStatus status;
  final UserModel userModel;

  UserState({
    required this.errorMessage,
    required this.status,
    required this.userModel,
  });

  UserState copyWith({
    String? errorMessage,
    FormsStatus? status,
    UserModel? userModel,
  }) {
    return UserState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      userModel: userModel?? this.userModel,
    );
  }

  static UserState initial() {
    return UserState(
      errorMessage: '',
      status: FormsStatus.pure,
      userModel: UserModel.initialValue(),
    );
  }
}
