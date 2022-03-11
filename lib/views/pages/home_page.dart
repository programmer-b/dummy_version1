// ignore_for_file: prefer_const_constructors, prefer_const_declarations, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_print, import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:dummy_12/api/server/version1.dart';
import 'package:dummy_12/components/dialog/dialog.dart';
import 'package:dummy_12/components/forms/multi_form.dart';
import 'package:dummy_12/model/applications.dart';
import 'package:dummy_12/model/utils.dart';
import 'package:dummy_12/views/pages/login_page.dart';

var indexClicked = 0;
final LocalStorage apps = LocalStorage('apps');
final LocalStorage login = LocalStorage('loginData');

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Applications> futureApps = GET.fetchApps();

  Timer? timer;
  var apps_map = apps.getItem('applications');

  String initTitle = "Dashboard";

  final padding = EdgeInsets.symmetric(horizontal: 20);
  final name = 'CrackIt';
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  get z => null;

  Function updateState(int index) {
    return () {
      setState(() {
        indexClicked = index;
      });
      Navigator.pop(context);
    };
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progress = ProgressDialog(context);
    progress.style(
        message: "Authenticating...",
        messageTextStyle: TextStyle(fontSize: 14, color: Colors.white),
        backgroundColor: Colors.indigo);

    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder<Applications>(
          future: futureApps,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Material(
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: ListView(
                  children: <Widget>[
                    buildHeader(name: name, onClicked: () {}),
                    const Divider(height: 20, thickness: 2),
                    Container(
                      padding: padding,
                      child: Column(
                        children: [
                          const SizedBox(height: 1),
                          const SizedBox(height: 20),
                          for (int i = 0;
                              i < snapshot.data!.dataPayload.data.length;
                              i++)
                            buildMenuItem(
                                text: snapshot.data!.dataPayload.data[i].name,
                                name: 'fa.' +
                                    snapshot.data!.dataPayload.data[i].icon,
                                onClicked: () => selectedItem(context,
                                    snapshot.data!.dataPayload.data[i].name, i),
                                index: i),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      // endDrawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 200, 200, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          GlobalValue.initTitle,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            iconSize: 28,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AccountDialog(),
                );
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 35,
              ))
        ],
      ),
      body: MultiForm(),
    );
  }

  Widget buildHeader({
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 27,
                        fontFamily: 'Montserrat',
                        color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required String name,
    required int index,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    final hoverColor = Colors.blue;

    return ListTile(
      selected: indexClicked == index,
      selectedTileColor: GlobalValue.drawerSelectedTileColor,
      leading: Icon(getIconUsingPrefix(name: name),
          color: indexClicked == index
              ? GlobalValue.drawerItemSelectedColor
              : GlobalValue.drawerItemColor),
      title: Text(text,
          style: TextStyle(
              color: indexClicked == index
                  ? GlobalValue.drawerItemSelectedColor
                  : GlobalValue.drawerItemColor)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, String name, int index) {
    setState(() {
      indexClicked = index;
      GlobalValue.initTitle = name;
    });
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void updateData() {
    validateToken();
    setState(() {
      futureApps = GET.fetchApps();
    });
  }

  void validateToken() {
    bool notValid = GlobalValue.tokenExpired;
    if (notValid) {
      Toast.ShowSnackBar(
          context, 'Your session has expired.\n Please login again.');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18, 27, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(
                    'User details',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'fisrt name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'last name',
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Colors.blueGrey)),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle),
                              SizedBox(
                                width: 17,
                              ),
                              Text('Optional details')
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 68,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.blueGrey)),
                              child: Center(
                                child: Text(
                                  '1',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: 220,
                              height: 68,
                              decoration: BoxDecoration(color: Colors.grey),
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Value name',
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              child: Center(
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )
        ]);
  }
}
