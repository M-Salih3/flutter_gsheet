// ignore_for_file: avoid_print

import 'package:database/api/user_sheet_api.dart';
import 'package:database/main.dart';
import 'package:database/model/user.dart';
import 'package:database/widget/user_form_widget.dart';
import 'package:flutter/material.dart';

class ModifySheetsPage extends StatefulWidget {
  @override
  _ModifySheetsPageState createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  List<User> user = [];
  int index = 0;

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  Future getUsers() async {
    
    final user = await UserSheetsApi.getById(2);
    

    print(user!.toJson());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('title'),
          centerTitle: true,
        ),
        body: Center(
            child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            UserFormWidget(
              user: users.isEmpty ? null : users[index],
              onSavedUser: (user) async {},
            ),
            // const SizedBox(height: 16),
            // if (users.isNotEmpty) buildUserControls(),
          ],
        )),
      );
  // Widget buildUserControls() => NavigateUsersWidget(
  //       text: '${index + 1}/${users.length} Users',
  //       onClickedNext: () {},
  //       onClickedPrevious: () {},
  //     );
}
