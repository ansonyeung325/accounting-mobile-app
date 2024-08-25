import 'package:bloc_project/layout.dart';
import 'package:bloc_project/views.dart';
import 'package:bloc_project/router/observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(routes: [
  ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Layout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
            path: "/",
            pageBuilder: (context, state) => MaterialPage(
                    child: KeepBooksPage(
                  key: state.pageKey,
                ))),
        GoRoute(
            path: "/calendar",
            pageBuilder: (context, state) => MaterialPage(
                    child: CalendarPage(
                  key: state.pageKey,
                ))),
        GoRoute(
            path: "/setting",
            pageBuilder: (context, state) => MaterialPage(
                    child: SettingPage(
                  key: state.pageKey,
                )))
      ])
]);
