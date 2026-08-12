import 'package:app/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NewskuAutoLeadingButton extends StatelessWidget {
  const NewskuAutoLeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoLeadingButton(
      builder: (context, leadingType, action) {
        switch (leadingType) {
          case LeadingType.back:
          case .close:
            return IconButton(
              icon: const BackButtonIcon(),
              onPressed: action, // normal pop
            );
          case LeadingType.drawer:
            return IconButton(icon: const Icon(Icons.menu), onPressed: action);
          case LeadingType.noLeading:
            // Nothing to pop to (e.g. after a page refresh) — go home explicitly.
            return IconButton(
              icon: const BackButtonIcon(),
              onPressed: () => context.router.navigate(const HomeRoute()),
            );
        }
      },
    );
  }
}
