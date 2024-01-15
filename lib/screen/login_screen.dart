import 'package:connect_api/models/user.dart';
import 'package:connect_api/services/remote_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var _isSending = false;
  LoginData? loginModel;

  _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
    }
    loginModel = await RemoteService().login(email, password);

    // Navigator.of(context).pop(LoginData(
    //     status: loginModel!.status,
    //     message: loginModel!.message,
    //     token: loginModel!.token,
    //     type: loginModel!.type,
    //     expiresIn: loginModel!.expiresIn));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('User Name')),
                  validator: (email) {
                    if (email == null ||
                        email.isEmpty ||
                        email.trim().length <= 1 ||
                        email.trim().length > 50) {
                      return 'Must be between 1 and 50 characters';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                ),
                Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Password')),
                      validator: (password) {
                        if (password == null ||
                            password.isEmpty ||
                            password.trim().length <= 1 ||
                            password.trim().length > 50) {
                          return 'Must be between 1 and 50 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue!;
                      },
                    )
                  ],
                ),
                Column(children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: _isSending ? null : _login,
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
