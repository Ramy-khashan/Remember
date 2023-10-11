 
 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/app_string.dart';

import '../../config/theme.dart';
import '../../screens/main_screen/view/view.dart';
 import '../cubit/app_cubit/appcontroller.dart';
import '../cubit/changetheme/changetheme_cubit.dart';
import '../cubit/changetheme/changetheme_states.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 

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
  locale: context.locale,
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationDelegates,
            title: AppString.appTitle,
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: controller.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
