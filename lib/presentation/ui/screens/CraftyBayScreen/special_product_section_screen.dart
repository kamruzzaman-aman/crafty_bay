import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialProductSectionScreen extends StatefulWidget {
  const SpecialProductSectionScreen({
    super.key,
    required this.sectionName,

  });

  final String sectionName;

  @override
  State<SpecialProductSectionScreen> createState() =>
      _SpecialProductSectionScreenState();
}

class _SpecialProductSectionScreenState extends State<SpecialProductSectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpecialProductController>().getSpecialProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(.5),
        title: Text(widget.sectionName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
              child: GetBuilder<SpecialProductController>(
                  builder: (productController) {
                return Visibility(
                  visible: productController.isLoading == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 3,
                      childAspectRatio:
                          MediaQuery.of(context).size.width * 0.0028,
                      mainAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                    ),
                    itemCount: productController
                            .remarkProductModel.ProductList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: productController
                            .remarkProductModel.ProductList![index],
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
