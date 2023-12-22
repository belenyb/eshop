import 'package:ecommerce_app/resources/app_provider.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../widgets/login_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 230,
                  child: Image.asset(
                    'assets/images/eshop-logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height * 0.12)),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: LoginFormField(
                        theme: theme,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        controller: emailController,
                        labelText: 'Username',
                        hintText: 'Enter username',
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: LoginFormField(
                          theme: theme,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field is required';
                            }
                            return null;
                          },
                          hintText: 'Enter secure password',
                          labelText: 'Password',
                        )),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height * 0.12)),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final Map<String, String> loginBody = {
                            "username": emailController.text,
                            "password": passwordController.text
                          };

                          final isLoginOk = await appProvider.login(loginBody);

                          if (isLoginOk && mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          } else {
                            final SnackBar snackBar = getSnackbar(
                                theme, 'error', 'Wrong credentials');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: theme.textTheme.titleMedium!
                                .copyWith(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
