import 'package:breeze/app/injection.dart';
import 'package:breeze/features/splash/logic/splash_cubit.dart';
import 'package:breeze/features/splash/presentation/widgets/splash_background.dart';
import 'package:breeze/features/splash/presentation/widgets/splash_brand_text.dart';
import 'package:breeze/features/splash/presentation/widgets/splash_logo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../app/navigation/main_shell.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
  }

  void _openMain() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const MainShell(),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..start(),
      child: BlocListener<SplashCubit, SplashStatus>(
        listenWhen: (_, s) => s == SplashStatus.ready,
        listener: (_, _) => _openMain(),
        child: const Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              SplashBackground(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SplashLogoCard(),
                    SizedBox(height: 24),
                    SplashBrandText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
