import 'dart:developer';

import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/checkout_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/carts/cart_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.id, this.strColor, this.selectedSize,this.cnt});

  final int? id,cnt;
  final String? strColor, selectedSize;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int counterr=0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartController>().getCart();
      counterr=widget.cnt??1;
    });
   // log(Get.find<AuthController>().token.toString());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
         Get.find<MainBottomNavController>().changeIndex(1);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Text('Cart'),
          leading: IconButton(
              onPressed: () {
                Get.find<MainBottomNavController>().changeIndex(0);
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
            init: Get.find<CartController>(),
            builder: (cartController) {
              return Column(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: cartController.isLoading == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: Visibility(
                        visible:
                            cartController.cartModel.cartList?.isNotEmpty ??
                                false,
                        replacement:
                            const Center(child: Text('No item in cart')),
                        child: ListView.separated(
                          itemCount:
                              cartController.cartModel.cartList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: CartScreenCard(
                                cartItem: cartController.cartModel.cartList![index],
                                onTapped: (int counter) {
                                  setState(() {
                                    counterr = counter;
                                  });
                                },
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 7),
                        ),
                      ),
                    ),
                  ),
                  buildCheckoutContainer(cartController.totalAmount,counterr),
                ],
              );
            }),
      ),
    );
  }

  Container buildCheckoutContainer(RxDouble totalAmount,int counterr) {
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
                  'Total Price',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Obx(() => Text(
                      '৳$totalAmount',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: addToCartController.isLoading == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: ElevatedButton(
                      onPressed: ()async{
                        if(totalAmount.value==0.0){
                          Get.showSnackbar(const GetSnackBar(
                            title: 'please add item to cart',
                            message: 'No item in cart',
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }
                        log('counter: $counterr');
                        log('id: ${widget.id}');
                        log('color: ${widget.strColor}');
                        log('size: ${widget.selectedSize}');
                        await Get.find<AddToCartController>().addToCart(
                            widget.id ?? 0,
                            widget.strColor ?? '',
                            widget.selectedSize ?? '',
                            counterr,
                        );
                         await Future.delayed(const Duration(seconds: 1));
                        Get.to(() => const CheckoutScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text('Checkout'),
                      )),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
