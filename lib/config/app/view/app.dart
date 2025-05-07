import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/theme.dart';
import '../../../core/constant/app_string.dart';
import '../../../modules/splash_screen/view/splash_screen.dart';
import '../controller/appcontroller.dart';
import '../../theme/changetheme_cubit.dart';
import '../../theme/changetheme_states.dart';

class RememberApp extends StatelessWidget {
  const RememberApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppController>(
          create: (context) => AppController()
            ..initialDatabase()
         ),
        BlocProvider(
          create: (context) => ChangeTheme()..savedTheme(),
        ),
      ],
      child: BlocBuilder<ChangeTheme, ChangeThemeState>(
        builder: (context, state) {
          final controller = ChangeTheme.get(context);
          return MaterialApp(
            navigatorKey: navigatorKey,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            title: AppString.appTitle,
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: controller.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
