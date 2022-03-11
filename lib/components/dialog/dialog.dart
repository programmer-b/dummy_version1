import 'package:flutter/material.dart';

class AccountDialog extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8.0,
      backgroundColor: Colors.white,
      child: accountContent(context),
    );
  }

  accountContent(BuildContext context) {
    const name = 'Admin';
    const email = 'CrackerIt_Technologies';

    FocusScope.of(context).unfocus();

    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 26.0,
            left: 6.0,
            right: 6.0,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text('CrackIT.',
                      style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'))
                ],
              ),
              buildHeader(
                name: name,
                email: email,
              ),
              const SizedBox(height: 17),
              Container(
                height: 35,
                width: 258,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text('MANAGE YOUR ACCOUNT'),
                ),
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    Icons.logout_sharp,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 15),
                  Text('Logout')
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    Icons.settings_sharp,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 15),
                  Text('Settings')
                ],
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    'Terms of service',
                    style: TextStyle(
                        color: Colors.black87, fontFamily: 'Montserrat'),
                  ),
                  SizedBox(width: 18),
                  Icon(
                    Icons.circle,
                    color: Colors.black87,
                    size: 9,
                  ),
                  SizedBox(width: 18),
                  Text(
                    'Privacy policy',
                    style: TextStyle(
                        color: Colors.black87, fontFamily: 'Montserrat'),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 11)),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  Widget buildDialogItem({
    required String text,
    required IconData icon,
  }) {
    const color = Colors.black;
    final hoverColor = Colors.black38;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
    );
  }
}
