import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/homepage.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) =>  LoginPage()),
    GoRoute(path: '/homepage', builder: (context, state) =>  HomePage()),
  ],
);
