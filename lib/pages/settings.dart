import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamburguesa_facil/config/theme/theme.controller.dart';
import 'package:hamburguesa_facil/controllers/hamburguer.controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HamburguerController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ Configuración', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: ThemeController.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Filtros ──
            const SizedBox(height: 8),
            Text('Filtros',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 12),

            // Vegetariano
            Obx(() => _FilterToggle(
                  emoji: '🌱',
                  label: 'Vegetariano',
                  value: ctrl.filterVegetarian.value,
                  onChanged: (_) => ctrl.toggleVegetarian(),
                )),
            const SizedBox(height: 8),

            // Sin Gluten
            Obx(() => _FilterToggle(
                  emoji: '🌾',
                  label: 'Sin Gluten',
                  value: ctrl.filterGlutenFree.value,
                  onChanged: (_) => ctrl.toggleGlutenFree(),
                )),
            const SizedBox(height: 8),

            // Picante
            Obx(() => _FilterToggle(
                  emoji: '🌶️',
                  label: 'Picante',
                  value: ctrl.filterSpicy.value,
                  onChanged: (_) => ctrl.toggleSpicy(),
                )),

            const SizedBox(height: 32),

            // ── Tema ──
            Text('Tema',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 12),

            Obx(() {
              final themeCtrl = Get.find<ThemeController>();
              return _FilterToggle(
                emoji: themeCtrl.isDarkTheme.value ? '🌙' : '☀️',
                label: 'Modo oscuro',
                value: themeCtrl.isDarkTheme.value,
                onChanged: (_) => themeCtrl.changeTheme(),
              );
            }),

            const SizedBox(height: 32),

            // ── Peligro ──
            Text('Peligro',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.red)),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showDeleteConfirm(context, ctrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.delete_forever, size: 20),
                label: const Text('Eliminar todos los datos',
                    style: TextStyle(fontSize: 13)),
              ),
            ),

            const SizedBox(height: 40),

            // ── Versión ──
            Center(
              child: Column(
                children: [
                  Text('Versión',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  Text('1.0.0',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, HamburguerController ctrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Eliminar todos los datos'),
        content: const Text(
          'Esto eliminará todos tus favoritos y preferencias. ¿Estás seguro?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await ctrl.clearAllData();
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✓ Datos eliminados'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _FilterToggle extends StatelessWidget {
  final String emoji;
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const _FilterToggle({
    required this.emoji,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? ThemeController.primaryPink : Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
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
