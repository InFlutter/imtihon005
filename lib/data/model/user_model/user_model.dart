import '../recep_model/recep_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String uid;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      password: json['password'] as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    List<RecepModel>? recepModel,
    String? uid,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      uid: uid ?? this.uid,
    );
  }

  static UserModel initialValue() => UserModel(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    password: '',
    uid: '',
  );
}
