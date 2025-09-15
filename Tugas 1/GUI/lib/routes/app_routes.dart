import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/tabs/first_tab.dart';
import 'package:flutter_application_1/tabs/second_tab.dart';

final GoRouter router = GoRouter(
  initialLocation: '/second',
  routes: [
    GoRoute(path: '/login', builder: (context, state) =>  LoginPage()),
    GoRoute(path: '/homepage', builder: (context, state) =>  HomePage()),
    GoRoute(path: '/first', builder: (context, state) =>  GroupPage()),
    GoRoute(path: '/second', builder: (context, state) =>  KalkulatorPage()),
  ],
);
