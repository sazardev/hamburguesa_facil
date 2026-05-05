import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/components/burger_summary.dart';
import 'package:hamburguesa_facil/model/hamburguer.dart';

class MyBurgersPage extends StatelessWidget {
  const MyBurgersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HamburguerController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ThemeController.cream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text('🍔', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  ThemeController.primaryPink,
                  ThemeController.lavender,
                ],
              ).createShader(bounds),
              child: Text(
                'Mis Hamburguesas',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        final burgers = ctrl.myBurgers;
        if (burgers.isEmpty) {
          return _EmptyState();
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: burgers.length,
          itemBuilder: (context, i) {
            return _BurgerCard(
              burger: burgers[i],
              index: i,
              onDelete: () => ctrl.removeFavorite(burgers[i]),
            );
          },
        );
      }),
    );
  }
}

class _BurgerCard extends StatelessWidget {
  final Hamburguer burger;
  final int index;
  final VoidCallback onDelete;

  const _BurgerCard({
    required this.burger,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Get.to(() => BurgerSummary(hamburger: burger));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ThemeController.primaryPink.withOpacity(0.1),
                ThemeController.lavender.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          burger.title ?? 'Mi Hamburguesa',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeController.primaryPink,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '🍞 ${burger.bread.name}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeController.lavender,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '🥩 ${burger.meat.name}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                children: [
                  _MiniTag(emoji: '🥗', label: burger.topping.name),
                  _MiniTag(emoji: '🍯', label: burger.dressing.name),
                  _MiniTag(
                    emoji: '⏱️',
                    label: '${burger.estimatedTime.toInt()} min',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 50)).slideY(
          begin: 0.15,
          end: 0,
          delay: Duration(milliseconds: index * 50),
          duration: 300.ms,
        );
  }
}

class _MiniTag extends StatelessWidget {
  final String emoji;
  final String label;

  const _MiniTag({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$emoji $label',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🍔',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Sin hamburguesas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Arma tu primera hamburguesa',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
