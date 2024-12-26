import 'package:ai_chat/core/errors/exception.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/widgets/show_error_message.dart';
import 'package:ai_chat/core/utils/helpers/form_validator.dart';
import 'package:ai_chat/generated/l10n.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        if (state is SignUpFailureState) {
          showError(
              context, mapErrorToMessage(error: state.error, context: context));
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
                    label: S.of(context).signUp,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                              ),
                              Text(
                                S.of(context).slogan,
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
                                            FormValidators.usernameValidator(
                                                value, context),
                                        controller: _nameController,
                                        hintText: S.of(context).nameHintText,
                                        keyboardType: TextInputType.name),
                                    CustomTextField(
                                        validator: (value) =>
                                            FormValidators.emailValidator(
                                                value, context),
                                        controller: _emailController,
                                        hintText: S.of(context).emailHintText,
                                        keyboardType:
                                            TextInputType.emailAddress),
                                    CustomTextField(
                                      validator: (value) =>
                                          FormValidators.passwordValidator(
                                              value, context),
                                      hintText: S.of(context).passwordHintText,
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
                                      validator: (value) => FormValidators
                                          .confirmPasswordValidator(
                                              value!,
                                              _passwordController.text,
                                              context),
                                      hintText:
                                          S.of(context).confirmPasswordHintText,
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
                                  _registration(context);
                                },
                                child: Text(
                                  S.of(context).signUp,
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
                              child: TextWidget(
                                label: S.of(context).doYouHaveAnAccountAlready,
                                color: theme.textTheme.titleMedium?.color,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _registration(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(SignUpRequired(
          userName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text));
    }
  }
}
