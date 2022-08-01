import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/changetheme/changetheme_cubit.dart';
import '../cubit/changetheme/changetheme_states.dart';

PreferredSizeWidget appbar(
        {required Size size,
        required String head,
        VoidCallback? onFilter,
        isFillter = false,
        context,
        changeTheme = true}) =>
    AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          head,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "logo",
            fontSize: size.shortestSide * .1,
          ),
        ),
      ),
      actions: [
        changeTheme
            ? BlocBuilder<ChangeTheme, ChangeThemeState>(
                builder: (context, state) {
                  final controller = ChangeTheme.get(context);
                  return IconButton(
                      onPressed: () {
                        controller.changeTheme();
                      },
                      icon: Icon(
                        controller.isDark ? Icons.light_mode : Icons.dark_mode,
                      ));
                },
              )
            : const SizedBox.shrink(),
        isFillter
            ? IconButton(
                onPressed: onFilter, icon: const Icon(Icons.filter_alt_rounded))
            : const SizedBox.shrink()
      ],
    );
