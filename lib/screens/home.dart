import 'package:flutter/material.dart';
import 'package:fluttersqlite/models/Users.dart';

class Home extends StatelessWidget {
  final List users;
  Home(this.users);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter SQLite"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, int position) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(children: [
                  Text('ID'),
                  Text('Username'),
                  Text('Password'),
                ]),
                TableRow(children: [
                  Text('${User.fromMap(users[position]).id}'),
                  Text('${User.fromMap(users[position]).username}'),
                  Text('${User.fromMap(users[position]).password}'),
                ])
              ],
            ),
          );
        },
      ),
    );
  }
}
