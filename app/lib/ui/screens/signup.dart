import 'package:app/global.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    String _email, _password, _username;
    return Scaffold(
      backgroundColor: MyColors.darkBlue,
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
            children: <Widget>[
              Text(
                "Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 9),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _email = value,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Cannot be empty";
                        else
                          return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: "Email Address",
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
                      onSaved: (value) => _username = value,
                      validator: (value) {
                        if (value.isEmpty)
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
                      onSaved: (value) => _password = value,
                      onChanged: (value) => _password = value,
                      validator: (value) {
                        if (value.isEmpty)
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
                    SizedBox(height: 11),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty && value == _password)
                          return "Cannot be empty";
                        else
                          return null;
                      },
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: "Confirm Password",
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
              SizedBox(height: 11),
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
                        child: RaisedButton(
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
                                      .button
                                      .copyWith(color: Colors.white),
                                ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (await snapshot.signup(
                                  username: _username,
                                  email: _email,
                                  password: _password))
                                Navigator.pushReplacementNamed(context, 'home');
                            }
                          },
                          color: MyColors.accentBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
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
                        .headline6
                        .copyWith(color: Colors.white),
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
                    "Already have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  ),
                  FlatButton(
                    child: Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: MyColors.accentBlue),
                    ),
                    onPressed: () {
                      Provider.of<AuthService>(context, listen: false).clear();
                      Navigator.pushNamed(context, 'login');
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
