import 'package:developerlook_task_app/Screens%20&%20Features/Authentication/Data/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                AuthService.instance.signOut();
              },
              child: Text('SignOut')
          ),
          TextButton(
              onPressed: () {
                GoRouter.of(context).push('/sharescreen');
              },
              child: Text('Share Your Experience')
          ),
        ],
      ),
    );
  }
}
