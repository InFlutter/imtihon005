import 'package:get_it/get_it.dart';
import 'package:imtihon005/data/repository/auth_repository/auth_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthRepository>(AuthRepository());

// Alternatively you could write it if you don't like global variables
}