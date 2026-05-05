import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/layouts/main.layout.dart';
import 'package:hamburguesa_facil/pages/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
        Get.put(HamburguerController());
      }),
      theme: ThemeController.lightTheme,
      darkTheme: ThemeController.darkTheme,
      themeMode: ThemeMode.light,
      home: const _Splash(),
    );
  }
}

class _Splash extends StatefulWidget {
  const _Splash();

  @override
  State<_Splash> createState() => _SplashState();
}

class _SplashState extends State<_Splash> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final ctrl = Get.find<HamburguerController>();

    bool onboardingDone = false;
    try {
      await ctrl.loadUserPreferences();
      final prefs = await SharedPreferences.getInstance();
      onboardingDone = prefs.getBool('onboarding_done') ?? false;
    } catch (_) {
      // SharedPreferences unavailable (unsupported platform / first run)
    }

    if (!mounted) return;

    if (onboardingDone) {
      Get.off(() => const AppShell());
    } else {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboarding_done', true);
      } catch (_) {}
      Get.off(() => const OnboardingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.cream,
      body: const Center(
        child: Text('🍔', style: TextStyle(fontSize: 80)),
      ),
    );
  }
}
