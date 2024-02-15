import 'dart:developer';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/ui/screens/AuthScreen/email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/cart_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/review_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/products_details_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Color? _isSelectedColor;
  String? _isSelectedSize;
  ValueNotifier<int> counterNotifier = ValueNotifier<int>(1);
  late ValueNotifier<bool> isFavNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductDetailsController>().getProductDetails(widget.id);
      isFavNotifier = ValueNotifier<bool>(Get.find<ProductWishListController>()
          .wishListProductIds()
          .contains(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        return Visibility(
          visible: productDetailsController.isLoading == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: Visibility(
            visible: productDetailsController.isDataLoaded == true,
            replacement: const Center(
                child: Text(
              'No Data Available',
              style: TextStyle(fontSize: 20),
            )),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductDetailsCarousel(onTap: () {}, imageUrls: [
                          productDetailsController.productDetails.img1 ?? '',
                          productDetailsController.productDetails.img2 ?? '',
                          productDetailsController.productDetails.img3 ?? '',
                          productDetailsController.productDetails.img4 ?? '',
                        ]),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: productDetailsController.isLoading == false,
                          replacement: const Center(
                            child: LinearProgressIndicator(),
                          ),
                          child: ProductDetailsBody(
                            productDetails:
                                productDetailsController.productDetails,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buildCheckoutContainer(
                    productDetails: productDetailsController.productDetails)
              ],
            ),
          ),
        );
      }),
    );
  }

  Container buildCheckoutContainer({required ProductDetails productDetails}) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${productDetails.product?.price ?? ''}',
                  style: const TextStyle(
                      fontSize: 24,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: addToCartController.isLoading == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: () async {
                      log(Get.find<AuthController>().token.toString());
                      if (Get.find<AuthController>().token == null) {
                        Get.showSnackbar(const GetSnackBar(
                          message: 'Please Login First',
                          duration: Duration(seconds: 2),
                        ));
                        Get.offAll(() => const EmailScreen());
                        return;
                      } else {
                        if (_isSelectedColor != null &&
                            _isSelectedSize != null) {
                          final strColor = colorToColorName(_isSelectedColor!);
                          final response = await Get.find<AddToCartController>()
                              .addToCart(widget.id, strColor, _isSelectedSize!,
                                  counterNotifier.value);
                          if (response) {
                            Get.showSnackbar(const GetSnackBar(
                              message: 'Added cart!!',
                              title: 'Cart added!!',
                              duration: Duration(seconds: 2),
                            ));
                            Get.to(() => CartScreen(
                                id: widget.id,
                                strColor: strColor,
                                selectedSize: _isSelectedSize,
                                cnt: counterNotifier.value));
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              message:'Please login first',
                              duration: Duration(seconds: 2),
                            ));
                            Get.find<CartController>().removeItem(widget.id);
                            Get.offAll(() => const EmailScreen());
                          }
                        }
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text('Add to Cart'),
                    )),
              );
            })
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding ProductDetailsBody({required ProductDetails productDetails}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                productDetails.product?.title ?? '',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              )),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (counterNotifier.value > 1) {
                        counterNotifier.value--;

                      }
                    },
                    child: buildCounterContainer(
                      color: counterNotifier.value == 1
                          ? AppColors.primaryColor.withOpacity(.4)
                          : AppColors.primaryColor,
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ValueListenableBuilder(
                      valueListenable: counterNotifier,
                      builder: (context, value, child) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      counterNotifier.value++;
                      log(counterNotifier.value.toString());
                    },
                    child: buildCounterContainer(
                      icon: const Icon(Icons.add),
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 24,
              ),
              Text(
                productDetails.product?.star?.toStringAsFixed(2) ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Get.to(() => ReviewScreen(
                        id: widget.id,
                      ));
                },
                child: const Text(
                  'Reviews',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 10),
              GetBuilder<CreateWishListController>(
                  builder: (createWishListController) {
                return InkWell(
                  onTap: () {
                    isFavNotifier.value = !isFavNotifier.value;
                    if (isFavNotifier.value) {
                      createWishListController.createWishList(widget.id);
                      Get.showSnackbar(
                        const GetSnackBar(
                          title: 'Added to wishlist',
                          message: 'Product added to wishlist',
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      createWishListController.removeWishList(widget.id);
                      Get.showSnackbar(
                        const GetSnackBar(
                          title: 'Removed from wishlist',
                          message: 'Product removed from wishlist',
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: GetBuilder<ProductWishListController>(
                      init: Get.find<ProductWishListController>(),
                      builder: (productWishListController) {
                        bool isFav = productWishListController
                            .wishListProductIds()
                            .contains(widget.id);
                        return Card(
                          color: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: isFav
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: MediaQuery.of(context).size.width *
                                        0.035,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                          ),
                        );
                      }),
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          if (productDetails.color != null)
            ColorSelector(
                colors: productDetails.color!
                    .split(',')
                    .map((color) => getColorFromString(color))
                    .toList(),
                onTap: (isSelectedColor) {
                  _isSelectedColor = isSelectedColor;
                }),
          const SizedBox(height: 10),
          const Text('Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          if (productDetails.size != null)
            SizeSelector(
                sizes: productDetails.size!.split(','),
                onTap: (isSelectedSize) {
                  log(isSelectedSize.toString());
                  _isSelectedSize = isSelectedSize.toString();
                }),
          const SizedBox(height: 10),
          const Text('Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Text(
            productDetails.product?.shortDes ?? '',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Card buildCounterContainer({
    required Icon icon,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      color: color,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        child: icon,
      ),
    );
  }

  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == 'red') {
      return Colors.red;
    }
    if (color == 'white') {
      return Colors.white;
    }
    if (color == 'green') {
      return Colors.green;
    }
    return Colors.black;
  }

  String colorToColorName(Color colorCode) {
    if (colorCode == Colors.red) {
      return 'Red';
    }
    if (colorCode == Colors.white) {
      return 'White';
    }
    if (colorCode == Colors.green) {
      return 'Green';
    }
    return 'black';
  }

// Color getColorFromString(String ColorCode) {
//   String codeString = ColorCode.replaceAll("#", "");
//   String code = '0xff$codeString';
//   return Color(int.parse(code));
// }
//
// String colorToHashColorCode(String colorCode) {
//   return colorCode
//       .toString()
//       .replaceAll('0xff', '#')
//       .replaceAll('Color(', '')
//       .replaceAll(')', '');
// }
}
