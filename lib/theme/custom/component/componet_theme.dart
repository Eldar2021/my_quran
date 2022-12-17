import 'package:flutter/material.dart';

mixin CompomnentTheme {
  ShapeBorder get shapeMedium => const RoundedRectangleBorder(
      // borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme() {
    return const CardTheme(
        // elevation: 0,
        // shape: shapeMedium,
        // clipBehavior: Clip.antiAlias,
        );
  }

  ButtonThemeData buttonTheme(ColorScheme colors) {
    return const ButtonThemeData(
        // buttonColor: colors.primary,
        );
  }

  ElevatedButtonThemeData elevatedButtonThemeData(ColorScheme colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        // fixedSize: Size(200, 50),
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colors) {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          // borderSide: BorderSide(
          //   color: colors.primary,
          // ),
          ),
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return const ListTileThemeData(
        // shape: shapeMedium,
        // selectedColor: colors.secondary,
        );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return const AppBarTheme(
        // elevation: 0,
        // backgroundColor: colors.surfaceVariant,
        // foregroundColor: colors.onSurface,
        );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return const TabBarTheme(
        // labelColor: colors.secondary,
        // unselectedLabelColor: colors.onSurfaceVariant,
        // indicator: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       color: colors.secondary,
        //       width: 2,
        //     ),
        //   ),
        // ),
        );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return const BottomAppBarTheme(
        // color: colors.surface,
        // elevation: 0,
        );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return const BottomNavigationBarThemeData(
        // type: BottomNavigationBarType.fixed,
        // backgroundColor: colors.surfaceVariant,
        // selectedItemColor: colors.onSurface,
        // unselectedItemColor: colors.onSurfaceVariant,
        // elevation: 0,
        // landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        );
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return const DrawerThemeData(
        // backgroundColor: colors.surface,
        );
  }

  ScrollbarThemeData scrollbarThemeData(ColorScheme colors) {
    return const ScrollbarThemeData(interactive: true);
  }
}
