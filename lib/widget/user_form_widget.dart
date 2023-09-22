import 'package:database/model/user.dart';
import 'package:database/widget/button_widget.dart';
import 'package:flutter/material.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formkey = GlobalKey<FormState>();
  // late TextEditingController controllerId ;
  late TextEditingController controllerName;
  late TextEditingController controllerPassword;
  late TextEditingController controllerPhoneNumber ;
  late bool isAbsent;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final password = widget.user == null ? '' : widget.user!.password;
    final name = widget.user == null ? '' : widget.user!.name;
    final isAbsent = widget.user == null ? true : widget.user!.isAbsent;

    setState(() {
      
      controllerPassword = TextEditingController(text: password);
      controllerName = TextEditingController(text: name);
      this.isAbsent = isAbsent;
    });
    print(controllerName);
    print(controllerPassword);
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // buildId(),
            // const SizedBox(height: 16),
            buildPassword(),
            const SizedBox(height: 16),
            buildName(),
            const SizedBox(height: 16),
            // buildPhoneNumber(),
            // const SizedBox(height: 16),
            buildFlutterBeginner(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      );

  Widget buildPassword() => TextFormField(
        controller: controllerPassword,
        decoration: InputDecoration(
          labelText: 'password',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter password' : null,
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  // Widget buildPhoneNumber() => TextFormField(
  //       controller: controllerPhoneNumber,
  //       decoration: InputDecoration(
  //         labelText: 'PhoneNumber',
  //         border: OutlineInputBorder(),
  //       ),
  //       validator: (value) =>
  //           value != null && value.isEmpty ? 'Enter PhoneNumber' : null,
  //     );

  Widget buildFlutterBeginner() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isAbsent,
        title: Text('is Flutter beginner ?'),
        onChanged: (value) => setState(() => isAbsent = value),
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formkey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final user = User(
              id: 1,
              name: controllerName.text,
              password: controllerPassword.text,
              phoneNumber: controllerPhoneNumber.text,
              isAbsent: isAbsent,
            );
            widget.onSavedUser(user);
          }
        },
      );
}
