import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember/screens/todo/controller.dart';
import 'cubit/changetheme/changetheme_cubit.dart';
import 'cubit/changetheme/changetheme_states.dart';
import 'screens/mainhome/view.dart';
import 'constant.dart';
import 'cubit/appcontroller.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppController>(
          create: (context) => AppController()..initialDatabase(),
        ),
        BlocProvider(
          create: (context) => ChangeTheme()..savedTheme(),
        ),
      ],
      child: BlocBuilder<ChangeTheme, ChangeThemeState>(
        builder: (context, state) {
          final controller = ChangeTheme.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: controller.themeMode,
            // theme: ThemeData(
            //     scaffoldBackgroundColor: Colors.white, primarySwatch: mainColor1),
            home: const MainHome(),
          );
        },
      ),
    );
  }
}
