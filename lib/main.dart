import 'package:developerlook_task_app/Core/Routing/routing_config.dart';
import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens & Features/Share Screen/Bloc/share_review_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          fontFamily: 'Plus Jakarta Sans',
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
