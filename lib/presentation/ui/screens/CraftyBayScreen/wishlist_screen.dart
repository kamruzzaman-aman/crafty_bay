import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/wishlist/wish_list_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductWishListController>().getWishListProduct();
    });
  }
  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavController>().changeIndex(2);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor.withOpacity(.5),
            title: const Text('Wishlist'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.find<MainBottomNavController>().changeIndex(0);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: GetBuilder<ProductWishListController>(
                    builder: (productWishListController) {
                      return Visibility(
                        visible: productWishListController.isLoading==false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: Visibility(
                          visible: productWishListController.wishListModel.data?.isNotEmpty??false,
                          replacement: const Center(
                            child: Text('No Product in Wishlist'),
                          ),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 2
                                  : 3,
                              childAspectRatio: MediaQuery.of(context).size.width * 0.0027,
                              mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                            ),
                            itemCount: productWishListController.wishListModel.data?.length??0,
                            itemBuilder: (context, index) {
                              return WishListProductCard(product:productWishListController.wishListModel.data![index].product!);
                            },
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
