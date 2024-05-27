
import 'package:flutter/material.dart';
import 'package:sqflite_login/sqlite_login/registration.dart';
import 'package:sqflite_login/sqlite_login/user_home.dart';

import 'admin_home.dart';
import 'db.dart';

class LoginPageSQLite extends StatelessWidget {
  // const LoginPageSQLite({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void loginUser(String email, String password) async {
      //admin login
      if (email == 'admin@1' && password == '123456') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AdminHome()));
      } else {
        //Check if user exist in database db
        var data = await SQLFunctions.checkUserExit(email, password);
        if (data.isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserHome(data: data)));
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (email) {
                    if (email!.isEmpty || !email.contains('@')) {
                      return 'Invalid Email(should contain @)';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return 'Password should be minimum of 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      var valid = formKey.currentState!.validate();
                      if (valid == true) {
                        loginUser(
                            emailController.text, passwordController.text);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Error'),
                        ));
                      }
                    },
                    child: const Text('Login')),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPageSQLite()));
                    },
                    child: const Text("Don't have an account\n Register Now"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
