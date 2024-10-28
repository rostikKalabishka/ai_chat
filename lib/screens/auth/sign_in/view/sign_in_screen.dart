import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/ui.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (BuildContext context, SignInState state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: const Text('Sign in'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  Text(
                    'AI changes \nlives — empowering \nthe future today.',
                    style:
                        theme.textTheme.headlineLarge?.copyWith(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormCardWidget(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'email',
                        ),
                        CustomTextField(
                          hintText: 'password',
                          controller: _passwordController,
                          obscureText: true,
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
                      context.read<SignInBloc>().add(SingInRequired(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: Text(
                      'Sign in',
                      style:
                          theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
