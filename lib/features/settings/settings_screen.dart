import 'package:flutter/material.dart';
import '../../core/widgets/screen_title.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      bottom: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ScreenTitle('Settings'),
          ],
        ),
      ),
    );
  }
}

