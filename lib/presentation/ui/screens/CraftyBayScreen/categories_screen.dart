import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/categories_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavController>().changeIndex(0);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor.withOpacity(.5),
            leading: IconButton(
              onPressed: () {
                Get.find<MainBottomNavController>().changeIndex(0);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text('Categories'),
          ),
          body: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: GetBuilder<CategotyListController>(
              builder: (categotyListController) {
                return Visibility(
                  visible: categotyListController.isLoading == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: GridView.builder(
                      itemCount: categotyListController.categoryListModel.categoryList?.length??0,
                      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: .78,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FittedBox(child: CategoriesContainer(
                            category: categotyListController.categoryListModel.categoryList![index],
                          )),
                        );
                      }),
                );
              }
            ),
          )),
    );
  }
}
