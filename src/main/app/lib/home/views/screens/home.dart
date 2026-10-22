import 'package:app/identity/views/components/first_time_setup_trigger.dart';
import 'package:app/identity/views/components/logout_listener.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LogoutListener(
      child: Scaffold(
        body: SafeArea(top: false, bottom: false, child: FirstTimeSetupTrigger(child: AutoRouter())),
      ),
    );
  }
}
