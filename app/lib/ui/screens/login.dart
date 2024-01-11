import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _username = "", _password = "";
    return Scaffold(
      backgroundColor: MyColors.darkBlue,
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
            children: <Widget>[
              Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 9),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _username = value!,
                      validator: (value) {
                        if (value != null && value.isEmpty)
                          return "Cannot be empty";
                        else
                          return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: "Username",
                        fillColor: Colors.white.withOpacity(.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    TextFormField(
                      onSaved: (value) => _password = value!,
                      validator: (value) {
                        if (value != null && value.isEmpty)
                          return "Cannot be empty";
                        else
                          return null;
                      },
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: "Password",
                        fillColor: Colors.white.withOpacity(.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: MyColors.accentBlue),
                  ),
                  onPressed: () async {
                    _formKey.currentState!.save();
                  },
                ),
              ),
              Consumer<AuthService>(
                builder: (context, snapshot, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (snapshot.status == LoginStatus.error)
                        Text(
                          "${snapshot.error}",
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: snapshot.status == LoginStatus.loading
                              ? SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Sign In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (await snapshot.login(
                                  password: _password, username: _username))
                                Navigator.pushReplacementNamed(context, 'home');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.accentBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 11),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 3,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 9),
                  Text(
                    "or",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Container(
                      height: 3,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  TextButton(
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: MyColors.accentBlue),
                    ),
                    onPressed: () {
                      Provider.of<AuthService>(context, listen: false).clear();
                      Navigator.pushNamed(context, 'signup');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
