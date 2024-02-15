import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListProductCard extends StatefulWidget {
  const WishListProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<WishListProductCard> createState() => _WishListProductCardState();
}

class _WishListProductCardState extends State<WishListProductCard> {
  bool isFav = false;

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
                  widget.product.image.toString(),
                  width: MediaQuery.of(context).size.width * 0.20,
                  fit: BoxFit.fitWidth,
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
                    border: Border.all(color: Colors.grey.withOpacity(.5))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.015,
                      vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w600),
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
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.015),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: MediaQuery.of(context).size.width * 0.035,
                              ),
                              Text(
                                widget.product.star.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          //const SizedBox(width: 15),

                          GetBuilder<CreateWishListController>(
                              builder: (createWishListController) {
                            return InkWell(
                              onTap: () async {
                                createWishListController
                                    .removeWishList(widget.product.id ?? 0);
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                await Get.find<ProductWishListController>()
                                    .getWishListProduct();
                              },
                              child: Icon(
                                Icons.delete_rounded,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Colors.black,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
