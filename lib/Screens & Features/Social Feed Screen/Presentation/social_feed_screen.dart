import 'package:developerlook_task_app/Core/Appbar/custom_appbar.dart';
import 'package:developerlook_task_app/Core/Widgets/promo_banner.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Authentication/Data/auth_services.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/list_of_posts.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/top_row_buttons.dart';
import 'package:flutter/material.dart';


class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TopRowButtons(),
              SizedBox(height: 20),
              PromoBanner(imageUrl: 'https://www.shutterstock.com/image-vector/aircraft-qatar-airways-top-2-260nw-2409023703.jpg'),

              ListOfPosts(),

              TextButton(
                  onPressed: () {
                    AuthService.instance.signOut();
                  },
                  child: Text('SignOut')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
