import 'package:flutter/material.dart';

import 'models/user_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e}) : super(key: key);
  final UserModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "${e.firstName} ${e.lastName}",style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundImage: NetworkImage(e.avatar),
                  ),
                ),
                Text(
                  "${e.firstName} ${e.lastName}",
                ),
                Text(e.email),
              ],
            ),
          ),
        ));
  }
}
