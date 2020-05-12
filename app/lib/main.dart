import 'package:app/global.dart';
import 'package:app/services/auth.dart';
import 'package:app/ui/screens/home.dart';
import 'package:app/ui/screens/login.dart';
import 'package:app/ui/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    _authService.getSavedToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authService,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: MyColors.darkBlue,
        ),
        home: Consumer<AuthService>(
          builder: (context, snapshot, _) {
            switch (snapshot.status) {
              case LoginStatus.loggedIn:
                return HomeScreen();
              case LoginStatus.idle:
                return LoginScreen();
              default:
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          },
        ),
        routes: {
          'login': (context) => LoginScreen(),
          'signup': (context) => SignupScreen(),
          'home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
