import 'package:flutter/material.dart';
import 'package:hamburguesa_facil/pages/favorites.dart';
import 'package:hamburguesa_facil/pages/home.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _pages = [
    Home(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Text('🏠', style: TextStyle(fontSize: 22)),
            selectedIcon: Text('🏠', style: TextStyle(fontSize: 26)),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Text('❤️', style: TextStyle(fontSize: 22)),
            selectedIcon: Text('❤️', style: TextStyle(fontSize: 26)),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}

// ── Legacy classes kept for build compatibility ────────────────────────────

class FloatingActionButtonProps {
  final Icon icon;
  final Function() onPressed;
  FloatingActionButtonProps({required this.icon, required this.onPressed});
}

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.widgets,
    this.title,
    this.floatingButton,
  });

  final String? title;
  final List<Widget> widgets;
  final FloatingActionButtonProps? floatingButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      ),
      floatingActionButton: floatingButton != null
          ? FloatingActionButton(
              onPressed: floatingButton?.onPressed,
              child: floatingButton?.icon,
            )
          : null,
    );
  }
}
