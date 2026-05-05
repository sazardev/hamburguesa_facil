import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';
import 'package:hamburguesa_facil/model/hamburguer.dart';
import 'package:hamburguesa_facil/model/recipe.dart';

class BurgerSummarySheet extends StatefulWidget {
  const BurgerSummarySheet({super.key});

  @override
  State<BurgerSummarySheet> createState() => _BurgerSummarySheetState();
}

class _BurgerSummarySheetState extends State<BurgerSummarySheet> {
  final TextEditingController _nameCtrl = TextEditingController();
  final HamburguerController _ctrl = Get.find();
  bool _saved = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final combo = _ctrl.currentCombo;
    final title = _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text.trim();
    await _ctrl.addFavorite(Hamburguer(
      title: title,
      estimatedTime: combo.estimatedTime,
      bread: combo.bread,
      topping: combo.topping,
      meat: combo.meat,
      dressing: combo.dressing,
    ));
    setState(() => _saved = true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final combo = _ctrl.currentCombo;
      final alreadySaved = _ctrl.isFavorite(combo);

      return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollCtrl) => Container(
          decoration: const BoxDecoration(
            color: ThemeController.cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: ListView(
            controller: scrollCtrl,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                '🍔 Tu Hamburguesa',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: ThemeController.primaryPink,
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.timer_outlined,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Tiempo total estimado: ${combo.estimatedTime.toInt()} min',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 4 ingredient rows
              _IngredientRow(
                  recipe: combo.bread,
                  emoji: '🍞',
                  label: 'Pan',
                  color: const Color(0xFFFFD89E)),
              _IngredientRow(
                  recipe: combo.topping,
                  emoji: '🥗',
                  label: 'Topping',
                  color: const Color(0xFFA8EDCA)),
              _IngredientRow(
                  recipe: combo.meat,
                  emoji: '🥩',
                  label: 'Carne',
                  color: const Color(0xFFFFB5B5)),
              _IngredientRow(
                  recipe: combo.dressing,
                  emoji: '🍯',
                  label: 'Salsa',
                  color: ThemeController.lavender),
              const SizedBox(height: 24),
              // All ingredients combined
              _AllIngredientsList(combo: combo),
              const SizedBox(height: 24),
              // Save favorite
              if (!alreadySaved && !_saved) ...[
                Text('Dale un nombre (opcional)',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: Colors.grey[700])),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ej: La especial del viernes',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Text('💾', style: TextStyle(fontSize: 18)),
                  label: const Text('Guardar como favorita'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ] else
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA8EDCA).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('✅', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        '¡Guardada en favoritos!',
                        style: theme.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF2A7A52),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ).animate().scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.elasticOut),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }
}

class _IngredientRow extends StatelessWidget {
  final Recipe recipe;
  final String emoji;
  final String label;
  final Color color;

  const _IngredientRow({
    required this.recipe,
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: recipe.image != null
                ? Image.asset(recipe.image!,
                    width: 56, height: 56, fit: BoxFit.cover)
                : Container(
                    width: 56,
                    height: 56,
                    color: color,
                    child: Center(
                        child:
                            Text(emoji, style: const TextStyle(fontSize: 26)))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$emoji $label',
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  recipe.name,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}

class _AllIngredientsList extends StatefulWidget {
  final Hamburguer combo;
  const _AllIngredientsList({required this.combo});

  @override
  State<_AllIngredientsList> createState() => _AllIngredientsListState();
}

class _AllIngredientsListState extends State<_AllIngredientsList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allIngredients = [
      ...widget.combo.bread.ingredients,
      ...widget.combo.topping.ingredients,
      ...widget.combo.meat.ingredients,
      ...widget.combo.dressing.ingredients,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('🛒', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Text(
                    'Lista de compras',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  Text('${allIngredients.length} items',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allIngredients
                    .map((i) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: ThemeController.cream,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text(
                            '${i.name} (${i.quantity.toInt()} ${i.measure})',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ))
                    .toList(),
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
