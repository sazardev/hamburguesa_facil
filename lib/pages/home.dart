import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/components/burger_summary.dart';
import 'package:hamburguesa_facil/components/flipcard.dart';
import 'package:hamburguesa_facil/components/recipecard.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/model/recipe.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final HamburguerController _ctrl;

  final PageController breadsController =
      PageController(initialPage: 1000, viewportFraction: 0.88);
  final PageController toppingsController =
      PageController(initialPage: 1000, viewportFraction: 0.88);
  final PageController meatsController =
      PageController(initialPage: 1000, viewportFraction: 0.88);
  final PageController dressingController =
      PageController(initialPage: 1000, viewportFraction: 0.88);

  late AnimationController _shuffleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<HamburguerController>();
    _shuffleAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Sync page controllers → controller indices
    breadsController.addListener(() {
      if (breadsController.hasClients) {
        final list = _ctrl.filteredBreads;
        final len = list.isEmpty ? 1 : list.length;
        _ctrl.breadIndex.value = (breadsController.page?.round() ?? 1000) % len;
      }
    });
    toppingsController.addListener(() {
      if (toppingsController.hasClients) {
        final list = _ctrl.filteredToppings;
        final len = list.isEmpty ? 1 : list.length;
        _ctrl.toppingIndex.value =
            (toppingsController.page?.round() ?? 1000) % len;
      }
    });
    meatsController.addListener(() {
      if (meatsController.hasClients) {
        final list = _ctrl.filteredMeats;
        final len = list.isEmpty ? 1 : list.length;
        _ctrl.meatIndex.value = (meatsController.page?.round() ?? 1000) % len;
      }
    });
    dressingController.addListener(() {
      if (dressingController.hasClients) {
        final list = _ctrl.filteredDressings;
        final len = list.isEmpty ? 1 : list.length;
        _ctrl.dressingIndex.value =
            (dressingController.page?.round() ?? 1000) % len;
      }
    });
  }

  @override
  void dispose() {
    breadsController.dispose();
    toppingsController.dispose();
    meatsController.dispose();
    dressingController.dispose();
    _shuffleAnim.dispose();
    super.dispose();
  }

  void _randomize() {
    HapticFeedback.mediumImpact();
    _shuffleAnim.forward(from: 0);
    final rng = Random();
    final bl = _ctrl.filteredBreads.isEmpty ? 10 : _ctrl.filteredBreads.length;
    final tl =
        _ctrl.filteredToppings.isEmpty ? 9 : _ctrl.filteredToppings.length;
    final ml = _ctrl.filteredMeats.isEmpty ? 12 : _ctrl.filteredMeats.length;
    final dl =
        _ctrl.filteredDressings.isEmpty ? 5 : _ctrl.filteredDressings.length;
    breadsController.animateToPage(1000 + rng.nextInt(bl),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
    toppingsController.animateToPage(1000 + rng.nextInt(tl),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
    meatsController.animateToPage(1000 + rng.nextInt(ml),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
    dressingController.animateToPage(1000 + rng.nextInt(dl),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
  }

  void _openSummary() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BurgerSummarySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.cream,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSection(
                  context,
                  emoji: '🍞',
                  color: const Color(0xFFFFD89E),
                  controller: breadsController,
                  itemsGetter: () => _ctrl.filteredBreads,
                  categoryEmoji: '🍞',
                  categoryLabel: 'Pan',
                  categoryColor: const Color(0xFFFFAA5C),
                  delay: 0,
                ),
                _buildSection(
                  context,
                  emoji: '🥗',
                  color: const Color(0xFFA8EDCA),
                  controller: toppingsController,
                  itemsGetter: () => _ctrl.filteredToppings,
                  categoryEmoji: '🥗',
                  categoryLabel: 'Topping',
                  categoryColor: const Color(0xFF5BBA8A),
                  delay: 80,
                ),
                _buildSection(
                  context,
                  emoji: '🥩',
                  color: const Color(0xFFFFB5B5),
                  controller: meatsController,
                  itemsGetter: () => _ctrl.filteredMeats,
                  categoryEmoji: '🥩',
                  categoryLabel: 'Carne',
                  categoryColor: const Color(0xFFE05555),
                  delay: 160,
                ),
                _buildSection(
                  context,
                  emoji: '🍯',
                  color: ThemeController.lavender,
                  controller: dressingController,
                  itemsGetter: () => _ctrl.filteredDressings,
                  categoryEmoji: '🍯',
                  categoryLabel: 'Salsa',
                  categoryColor: ThemeController.lavender,
                  delay: 240,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Ver mi hamburguesa
          FloatingActionButton.extended(
            onPressed: _openSummary,
            label: const Text('Armar'),
            icon: const Text('🍔', style: TextStyle(fontSize: 18)),
            backgroundColor: ThemeController.primaryPink,
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 12),
          // Random
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: _shuffleAnim, curve: Curves.easeInOut),
            ),
            child: FloatingActionButton(
              onPressed: _randomize,
              tooltip: 'Combinar al azar',
              backgroundColor: ThemeController.lavender,
              foregroundColor: Colors.white,
              child: const Text('🎲', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      snap: true,
      backgroundColor: ThemeController.cream,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('🍔', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            const Text(
              'Hamburguesa Fácil',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String emoji,
    required Color color,
    required PageController controller,
    required List<Recipe> Function() itemsGetter,
    required String categoryEmoji,
    required String categoryLabel,
    required Color categoryColor,
    required int delay,
  }) {
    return Obx(() {
      // Read reactive state to trigger rebuild on filter change
      _ctrl.filterVegetarian.value;
      _ctrl.filterGlutenFree.value;
      _ctrl.filterSpicy.value;

      final items = itemsGetter();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(emoji,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13)),
                ),
                const Spacer(),
                if (items.isNotEmpty)
                  Text('${items.length} opciones',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          if (items.isEmpty)
            _emptyCategory(color)
          else
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: controller,
                itemCount: null,
                itemBuilder: (context, index) {
                  final item = items[index % items.length];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: FlipCard(
                      front: RecipeCardFront(
                        item: item,
                        categoryEmoji: categoryEmoji,
                        categoryLabel: categoryLabel,
                        categoryColor: categoryColor,
                      ),
                      back: RecipeCardBack(
                        item: item,
                        categoryColor: categoryColor,
                        categoryEmoji: categoryEmoji,
                        categoryLabel: categoryLabel,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideY(
            begin: 0.15,
            end: 0,
            delay: Duration(milliseconds: delay),
            duration: 400.ms,
          );
    });
  }

  Widget _emptyCategory(Color color) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'No hay opciones con este filtro 😅',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.emoji,
    required this.label,
    required this.active,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: active ? color : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: active
              ? [
                  BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: active ? const Color(0xFF3D2C35) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
