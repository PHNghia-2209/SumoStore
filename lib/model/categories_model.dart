// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

class CategoriesModel {
    List<Category> categories;

    CategoriesModel({
        required this.categories,
    });

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

}

class Category {
    String name;
    List<String> subcategory;

    Category({
        required this.name,
        required this.subcategory,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
    );

}
