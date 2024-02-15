import 'package:crafty_bay/data/models/category_list_model.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/individual_categories_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesContainer extends StatefulWidget {
  const CategoriesContainer({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoriesContainer> createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(IndividualCategoriesScreen(
              name: widget.category.categoryName,
              id: widget.category.id??0,
            ));
          },
          child: Card(
            color: AppColors.primaryColor.withOpacity(.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            // color: AppColors.primaryColor.withOpacity(.2),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(widget.category.categoryImg.toString(),
                  width: 50, height: 50, fit: BoxFit.cover),
            )),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.category.categoryName.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
