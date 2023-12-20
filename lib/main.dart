import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resources/api_provider.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme(
              primary: Colors.black,
              background: Colors.red,
              brightness: Brightness.light,
              error: Colors.green,
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
        home: const HomeScreen(),
      ),
    );
  }
}
