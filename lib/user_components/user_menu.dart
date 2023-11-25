import 'package:aws_tester/aws_components/s3.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../aws_components/rekognition.dart';
import '../home.dart';
import '../models/user_model.dart';
import 'read_all_users.dart';
import 'read_one_user.dart';

class UserMenuComponent extends StatefulWidget {
  const UserMenuComponent(
      {super.key, required this.user, required this.jwt, required this.socket});
  final User user;
  final String jwt;
  final IO.Socket socket;

  @override
  State<UserMenuComponent> createState() => _UserMenuComponentState();
}

class _UserMenuComponentState extends State<UserMenuComponent> {
  late String _jwt;
  late User _user;
  late IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    _jwt = widget.jwt;
    _user = widget.user;
    _socket = widget.socket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filled(
                  iconSize: 75,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GetUserComponent(
                              jwt: _jwt,
                              user: _user,
                              currentUser: _user,
                              socket: _socket,
                            )));
                  },
                  icon: const Icon(Icons.person_pin_rounded)),
            ),
            _user.type == 'Admin' || _user.type == 'General'
                ? ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GetAllUsersComponent(
                                user: _user,
                                jwt: _jwt,
                                socket: _socket,
                              )));
                    },
                    icon: const Icon(Icons.group),
                    label: const Text('Users'))
                : SizedBox(),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => S3BucketComponent()));
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('S3')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RekognitionComponent()));
                },
                icon: const Icon(Icons.photo_camera_front_outlined),
                label: const Text('REKOGNITION')),
            ElevatedButton.icon(
                onPressed: () {
                  _socket.disconnect();
                  setState(() {
                    _jwt = "";
                    _user = User(
                        id: 'logout',
                        firstName: 'logout',
                        lastName: 'logout',
                        email: 'logout',
                        password: 'logout',
                        type: 'logout');
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(socket: _socket)));
                },
                icon: const Icon(Icons.power_settings_new_rounded),
                label: const Text('Logout')),
          ],
        ),
      )),
    );
  }
}
