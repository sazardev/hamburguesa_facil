import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/model/hamburguer.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

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
            const Text('❤️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  ThemeController.primaryPink,
                  ThemeController.lavender,
                ],
              ).createShader(bounds),
              child: Text(
                'Favoritos',
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
        final favs = ctrl.myBurgers;
        if (favs.isEmpty) {
          return _EmptyState();
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemCount: favs.length,
          itemBuilder: (context, i) {
            return _FavoriteCard(
              burger: favs[i],
              index: i,
              onDelete: () => ctrl.removeFavorite(favs[i]),
            );
          },
        );
      }),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Hamburguer burger;
  final int index;
  final VoidCallback onDelete;

  const _FavoriteCard({
    required this.burger,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background image from meat
          if (burger.meat.image != null)
            Positioned.fill(
              child: Image.asset(burger.meat.image!, fit: BoxFit.cover),
            ),
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ThemeController.primaryPink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    burger.title ?? '🍔 Combo ${index + 1}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Ingredient chips
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MiniChip(
                        emoji: '🍞',
                        name: burger.bread.name,
                        color: const Color(0xFFFFD89E)),
                    const SizedBox(height: 4),
                    _MiniChip(
                        emoji: '🥩',
                        name: burger.meat.name,
                        color: const Color(0xFFFFB5B5)),
                    const SizedBox(height: 4),
                    _MiniChip(
                        emoji: '🥗',
                        name: burger.topping.name,
                        color: const Color(0xFFA8EDCA)),
                    const SizedBox(height: 4),
                    _MiniChip(
                        emoji: '🍯',
                        name: burger.dressing.name,
                        color: ThemeController.lavender),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 12, color: Colors.white70),
                        const SizedBox(width: 3),
                        Text(
                          '${burger.estimatedTime.toInt()} min',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Delete button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    title: const Text('¿Eliminar favorito?'),
                    content: const Text('Esta acción no se puede deshacer.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar')),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeController.coral),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.close, size: 16, color: Color(0xFFE05555)),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: index * 80))
        .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: index * 80));
  }
}

class _MiniChip extends StatelessWidget {
  final String emoji;
  final String name;
  final Color color;

  const _MiniChip(
      {required this.emoji, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D2C35)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('💔', style: TextStyle(fontSize: 80))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 800.ms,
                curve: Curves.easeInOut,
              ),
          const SizedBox(height: 24),
          Text(
            'Sin favoritos aún',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: ThemeController.primaryPink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea combos y guárdalos\ndesde la pantalla principal.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: Colors.grey[500], height: 1.5),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms),
    );
  }
}
