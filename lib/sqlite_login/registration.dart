import 'package:flutter/material.dart';
import 'db.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: RegistrationPageSQLite(),
    debugShowCheckedModeBanner: false,
  ));
}

class RegistrationPageSQLite extends StatelessWidget {
  // RegistrationPageSQLite({super.key});
  // var formKey = GlobalKey<FormState>();
  // var nameController = TextEditingController();
  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();
  //doubt
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void registerUser(String name, String email, String password) async {
      var id = await SQLFunctions.addUsers(
          name, email, password); //id that return when we add new users
      // if (kDebugMode) {
      print(id);
      // }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPageSQLite()));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Registration Page'),
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
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                    onPressed: () async {
                      var valid = formKey.currentState!.validate();
                      if (valid == true) {
                        var users =
                            await SQLFunctions.checkUserAlreadyRegistered(
                                emailController.text);
                        if (users.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("User Already Registered")));
                        } else {
                          registerUser(nameController.text,
                              emailController.text, passwordController.text);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Verify the details')));
                      }
                    },
                    child: const Text('Register')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPageSQLite()));
                    },
                    child: const Text('Already have an account?\nLogin Now'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
