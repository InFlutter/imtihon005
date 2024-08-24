import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/tab_box_cubit/tab_box_cubit.dart';
import 'package:imtihon005/screen/auth/login/login_screen.dart';
import 'package:imtihon005/services/firebase_options.dart';
import 'package:imtihon005/services/services_locator.dart';

import 'cubit/auth_cubit/auth_cubit.dart';
import 'cubit/user_cubit/user_cubit.dart';
import 'cubit/recep_cubit/recep_cubit.dart'; // RecepCubit'ni import qilish

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => TabBoxCubit()),
        BlocProvider(create: (_) => RecepCubit()), // RecepCubit'ni qo'shish
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
