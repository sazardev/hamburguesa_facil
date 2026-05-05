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
      builder: (context, child) {
        return Obx(() {
          final themeCtrl = Get.find<ThemeController>();
          return Theme(
            data: themeCtrl.themeData,
            child: child!,
          );
        });
      },
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
    await ctrl.loadUserPreferences();

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;

    if (!mounted) return;

    if (onboardingDone) {
      Get.off(() => const AppShell());
    } else {
      await prefs.setBool('onboarding_done', true);
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
