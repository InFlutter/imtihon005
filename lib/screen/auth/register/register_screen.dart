import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/user_cubit/user_cubit.dart';
import 'package:imtihon005/screen/auth/login/login_screen.dart';
import 'package:imtihon005/screen/tab_box/tab_box_screen.dart';
import '../../../cubit/auth_cubit/auth_cubit.dart';
import '../../../cubit/auth_cubit/auth_state.dart';
import '../../../cubit/user_cubit/user_state.dart';
import '../../../data/model/forms_status.dart';
import '../../../data/model/user_model/user_model.dart';
import '../../../utils/color/app_colors.dart';
import '../../../utils/style/app_text_style.dart';
import '../../widgets/global_button.dart';
import '../widget/input_text.dart';
import '../widget/row_button_item.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
          padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
          child: SingleChildScrollView(
            child: MultiBlocListener(
              listeners: [
                BlocListener<AuthCubit, AuthState>(
                  listenWhen: (previous, current) =>
                      current.status == FormsStatus.success ||
                      current.status == FormsStatus.error,
                  listener: (context, state) {
                    if (state.status == FormsStatus.success) {
                      UserModel userModel = UserModel.initialValue();
                      userModel = userModel.copyWith(
                        uid: state.user!.uid,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      context
                          .read<UserCubit>()
                          .insertUser(userModel: userModel);
                    }
                    if (state.status == FormsStatus.error) {}
                  },
                ),
                BlocListener<UserCubit, UserState>(
                  listenWhen: (previous, current) =>
                      current.status == FormsStatus.success,
                  listener: (context, state) {
                    if (state.status == FormsStatus.success) {
                      debugPrint(
                          'User docId register ____________________________________ ${state.userModel.uid}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TabBoxScreen(),
                        ),
                      );
                    }
                    if (state.status == FormsStatus.error) {
                      debugPrint(
                          'User docId error ____________________________________ ${state.errorMessage}');
                    }
                  },
                ),
              ],
              child: BlocBuilder<AuthCubit, AuthState>(
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
                          height: 11,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                          style: AppTextStyle.regular.copyWith(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Ism',
                          style: AppTextStyle.semiBold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputText(
                                controller: _firstNameController,
                                title: 'Birinchi Ism',
                                errorText: "Maydon bo'sh bo'lishi mumkin emas",
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: InputText(
                                controller: _lastNameController,
                                title: 'Familya',
                                errorText: "Maydon bo'sh bo'lishi mumkin emas",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
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
                          errorText: "example@gmail.com",
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
                          errorText:
                              "Kamida bita katta harf va raqam qatnashsin",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        globalButton(
                          title: "Ro'yxatdan o'tish",
                          onTap: state.status == FormsStatus.success
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().register(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          name: _firstNameController.text,
                                        );
                                  }
                                },
                          buttonHeight: 16,
                          buttonWidth: 70,
                          isLoading: state.status == FormsStatus.loading
                              ? true
                              : state.status == FormsStatus.error
                                  ? false
                                  : false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: state.status == FormsStatus.pure,
                          child: globalButton(
                            onTap: () {
                            },
                            title: 'Endi Royxatdan Otishni bosing',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: rowButtonItem(
                            onTap: state.status == FormsStatus.loading
                                ? () {}
                                : () {
                                    context.read<AuthCubit>().initialState();
                                  },
                            login: false,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
