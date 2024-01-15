import 'package:connect_api/models/user.dart';
import 'package:connect_api/screen/login_screen.dart';
import 'package:connect_api/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  var isLoaded = false;

  void _login(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userModel = await RemoteService().getUserModel();

    if (userModel != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            TextButton.icon(
              onPressed: () {
                _login(context);
              },
              label: const Text('Login'),
              icon: const Icon(Icons.login_rounded),
            )
          ],
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('User ID: ${userModel?.data.userId ?? "N/A"}'),
                Text('Name: ${userModel?.data.name ?? "N/A"}'),
                Text('Email: ${userModel?.data.email ?? "N/A"}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
