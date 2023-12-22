import 'package:ecommerce_app/screens/home.dart';
import 'package:flutter/material.dart';

import '../widgets/login_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                          } else {
                            final isValidEmail = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            return isValidEmail
                                ? null
                                : 'Please enter a valid email';
                          }
                        },
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com',
                      ),
                    ),
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
                          hintText: 'Enter secure password',
                          labelText: 'Password',
                        )),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height * 0.12)),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // TODO conectar con api
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()));
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
