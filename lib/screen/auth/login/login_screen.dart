import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/tab_box_cubit/tab_box_cubit.dart';
import 'package:imtihon005/screen/auth/register/register_screen.dart';
import 'package:imtihon005/screen/tab_box/tab_box_screen.dart';
import '../../../cubit/auth_cubit/auth_cubit.dart';
import '../../../cubit/auth_cubit/auth_state.dart';
import '../../../data/model/forms_status.dart';
import '../../../utils/color/app_colors.dart';
import '../../../utils/style/app_text_style.dart';
import '../../widgets/global_button.dart';
import '../widget/input_text.dart';
import '../widget/row_button_item.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint("____________________________________----build run");
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.c356899.withOpacity(0.6),
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(right: 29, left: 29, top: 102),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              builder: (BuildContext context, AuthState state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Welcome Back',
                          style: AppTextStyle.semiBold.copyWith(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                        style: AppTextStyle.regular.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Text(
                        'Email',
                        style: AppTextStyle.semiBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                        controller: _emailController,
                        title: 'Email',
                        errorText: "Maydon bo'sh bo'lishi mumkin emas",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Parol',
                        style: AppTextStyle.semiBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                        controller: _passwordController,
                        title: 'Parol',
                        isPassword: true,
                        errorText: "Kamida bita kata harf va raqam qatnashsin",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      globalButton(
                        title: 'Login',
                        onTap: state.status == FormsStatus.success
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                }
                              },
                        buttonHeight: 16,
                        buttonWidth: 125,
                        isLoading: state.status == FormsStatus.loading,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: rowButtonItem(
                          onTap: state.status == FormsStatus.error
                              ? () {
                                  context.read<AuthCubit>().initialState();
                                }
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  );
                                },
                          login: true,
                        ),
                      )
                    ],
                  ),
                );
              },
              listenWhen: (lastState, currentState) {
                if (currentState.status == FormsStatus.error ||
                    currentState.status == FormsStatus.success) {
                  return true;
                } else {
                  return false;
                }
              },
              listener: (BuildContext context, AuthState state) {
                if (state.status == FormsStatus.success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TabBoxScreen(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
