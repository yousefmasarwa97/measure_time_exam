import 'package:excel_example/main.dart';
import 'package:excel_example/user_form_widget.dart';
import 'package:excel_example/user_sheets_api.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatelessWidget {
  const CreateSheetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: UserFormWidget(
            onSavedUser: (user) async {
              final id = await UserSheetsApi.getRowCount() + 1;
              final newUser = user.copy(id : id);
              await UserSheetsApi.insert([newUser.toJson()]);
              // await UserSheetsApi.update(user.childName, user.toJson());
            },
          ),
        ),
      ),
    );
  }

  // Future insertUsers() async {
  //   final users = [
  //     User(
  //       childName: 'adnan',
  //       isBoy: true,
  //       rightHanded: false,
  //       age: '22',
  //       testerName: 'moka',
  //       kinderGardenName: 'dodo',
  //       testType: '1',
  //     )
  //   ];
  //   final jsonUsers = users.map((user) => user.toJson()).toList();
  //   await UserSheetsApi.insert(jsonUsers);
  // }
}
