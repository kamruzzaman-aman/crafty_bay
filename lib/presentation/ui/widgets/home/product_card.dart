import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late ValueNotifier<bool> isFavNotifier ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFavNotifier = ValueNotifier<bool>(Get.find<ProductWishListController>()
          .wishListProductIds()
          .contains(widget.product.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(
          id: widget.product.id ?? 0,
        ));
      },
      child: AspectRatio(
        aspectRatio: MediaQuery.of(context).size.height * 0.0012,
        child: Card(
          margin: const EdgeInsets.only(right: 12),
          elevation: 0,
          color: AppColors.primaryColor.withOpacity(.3),
          child: Column(
            children: [
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.product.image ?? '',
                  width: MediaQuery.of(context).size.width * 0.20,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.grey.withOpacity(.5)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.015,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 3),
                      Text(
                        widget.product.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                          MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${widget.product.price.toString()}',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize:
                                  MediaQuery.of(context).size.width *
                                      0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.015,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size:
                                MediaQuery.of(context).size.width * 0.035,
                              ),
                              Text(
                                widget.product.star.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  MediaQuery.of(context).size.width *
                                      0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<CreateWishListController>(
                            builder: (createWishListController) {
                              return InkWell(
                                onTap: () {
                                  isFavNotifier.value = !isFavNotifier.value;
                                  if (isFavNotifier.value) {
                                    createWishListController.createWishList(
                                        widget.product.id ?? 0);
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Added to wishlist!!',
                                        message:
                                        'Product added to wishlist',
                                        duration:
                                        Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    createWishListController.removeWishList(
                                        widget.product.id ?? 0);
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Removed from wishlist',
                                        message:
                                        'Product removed from wishlist',
                                        duration:
                                        Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: GetBuilder<ProductWishListController>(
                                  init: Get.find<ProductWishListController>(),
                                  builder: (productWishListController) {
                                    bool isFav = productWishListController
                                        .wishListProductIds()
                                        .contains(widget.product.id);
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
                                          size: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.035,
                                        )
                                            : Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.035,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
