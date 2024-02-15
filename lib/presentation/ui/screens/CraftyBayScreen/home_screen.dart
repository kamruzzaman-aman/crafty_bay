import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/popular_product_section_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/categories_container.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/home_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/my_appbar.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/product_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/search_inputdecoration.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/get_brand_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_carousel_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/brand_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/new_product_section_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/special_product_section_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/brand_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                TextFormField(decoration: searchInputDecoration()),
                const SizedBox(height: 7),
                SizedBox(
                  height: width * 0.5,
                  child: GetBuilder<HomeCarouselProductController>(
                      builder: (homeCarouselProductController) {
                    return Visibility(
                      visible: homeCarouselProductController.isLoading == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: HomeCarousel(
                        homeCarouselProductList: homeCarouselProductController
                                .homeCarouselProductModel
                                .homeCarouselProductList ??
                            [],
                        onTap: () {},
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 7),
                SectionTitle(
                  text: 'All Categories',
                  onTap: () {
                    Get.find<MainBottomNavController>().changeIndex(1);
                  },
                ),
                const SizedBox(height: 5),
                buildCategoryContainer,
                const SizedBox(height: 5),
                SectionTitle(
                  text: 'All Brands',
                  onTap: () {
                    Get.to(const BrandScreen());
                  },
                ),
                buildBrandContainer,
                const SizedBox(height: 5),
                SectionTitle(
                  text: 'Popular',
                  onTap: () {
                    Get.to(() => const PopularProductSectionScreen(
                          sectionName: 'Popular Product',
                        ));
                  },
                ),
                const SizedBox(height: 5),
      
                GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                    return Visibility(
                        visible: popularProductController.isLoading==false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: buildProductCardByRemark(
                          remarkProductList:popularProductController.remarkProductModel.ProductList??[]
                        ));
                  }
                ),
                SectionTitle(
                  text: 'Special',
                  onTap: () {
                    Get.to(() => const SpecialProductSectionScreen(
                          sectionName: 'Special Product',
                        ));
                  },
                ),
                const SizedBox(height: 5),
                GetBuilder<SpecialProductController>(
                    builder: (specialProductController) {
                      return Visibility(
                          visible: specialProductController.isLoading==false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: buildProductCardByRemark(
                              remarkProductList:specialProductController.remarkProductModel.ProductList??[]
                          ));
                    }
                ),
                SectionTitle(
                  text: 'New',
                  onTap: () {
                    Get.to(() => const NewProductSectionScreen(
                          sectionName: 'New Product',
                        ));
                  },
                ),
                const SizedBox(height: 5),
                GetBuilder<NewProductController>(
                    builder: (newProductController) {
                      return Visibility(
                          visible: newProductController.isLoading==false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: buildProductCardByRemark(
                              remarkProductList:newProductController.remarkProductModel.ProductList??[]
                          ));
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildProductCardByRemark({required List<Product> remarkProductList}) {
    return SizedBox(
      height: 180,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: remarkProductList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: remarkProductList[index],
          );
        },
      ));
  }

  SizedBox get buildCategoryContainer {
    return SizedBox(
      height: 120,
      child:
          GetBuilder<CategotyListController>(builder: (categoryListController) {
        final categoryList =
            categoryListController.categoryListModel.categoryList;
        return Visibility(
          visible: categoryListController.isLoading == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList?.length ?? 0,
            itemBuilder: (context, index) {
              return CategoriesContainer(
                category: categoryList![index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: MediaQuery.of(context).size.width * 0.07);
            },
          ),
        );
      }),
    );
  }
  SizedBox get buildBrandContainer {
    return SizedBox(
      height: 120,
      child:
      GetBuilder<BrandController>(builder: (brandController) {
        return Visibility(
          visible: brandController.isLoading == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brandController.brand.brandList?.length ?? 0,
            itemBuilder: (context, index) {
              return BrandContainer(brand: brandController.brand.brandList![index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: MediaQuery.of(context).size.width * 0.07);
            },
          ),
        );
      }),
    );
  }
}
