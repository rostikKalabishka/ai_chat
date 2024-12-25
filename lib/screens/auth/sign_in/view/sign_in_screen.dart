import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/widgets/show_error_message.dart';
import 'package:ai_chat/core/utils/helpers/form_validator.dart';
import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/ui.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
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
    return BlocConsumer<SignInBloc, SignInState>(
      builder: (BuildContext context, SignInState state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: TextWidget(
                label: 'Sign in',
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 24,
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
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
                                  validator: (value) =>
                                      FormValidators.emailValidator(value),
                                  controller: _emailController,
                                  hintText: 'email',
                                  keyboardType: TextInputType.emailAddress),
                              CustomTextField(
                                hintText: 'password',
                                controller: _passwordController,
                                validator: (value) =>
                                    FormValidators.passwordValidator(value),
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
                            _signIn(context);
                          },
                          child: Text(
                            'Sign in',
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
                              const SignUpRoute(),
                              predicate: (route) => false);
                        },
                        child: const Text(
                          'You don`t have account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, SignInState state) {
        if (state is SignInSuccessState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const LoaderRoute(), predicate: (_) => false);
        }
        if (state is SignInFailureState) {
          showError(context, state.error.toString());
        }
      },
    );
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(SingInRequired(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
