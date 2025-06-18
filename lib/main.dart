import 'package:developerlook_task_app/Core/Routing/routing_config.dart';
import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens & Features/Share Screen/Bloc/share_review_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    PrefUtils().init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        SizeUtils.deviceType = deviceType;
        SizeUtils.orientation = orientation;
        return MultiBlocProvider(
          providers: [
            BlocProvider<ShareReviewBloc>(
              create: (context) => ShareReviewBloc(),
            ),
          ],
          child: MaterialApp.router(
            title: 'Developer Look',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}
