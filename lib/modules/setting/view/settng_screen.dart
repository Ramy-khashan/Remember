import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/app_assets.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_string.dart';
import '../../../config/theme/changetheme_cubit.dart';
import '../../../config/theme/changetheme_states.dart';
import '../../home/view/view.dart';
import '../controller/setting_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => SettingCubit(),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Builder(builder: (context) {
              return BlocBuilder<SettingCubit, SettingState>(
                builder: (context, state) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.notifications_on_outlined,
                      ),
                      title: Text(AppString.notification.tr()),
                      trailing: Switch(
                        activeColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xffdcd9d4)
                                : AppColor.mainColor2,
                        thumbColor:
                            const WidgetStatePropertyAll(AppColor.mainColor2),
                        value: BlocProvider.of<SettingCubit>(context).isActive,
                        onChanged: (value) {
                          BlocProvider.of<SettingCubit>(context)
                              .changeNotificationState(value: value);
                        },
                      ),
                      onTap: () {},
                    ),
                  );
                },
              );
            }),
            // Card(
            //   child: ListTile(
            //     leading: const Icon(
            //       Icons.color_lens_outlined,
            //     ),
            //     title: const Text("App Main Color"),
            //     trailing: const Icon(Icons.arrow_forward_ios_outlined),
            //     onTap: () {
            //       Fluttertoast.showToast(
            //           msg: "Comming Soon",
            //           backgroundColor: AppColor.mainColor2);
            //     },
            //   ),
            // ),
            BlocBuilder<ChangeTheme, ChangeThemeState>(
              builder: (context, state) {
                final controller = ChangeTheme.get(context);
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Text(AppString.darkMode.tr()),
                    trailing: Switch(
                      activeColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xffdcd9d4)
                              : AppColor.mainColor2,
                      thumbColor:
                          const WidgetStatePropertyAll(AppColor.mainColor2),
                      onChanged: (val) {
                        controller.changeTheme();
                      },
                      value: controller.isDark,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: ElevatedButton(
                      onPressed: () {
                        context.setLocale(const Locale('en', 'US'));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                            (route) => false);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical:20),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.en,
                              scale: 9,
                            ),
                            const Spacer(),
                            Text(AppString.en,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xffdcd9d4)
                                        : AppColor.mainColor2)),
                          ],
                        ),
                      )),
                ),
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: ElevatedButton(
                      onPressed: () {
                        context.setLocale(const Locale('ar', 'DZ'));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                            (route) => false);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical:20),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.ar,
                              scale: 18,
                            ),
                            const Spacer(),
                            Text(AppString.ar,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xffdcd9d4)
                                        : AppColor.mainColor2)),
                          ],
                        ),
                      )),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
