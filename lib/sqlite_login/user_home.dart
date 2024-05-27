import 'package:flutter/material.dart';
import 'db.dart';
import 'login.dart';

class UserHome extends StatefulWidget {
  final data;

  UserHome({super.key, required this.data});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var name, email;
  var emailControler = TextEditingController();
  var nameControler = TextEditingController();

  @override
  void initState() {
    name = widget.data[0]['name'];
    email = widget.data[0]['email'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateDataByUser() async {
      await SQLFunctions.updateDetailsByUser(widget.data[0]['id'], name, email);
    }

    void editData() {
      setState(() {
        nameControler.text = name;
        emailControler.text = email;
      });
      //to show dialog box
      showDialog(
          context: context,
          builder: (context) {
            //built in method aanu. vnokil pluginns add cheyam
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Edit Data',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: emailControler,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameControler,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          name = nameControler.text;
                          email = emailControler.text;
                        });
                        updateDataByUser();
                        Navigator.of(context).pop();
                        // nameCntrler.text='';
                        //   emailCntrler.text='';
                        // await SQLFunctions.updateDetailsByUser(nameCntrler,emailCntrler);
                      },
                      child: const Text("Edit Details"))
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text('Welcome $name'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                // widget.data[0]['name'],
                '$name',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                // widget.data[0]['email']
                '$email',
              ),
              trailing: IconButton(
                onPressed: () {
                  editData();
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPageSQLite()));
              },
              child: const Text("Log out"))
        ],
      ),
    );
  }
}
