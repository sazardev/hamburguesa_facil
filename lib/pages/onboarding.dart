import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/pages/home.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _prefVegetarian = false;
  bool _prefGlutenFree = false;
  bool _prefSpicy = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final controller = Get.find<HamburguerController>();
    await controller.saveUserPreferences(
      vegetarian: _prefVegetarian,
      glutenFree: _prefGlutenFree,
      spicy: _prefSpicy,
    );
    Get.offAll(() => const Home());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ThemeController.cream,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (p) => setState(() => _currentPage = p),
                children: [
                  _WelcomePage(),
                  _HowItWorksPage(),
                  _PreferencesPage(
                    vegetarian: _prefVegetarian,
                    glutenFree: _prefGlutenFree,
                    spicy: _prefSpicy,
                    onVegetarianChanged: (v) =>
                        setState(() => _prefVegetarian = v),
                    onGlutenFreeChanged: (v) =>
                        setState(() => _prefGlutenFree = v),
                    onSpicyChanged: (v) => setState(() => _prefSpicy = v),
                  ),
                  _ReadyPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      activeDotColor: ThemeController.primaryPink,
                      dotColor: ThemeController.primaryPink.withOpacity(0.3),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _currentPage < 3 ? 'Siguiente →' : '¡Empezar! 🍔',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ).animate(key: ValueKey(_currentPage)).scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                          duration: 300.ms,
                          curve: Curves.elasticOut,
                        ),
                  ),
                  if (_currentPage < 3) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _finish,
                      child: Text(
                        'Omitir',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Screen 1: Welcome ─────────────────────────────────────────────────────────
class _WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🍔', style: TextStyle(fontSize: 100))
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut)
              .then()
              .shake(hz: 2, rotation: 0.05),
          const SizedBox(height: 32),
          Text(
            '¡Hamburguesa\nFácil!',
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: ThemeController.primaryPink,
              height: 1.1,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Text(
            'Descubre combos únicos y haz\ntu hamburguesa perfecta.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
}

// ── Screen 2: How it works ────────────────────────────────────────────────────
class _HowItWorksPage extends StatelessWidget {
  static const _steps = [
    ('🫸', 'Desliza', 'Explora los ingredientes en cada carrusel'),
    ('👆', 'Voltea', 'Toca una tarjeta para ver la receta completa'),
    ('🎲', 'Combina', 'Usa el botón shuffle para inspirarte'),
    ('❤️', 'Guarda', 'Guarda tus combos favoritos'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Cómo funciona?',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: ThemeController.primaryPink,
            ),
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 32),
          ..._steps.asMap().entries.map((e) {
            final (emoji, title, desc) = e.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: ThemeController.primaryPink.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child:
                            Text(emoji, style: const TextStyle(fontSize: 26))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: const Color(0xFF3D2C35))),
                        Text(desc,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 200 + e.key * 120))
                .slideX(begin: 0.2, end: 0);
          }),
        ],
      ),
    );
  }
}

// ── Screen 3: Preferences ─────────────────────────────────────────────────────
class _PreferencesPage extends StatelessWidget {
  final bool vegetarian;
  final bool glutenFree;
  final bool spicy;
  final ValueChanged<bool> onVegetarianChanged;
  final ValueChanged<bool> onGlutenFreeChanged;
  final ValueChanged<bool> onSpicyChanged;

  const _PreferencesPage({
    required this.vegetarian,
    required this.glutenFree,
    required this.spicy,
    required this.onVegetarianChanged,
    required this.onGlutenFreeChanged,
    required this.onSpicyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¡Cuéntame más!', style: TextStyle(fontSize: 36))
              .animate()
              .fadeIn(),
          const SizedBox(height: 8),
          Text(
            'Activa tus preferencias alimentarias para filtrar los ingredientes.',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: Colors.grey[600], height: 1.5),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 40),
          _PrefTile(
            emoji: '🌱',
            label: 'Vegetariano',
            description: 'Sin carne ni pescado',
            color: const Color(0xFFA8EDCA),
            value: vegetarian,
            onChanged: onVegetarianChanged,
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          _PrefTile(
            emoji: '🌾',
            label: 'Sin Gluten',
            description: 'Apto para celíacos',
            color: const Color(0xFFFFF0A0),
            value: glutenFree,
            onChanged: onGlutenFreeChanged,
          ).animate().fadeIn(delay: 320.ms).slideX(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          _PrefTile(
            emoji: '🌶️',
            label: 'Picante',
            description: 'Solo opciones con kick',
            color: const Color(0xFFFFD5C2),
            value: spicy,
            onChanged: onSpicyChanged,
          ).animate().fadeIn(delay: 440.ms).slideX(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}

class _PrefTile extends StatelessWidget {
  final String emoji;
  final String label;
  final String description;
  final Color color;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PrefTile({
    required this.emoji,
    required this.label,
    required this.description,
    required this.color,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: value ? color : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: value ? color.withOpacity(0) : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: value
            ? [
                BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ]
            : [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: const Color(0xFF3D2C35))),
                Text(description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600])),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: ThemeController.primaryPink,
          ),
        ],
      ),
    );
  }
}

// ── Screen 4: Ready ───────────────────────────────────────────────────────────
class _ReadyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 90))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.15, 1.15),
                duration: 700.ms,
                curve: Curves.easeInOut,
              ),
          const SizedBox(height: 32),
          Text(
            '¡Todo listo!',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: ThemeController.primaryPink,
            ),
          ).animate().fadeIn(delay: 200.ms).scale(),
          const SizedBox(height: 16),
          Text(
            'Empieza a crear la hamburguesa\nmás deliciosa de tu vida. 🍔✨',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
