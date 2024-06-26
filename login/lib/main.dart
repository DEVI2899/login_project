import 'package:flutter/material.dart';
import 'package:login/authcontroller/auth_controller.dart';
import 'package:login/view/login_screen.dart';
import 'package:login/view/scanner_page.dart';
import 'package:login/view/url_page.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => AuthController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/' :(context) => const LoginScreen(),
          '/scanner' :(context) => const ScannerPage(),

        },
        //home: const testing(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


