import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hamburguesa_facil/data/breads.dart' show breads;
import 'package:hamburguesa_facil/data/dressing.dart' show dressing;
import 'package:hamburguesa_facil/data/meats.dart' show meats;
import 'package:hamburguesa_facil/data/toppings.dart' show toppings;
import 'package:hamburguesa_facil/model/bread.dart';
import 'package:hamburguesa_facil/model/dressing.dart';
import 'package:hamburguesa_facil/model/hamburguer.dart';
import 'package:hamburguesa_facil/model/meat.dart';
import 'package:hamburguesa_facil/model/topping.dart';

class HamburguerController extends GetxController {
  // ── Current selection indices ──
  final RxInt breadIndex = 0.obs;
  final RxInt toppingIndex = 0.obs;
  final RxInt meatIndex = 0.obs;
  final RxInt dressingIndex = 0.obs;

  // ── Active filters ──
  final RxBool filterVegetarian = false.obs;
  final RxBool filterGlutenFree = false.obs;
  final RxBool filterSpicy = false.obs;

  // ── Favorites ──
  final RxList<Hamburguer> favorites = <Hamburguer>[].obs;

  // ── Filtered lists ──
  List<Bread> get filteredBreads => _applyFilters(breads).cast<Bread>();
  List<Topping> get filteredToppings => _applyFilters(toppings).cast<Topping>();
  List<Meat> get filteredMeats => _applyFilters(meats).cast<Meat>();
  List<Dressing> get filteredDressings =>
      _applyFilters(dressing).cast<Dressing>();

  // ── Current selection ──
  Bread get currentBread {
    final list = filteredBreads;
    if (list.isEmpty) return breads[breadIndex.value % breads.length];
    return list[breadIndex.value % list.length];
  }

  Topping get currentTopping {
    final list = filteredToppings;
    if (list.isEmpty) return toppings[toppingIndex.value % toppings.length];
    return list[toppingIndex.value % list.length];
  }

  Meat get currentMeat {
    final list = filteredMeats;
    if (list.isEmpty) return meats[meatIndex.value % meats.length];
    return list[meatIndex.value % list.length];
  }

  Dressing get currentDressing {
    final list = filteredDressings;
    if (list.isEmpty) return dressing[dressingIndex.value % dressing.length];
    return list[dressingIndex.value % list.length];
  }

  double get estimatedTotalTime =>
      currentBread.estimatedTime +
      currentTopping.estimatedTime +
      currentMeat.estimatedTime +
      currentDressing.estimatedTime;

  Hamburguer get currentCombo => Hamburguer(
        estimatedTime: estimatedTotalTime,
        bread: currentBread,
        topping: currentTopping,
        meat: currentMeat,
        dressing: currentDressing,
      );

  // ── Randomize ──
  void randomize() {
    final rng = Random();
    breadIndex.value = rng.nextInt(
        filteredBreads.isEmpty ? breads.length : filteredBreads.length);
    toppingIndex.value = rng.nextInt(
        filteredToppings.isEmpty ? toppings.length : filteredToppings.length);
    meatIndex.value = rng
        .nextInt(filteredMeats.isEmpty ? meats.length : filteredMeats.length);
    dressingIndex.value = rng.nextInt(
        filteredDressings.isEmpty ? dressing.length : filteredDressings.length);
  }

  // ── Favorites ──
  bool isFavorite(Hamburguer h) => favorites.any(
        (f) =>
            f.bread.name == h.bread.name &&
            f.topping.name == h.topping.name &&
            f.meat.name == h.meat.name &&
            f.dressing.name == h.dressing.name,
      );

  Future<void> addFavorite(Hamburguer h) async {
    if (!isFavorite(h)) {
      favorites.add(h);
      await _saveFavorites();
    }
  }

  Future<void> removeFavorite(Hamburguer h) async {
    favorites.removeWhere(
      (f) =>
          f.bread.name == h.bread.name &&
          f.topping.name == h.topping.name &&
          f.meat.name == h.meat.name &&
          f.dressing.name == h.dressing.name,
    );
    await _saveFavorites();
  }

  // ── Filters ──
  void toggleVegetarian() {
    filterVegetarian.value = !filterVegetarian.value;
    _clampIndices();
  }

  void toggleGlutenFree() {
    filterGlutenFree.value = !filterGlutenFree.value;
    _clampIndices();
  }

  void toggleSpicy() {
    filterSpicy.value = !filterSpicy.value;
    _clampIndices();
  }

  // ── Preferences ──
  Future<void> saveUserPreferences({
    required bool vegetarian,
    required bool glutenFree,
    required bool spicy,
  }) async {
    filterVegetarian.value = vegetarian;
    filterGlutenFree.value = glutenFree;
    filterSpicy.value = spicy;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('filter_vegetarian', vegetarian);
    await prefs.setBool('filter_gluten_free', glutenFree);
    await prefs.setBool('filter_spicy', spicy);
  }

  Future<void> loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    filterVegetarian.value = prefs.getBool('filter_vegetarian') ?? false;
    filterGlutenFree.value = prefs.getBool('filter_gluten_free') ?? false;
    filterSpicy.value = prefs.getBool('filter_spicy') ?? false;
    await _loadFavorites();
  }

  // ── Private helpers ──
  List _applyFilters(List items) {
    return items.where((item) {
      if (filterVegetarian.value && !item.isVegetarian) return false;
      if (filterGlutenFree.value && !item.isGlutenFree) return false;
      if (filterSpicy.value && !item.isSpicy) return false;
      return true;
    }).toList();
  }

  void _clampIndices() {
    final bl = filteredBreads.isEmpty ? breads.length : filteredBreads.length;
    final tl =
        filteredToppings.isEmpty ? toppings.length : filteredToppings.length;
    final ml = filteredMeats.isEmpty ? meats.length : filteredMeats.length;
    final dl =
        filteredDressings.isEmpty ? dressing.length : filteredDressings.length;
    if (breadIndex.value >= bl) breadIndex.value = 0;
    if (toppingIndex.value >= tl) toppingIndex.value = 0;
    if (meatIndex.value >= ml) meatIndex.value = 0;
    if (dressingIndex.value >= dl) dressingIndex.value = 0;
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = favorites
        .map((h) => json.encode({
              'title': h.title,
              'bread': h.bread.name,
              'topping': h.topping.name,
              'meat': h.meat.name,
              'dressing': h.dressing.name,
              'estimatedTime': h.estimatedTime,
            }))
        .toList();
    await prefs.setStringList('favorites', list);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('favorites') ?? [];
    favorites.clear();
    for (final item in list) {
      try {
        final map = json.decode(item) as Map<String, dynamic>;
        final bread = breads.firstWhere((b) => b.name == map['bread'],
            orElse: () => breads.first);
        final topping = toppings.firstWhere((t) => t.name == map['topping'],
            orElse: () => toppings.first);
        final meat = meats.firstWhere((m) => m.name == map['meat'],
            orElse: () => meats.first);
        final dress = dressing.firstWhere((d) => d.name == map['dressing'],
            orElse: () => dressing.first);
        favorites.add(Hamburguer(
          title: map['title'] as String?,
          estimatedTime: (map['estimatedTime'] as num).toDouble(),
          bread: bread,
          topping: topping,
          meat: meat,
          dressing: dress,
        ));
      } catch (_) {}
    }
  }
}
