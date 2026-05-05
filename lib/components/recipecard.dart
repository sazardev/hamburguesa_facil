import 'package:flutter/material.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/model/recipe.dart';

class RecipeCardFront extends StatelessWidget {
  final Recipe item;
  final String categoryEmoji;
  final String categoryLabel;
  final Color categoryColor;

  const RecipeCardFront({
    super.key,
    required this.item,
    required this.categoryEmoji,
    required this.categoryLabel,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          if (item.image != null)
            Image.asset(
              item.image!,
              fit: BoxFit.cover,
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    categoryColor.withOpacity(0.6),
                    categoryColor.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child:
                    Text(categoryEmoji, style: const TextStyle(fontSize: 64)),
              ),
            ),
          // Dark gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
          // Category chip (top-left)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$categoryEmoji $categoryLabel',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Tag chips (top-right)
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                if (item.isVegetarian)
                  _TagBadge(emoji: '🌱', color: const Color(0xFFA8EDCA)),
                if (item.isGlutenFree)
                  _TagBadge(emoji: '🌾', color: const Color(0xFFFFF0A0)),
                if (item.isSpicy)
                  _TagBadge(emoji: '🌶️', color: const Color(0xFFFFD5C2)),
              ],
            ),
          ),
          // Name at bottom
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      const Shadow(blurRadius: 4, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 12, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      '${item.estimatedTime.toInt()} min',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Hint to flip
          Positioned(
            bottom: 10,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Toca 👆',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCardBack extends StatelessWidget {
  final Recipe item;
  final Color categoryColor;
  final VoidCallback? onViewRecipe;

  const RecipeCardBack({
    super.key,
    required this.item,
    required this.categoryColor,
    this.onViewRecipe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ThemeController.lavender.withOpacity(0.4),
              ThemeController.primaryPink.withOpacity(0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                color: const Color(0xFF3D2C35),
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                const Text('⏱️', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 4),
                Text(
                  '${item.estimatedTime.toInt()} min',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(width: 12),
                const Text('🥘', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 4),
                Text(
                  '${item.ingredients.length} ingredientes',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            // Tags
            Row(
              children: [
                if (item.isVegetarian) ...[
                  _TagChip(
                      emoji: '🌱',
                      label: 'Veggie',
                      color: const Color(0xFFA8EDCA)),
                  const SizedBox(width: 4),
                ],
                if (item.isGlutenFree) ...[
                  _TagChip(
                      emoji: '🌾',
                      label: 'Sin Gluten',
                      color: const Color(0xFFFFF0A0)),
                  const SizedBox(width: 4),
                ],
                if (item.isSpicy)
                  _TagChip(
                      emoji: '🌶️',
                      label: 'Picante',
                      color: const Color(0xFFFFD5C2)),
              ],
            ),
            // Top 2 ingredients
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: item.ingredients
                  .take(3)
                  .map((i) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          i.name,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D2C35)),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  final String emoji;
  final Color color;
  const _TagBadge({required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 12))),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  const _TagChip(
      {required this.emoji, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$emoji $label',
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3D2C35)),
      ),
    );
  }
}

// Legacy stub — kept for compatibility, replaced at usage sites
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(clipBehavior: Clip.hardEdge, child: child);
  }
}
