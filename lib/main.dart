import 'package:flutter/material.dart';
// import 'package:fluttersqlite/models/Users.dart';
import 'package:fluttersqlite/screens/home.dart';
import 'package:fluttersqlite/utils/database_helper.dart';

import 'models/Users.dart';
// import 'package:fluttersqlite/utils/database_helper.dart';

List _users;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = new DataBaseHelper();

  // ---------- Saving Users' Data ----------
  // await db.saveUser(new User("Arslan", "Kaleem"));
  // await db.saveUser(new User("Noman", "Kaleem"));
  // await db.saveUser(new User("Shehzad", "Tariq"));
  // await db.saveUser(new User("Ammar", "Nazar"));

  // ---------- Retriving ALL User ----------

  _users = await db.getAllUsers();
  for (var i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("Id :${user.id}");
    print("Username :${user.username}");
    print("Password :${user.password}");
  }

  // ---------- Retriving a User ----------

  // User arslan = await db.getUser(1);
  // print(arslan);
  // print("${arslan.username}");

// ---------- Deleting a User ----------

  // await db.deleteUser(1);
  // _users = await db.getAllUsers();
  // for (var i = 0; i < _users.length; i++) {
  //   User user = User.map(_users[i]);
  //   print("Id :${user.id}");
  //   print("Username :${user.username}");
  //   print("Password :${user.password}");
  // }

// ---------- Update User Data ----------

  // User noman = await db.getUser(2);
  // User nomanUpdated = User.fromMap(
  //     {"username": "username Updated", "password": "passwordUpdated", "id": 2});
  // await db.updateData(nomanUpdated);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(_users),
    );
  }
}
