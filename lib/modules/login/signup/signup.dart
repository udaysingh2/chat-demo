import 'package:chatdemo/Common/advanced_bloc/BlocBuilder.dart';
import 'package:chatdemo/animation/FadeAnimation.dart';
import 'package:chatdemo/models/user_model.dart';
import 'package:chatdemo/modules/login/signup/signup_bloc.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignUpBloc _signUpBloc = SignUpBloc();
  final _formKey = GlobalKey<FormState>();
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: _signUpBloc,
          builder: () {
            if (_signUpBloc.state.loginState == SignUpState.submitting) {
              return Center(child: CircularProgressIndicator());
            } else if (_signUpBloc.state.loginState == SignUpState.success) {
              return Center(child: Text("Signed Up successfully"));
            } else {
              return SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1,
                            Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.2,
                            Text(
                              "Create an account, It's free",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            )),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1.2, makeInput(label: "Email")),
                          FadeAnimation(1.3,
                              makeInput(label: "Password", obscureText: true)),
                          FadeAnimation(
                              1.4,
                              makeInput(
                                  label: "Confirm Password",
                                  obscureText: true)),
                        ],
                      ),
                    ),
                    FadeAnimation(
                        1.5,
                        Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _signUpBloc.signUpClicked(user);
                              }
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        )),
                    FadeAnimation(
                        1.6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account?"),
                            Text(
                              " Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ],
                        )),
                  ],
                ),
              ));
            }
          }),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
          onChanged: (value) {
            if (label == "Email") {
              user.email = value;
              print("user.email = ${user.email}");
            } else if (label == "Password") {
              user.password = value;
              print("user.password = ${user.password}");
            }
            print("User = $user");
          },
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Text is empty';
            }
            return null;
          },
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
