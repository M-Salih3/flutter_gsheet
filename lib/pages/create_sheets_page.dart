import 'package:database/api/user_sheet_api.dart';
import 'package:database/model/user.dart';
import 'package:database/widget/button_widget.dart';
import 'package:database/widget/user_form_widget.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatefulWidget {
  @override
  State<CreateSheetsPage> createState() => _CreateSheetsPageState();
}

class _CreateSheetsPageState extends State<CreateSheetsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('title'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: UserFormWidget(
              onSavedUser: (user) async {
                final id = await UserSheetsApi.getRowCount() + 1;
                final newUser = user.copy(id: id);
                await UserSheetsApi.insert([newUser.toJson()]);
              },
            ),
          ),
        ),
      );
  // Future insertUsers() async {
  //   final users = [
  //     User(
  //       id: "1112",
  //       password: 'hello',
  //       name: 'ahgas',
  //       phoneNumber: "877889",
  //       isAbsent: true,
  //     ),
  //     User(
  //       id: "1113",
  //       password: 'hell',
  //       name: 'ahafs',
  //       phoneNumber: "877889",
  //       isAbsent: true,
  //     ),
  //     User(
  //       id: "1114",
  //       password: 'helo',
  //       name: 'ahafgs',
  //       phoneNumber: "877889",
  //       isAbsent: true,
  //     ),
  //     User(
  //       id: "1115",
  //       password: 'hlo',
  //       name: 'ahasvvf',
  //       phoneNumber: "878889",
  //       isAbsent: true,
  //     ),
  //   ];
  //   final jsonUsers = users.map((user) => user.toJson()).toList();

  //   await UserSheetsApi.insert(jsonUsers);
  // }
}
