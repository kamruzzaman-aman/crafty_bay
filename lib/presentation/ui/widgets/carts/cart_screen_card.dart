import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartScreenCard extends StatefulWidget {
  const CartScreenCard({
    Key? key,
    required this.cartItem,
    this.onTapped,
  }) : super(key: key);

  final CartItem cartItem;
  final ValueChanged<int>? onTapped;

  @override
  State<CartScreenCard> createState() => _CartScreenCardState();
}

class _CartScreenCardState extends State<CartScreenCard> {
  late ValueNotifier<int> counterNotifier;

  @override
  void initState() {
    super.initState();
    counterNotifier = ValueNotifier<int>(widget.cartItem.qty);
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      elevation: 3,
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.3),
            borderRadius: BorderRadius.circular(0).copyWith(
              bottomLeft: const Radius.circular(10),
              topLeft: const Radius.circular(10),
            ),
            border: const Border(
              right: BorderSide(
                color: Colors.black38,
                width: .7,
              ),
            ),
          ),
          width: cardWidth * 0.30,
          height: cardWidth * 0.35,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(widget.cartItem.product?.image ?? ''),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cartItem.product?.title ?? 'Product Title',
                      style: TextStyle(
                        fontSize: cardWidth * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Get.find<CartController>()
                            .removeItem(widget.cartItem.product?.id ?? 0);
                      },
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red.shade400,
                        size: cardWidth * 0.07,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Color: ${widget.cartItem.color}',
                      style: TextStyle(
                          fontSize: cardWidth * 0.05, color: Colors.grey),
                    ),
                    SizedBox(width: cardWidth * 0.02),
                    Text(
                      'Size: ${widget.cartItem.size}',
                      style: TextStyle(
                          fontSize: cardWidth * 0.05, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.cartItem.product?.price ?? 0}',
                      style: TextStyle(
                        fontSize: cardWidth * 0.06,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (counterNotifier.value > 1) {
                              counterNotifier.value--;
                              Get.find<CartController>().updateQuantity(
                                  widget.cartItem.id ?? 0,
                                  counterNotifier.value);
                              widget.onTapped!(counterNotifier.value);
                            }
                          },
                          child: buildCounterContainer(
                            color: counterNotifier.value == 1
                                ? AppColors.primaryColor.withOpacity(.4)
                                : AppColors.primaryColor,
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: cardWidth * 0.01),
                        ValueListenableBuilder(
                            valueListenable: counterNotifier,
                            builder: (context, value, child) {
                              return Text(
                                value.toString(),
                                style: TextStyle(
                                  fontSize: cardWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                        SizedBox(width: cardWidth * 0.01),
                        InkWell(
                          onTap: () {
                            counterNotifier.value++;
                            Get.find<CartController>().updateQuantity(
                                widget.cartItem.id ?? 0, counterNotifier.value);
                            widget.onTapped!(counterNotifier.value);
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
              ],
            ),
          ),
        ),
      ]),
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
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: icon,
      ),
    );
  }
}
