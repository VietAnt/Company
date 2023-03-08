import 'package:flutter/material.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/widgets/category_screen/category_card.dart';
import 'package:provider/provider.dart';

//Todo: CategoryList: Danh Sach Danh Muc
class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        //get the categories
        var list = db.categories;
        return ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: list.length,
          itemBuilder: (_, i) => CategoryCard(category: list[i]),
        );
      },
    );
  }
}
