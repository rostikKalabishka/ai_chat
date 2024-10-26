import 'package:flutter/material.dart';

import '../../../../../core/ui/ui.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: const Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(
                'AI changes \nlives — empowering \nthe future today.',
                style: theme.textTheme.headlineLarge?.copyWith(fontSize: 35),
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
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'email',
                    ),
                    CustomTextField(
                      hintText: 'password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    CustomTextField(
                      hintText: 'confirm password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                    )
                  ],
                ),
              ),
              CustomButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: double.infinity,
                height: 100,
                onPressed: () {},
                child: Text(
                  'Sign in',
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
