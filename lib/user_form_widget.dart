import 'package:excel_example/button_widget.dart';
import 'package:excel_example/user.dart';
import 'package:flutter/material.dart';

import 'gamepage.dart';

class UserFormWidget extends StatefulWidget {
  // const UserFormWidget({super.key});

  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerChildName;
  late bool isBoy;
  late bool rightHanded;
  late TextEditingController controllerAge;
  late TextEditingController controllerTesterName;
  late TextEditingController controllerKinderGardenName;
  late TextEditingController controllerTestType;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() {
    controllerChildName = TextEditingController();
    isBoy = true;
    rightHanded = true;
    controllerAge = TextEditingController();
    controllerTesterName = TextEditingController();
    controllerKinderGardenName = TextEditingController();
    controllerTestType = TextEditingController();

  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(
              height: 16,
            ),
            buildAge(),
            const SizedBox(
              height: 16,
            ),
            buildTesterName(),
            const SizedBox(
              height: 16,
            ),
            buildKinderGardenName(),
            const SizedBox(
              height: 16,
            ),
            buildTestType(),
            const SizedBox(
              height: 16,
            ),
            buildIsBoy(),
            const SizedBox(
              height: 16,
            ),
            buildRightHanded(),
            const SizedBox(
              height: 16,
            ),
            buildSubmit(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerChildName,
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Child Name' : null,
      );

  Widget buildAge() => TextFormField(
        controller: controllerAge,
        decoration: InputDecoration(
          labelText: 'Age',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Age' : null,
      );

  Widget buildTesterName() => TextFormField(
        controller: controllerTesterName,
        decoration: InputDecoration(
          labelText: 'Tester Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Tester Name' : null,
      );

  Widget buildKinderGardenName() => TextFormField(
        controller: controllerKinderGardenName,
        decoration: InputDecoration(
          labelText: 'kinder Garden Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Kinder Garden Name' : null,
      );

  Widget buildTestType() => TextFormField(
        controller: controllerTestType,
        decoration: InputDecoration(
          labelText: 'Test Type',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Test Type' : null,
      );

  Widget buildIsBoy() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isBoy,
        title: Text('Is Boy?'),
        onChanged: (value) => setState(() {
          isBoy = value;
        }),
      );

  Widget buildRightHanded() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: rightHanded,
        title: Text('Right Handed?'),
        onChanged: (value) => setState(() {
          rightHanded = value;
        }),
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final user = User(
              // id: 1,
              childName: controllerChildName.text,
              age: controllerAge.text,
              isBoy: isBoy,
              rightHanded: rightHanded,
              testerName: controllerTesterName.text,
              kinderGardenName: controllerKinderGardenName.text,
              testType: controllerTestType.text,
              correctAnswers: 0,
              wrongAnswers: 0,
            );
            widget.onSavedUser(user);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => GamePage()));
          }
        },
      );
}
