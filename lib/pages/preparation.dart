import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/model/recipe.dart';

class PreparationPage extends StatelessWidget {
  final Recipe recipe;
  final String categoryEmoji;
  final String categoryLabel;
  final Color categoryColor;

  const PreparationPage({
    super.key,
    required this.recipe,
    required this.categoryEmoji,
    required this.categoryLabel,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.cream,
      appBar: AppBar(
        title: Text(
          '$categoryEmoji Preparación',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            if (recipe.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  recipe.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),

            // Nombre
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            // Tiempo estimado
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '⏱️ ${recipe.estimatedTime.toInt()} min',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: categoryColor,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ingredientes
            Text(
              'Ingredientes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(height: 12),

            ...recipe.ingredients.map((ing) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ing.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${ing.quantity} ${ing.measure}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

            const SizedBox(height: 24),

            // Pasos
            Text(
              'Pasos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(height: 12),

            ...recipe.steps.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final step = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Text(
                          step,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
