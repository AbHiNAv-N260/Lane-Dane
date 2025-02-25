import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lane_dane/data/local/objectbox.g.dart';

import '../main.dart';
import '../models/categories_model.dart';

class CategoryVM extends GetxController {
  var categoryModel = <CategoriesModel>[].obs;
  static final _categoryBox = OBJECTBOX.store.box<CategoriesModel>();
  CategoriesModel create({
    int? id,
    int? serverId,
    required String categoryName,
    DateTime? lastAccessed,
  }) {
    CategoriesModel category = CategoriesModel(
        message: categoryName, lastAccessed: lastAccessed ?? DateTime.now());

    category.id = id ?? 0;
    category.serverId = serverId ?? 0;
    int newId = _categoryBox.put(category);

    if (serverId == null) {
      category.serverId = newId * -1;
      _categoryBox.put(category);
    }

    return category;
  }

  CategoriesModel? retrieve(int id) {
    if (id == 0) {
      return null;
    }
    return _categoryBox.get(id);
  }

  CategoriesModel updateOrCreate({
    int? id,
    int? serverId,
    required String message,
    DateTime? lastAccessed,
  }) {
    QueryBuilder<CategoriesModel> querybuilder = _categoryBox.query(
        CategoriesModel_.id
            .equals(id ?? 0)
            .or(CategoriesModel_.serverId.equals(serverId ?? 0))
            .or(CategoriesModel_.message
                .equals(message, caseSensitive: false)));
    Query<CategoriesModel> query = querybuilder.build();

    CategoriesModel? existingCategory = query.findFirst();
    CategoriesModel newCategory;
    if (existingCategory != null) {
      newCategory = create(
        id: existingCategory.id,
        serverId: serverId ?? existingCategory.serverId,
        categoryName: message,
        lastAccessed: lastAccessed ?? existingCategory.lastAccessed,
      );
    } else {
      newCategory = create(
        id: id,
        serverId: serverId,
        categoryName: message,
        lastAccessed: lastAccessed,
      );
    }
    return newCategory;
  }

  void index(String query) {
    final categories = categoryModel;
    final result = categories
        .where((element) => element.message.startsWith(query))
        .toList();

    debugPrint('Result size ${result.length}');

    if (result.isEmpty) {
      CategoriesModel category = create(categoryName: query);
      categories.add(category);
      debugPrint('Result size + ${result.length}');
      // close(context, category);
    }
  }

  void search(String query) {
    final suggestions = categoryModel.where((element) =>
        element.message.toLowerCase().startsWith(query.toLowerCase()));
    debugPrint('Suggestions ${suggestions.length}');
  }

  CategoriesModel? retrieveCategoryByServerId(int serverId) {
    QueryBuilder<CategoriesModel> querybuilder =
        _categoryBox.query(CategoriesModel_.serverId.equals(serverId));
    Query query = querybuilder.build();
    CategoriesModel? category = query.findFirst();
    return category;
  }

  List<CategoriesModel> retrieveAll({bool sortedByLastAccessed = true}) {
    if (!sortedByLastAccessed) {
      return _categoryBox.getAll();
    }

    // QueryBuilder<CategoriesModel> querybuilder = _categoryBox.query();
    // querybuilder.order(CategoriesModel_.lastAccessed, flags: Order.descending);
    // Query<CategoriesModel> query = querybuilder.build();

    // List<CategoriesModel> categoryList = query.find();
    return _categoryBox.query()
    .order(CategoriesModel_.lastAccessed, flags: Order.descending)
    .build().find();
  }

  CategoriesModel? updateCategoryServerId({
    required int oldId,
    required int newId,
  }) {
    CategoriesModel? category = retrieveCategoryByServerId(oldId);
    if (category == null) {
      return category;
    }

    category.serverId = newId;
    _categoryBox.put(category);

    return category;
  }

  CategoriesModel? updateCategory(CategoriesModel updatedCategory) {
    CategoriesModel? oldCategory = _categoryBox.get(updatedCategory.id!);
    if (oldCategory == null) {
      return oldCategory;
    }

    _categoryBox.put(updatedCategory);
    return updatedCategory;
  }

  // void show() {}
  // void update() {}
  // void delete() {}

  void preloadCategories() {
    GetStorage storage = GetStorage();
    String categoriesPreloadedKey = 'categories-preloaded';
    if (storage.hasData(categoriesPreloadedKey)) {
      return;
    }

    for (String category in _defaultCategoryList) {
      create(categoryName: category);
    }
    storage.write(categoriesPreloadedKey, true);
  }
}

List<String> _defaultCategoryList = [
  'Rent',
  'Loans/Instalments',
  'Savings',
  'Investments',
  'Fuel',
  'Electricity',
  'Recharge',
  'Food',
  'Household',
  'Medical',
  'Clothing',
  'Personal care',
  'Transport',
  'Vehicle',
  'Education',
  'Family',
  'Entertainment',
  'Hobbies',
  'Travelling',
  'Membership'
];
