import 'package:ecommerce_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resources/app_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Colors.black,
            background: Colors.red,
            brightness: Brightness.light,
            error: Color.fromARGB(255, 177, 12, 0),
            onBackground: Colors.white,
            onError: Colors.black,
            onPrimary: Colors.white,
            onSecondary: Colors.orange,
            onSurface: Colors.white,
            secondary: Colors.red,
            surface: Colors.red,
          ),
          primaryColor: Colors.black,
          scaffoldBackgroundColor: const Color(0xfff4f4f4),
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
