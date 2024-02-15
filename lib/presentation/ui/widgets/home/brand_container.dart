import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/brand_model.dart';
import '../../screens/CraftyBayScreen/individual_categories_screen.dart';
import '../../utility/app_colors.dart';

class BrandContainer extends StatefulWidget {
  const BrandContainer({
    super.key,
    required this.brand,
  });

  final Brand brand;

  @override
  State<BrandContainer> createState() => _BrandContainerState();
}

class _BrandContainerState extends State<BrandContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(IndividualCategoriesScreen(
              name: widget.brand.brandName,
              id: widget.brand.id??0,
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
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.brand.brandImg.toString(),
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                )),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.brand.brandName.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
