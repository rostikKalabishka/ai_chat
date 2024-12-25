import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ui/ui.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _confirmPasswordController;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const LoaderRoute(), predicate: (_) => false);
        }
      },
      builder: (context, state) {
        return BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  title: TextWidget(
                    label: 'Sign up',
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 24,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                            ),
                            Text(
                              'AI changes \nlives — empowering \nthe future today.',
                              style: theme.textTheme.headlineLarge
                                  ?.copyWith(fontSize: 35),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FormCardWidget(
                              child: Column(
                                children: [
                                  CustomTextField(
                                      controller: _nameController,
                                      hintText: 'name',
                                      keyboardType: TextInputType.name),
                                  CustomTextField(
                                      controller: _emailController,
                                      hintText: 'email',
                                      keyboardType: TextInputType.emailAddress),
                                  CustomTextField(
                                    hintText: 'password',
                                    controller: _passwordController,
                                    obscureText: obscurePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined),
                                      onPressed: () {
                                        setState(() {});
                                        obscurePassword = !obscurePassword;
                                      },
                                    ),
                                  ),
                                  CustomTextField(
                                    hintText: 'confirm password',
                                    controller: _confirmPasswordController,
                                    obscureText: obscureConfirmPassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(obscureConfirmPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined),
                                      onPressed: () {
                                        setState(() {});
                                        obscureConfirmPassword =
                                            !obscureConfirmPassword;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CustomButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              width: double.infinity,
                              height: 100,
                              onPressed: () {
                                if (_passwordController.text ==
                                    _confirmPasswordController.text) {
                                  context.read<SignUpBloc>().add(SignUpRequired(
                                      userName: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text));
                                }
                              },
                              child: Text(
                                'Sign up',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: () {
                              AutoRouter.of(context).pushAndPopUntil(
                                  const SignInRoute(),
                                  predicate: (route) => false);
                            },
                            child: const Text(
                              'Do you have an account already?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
