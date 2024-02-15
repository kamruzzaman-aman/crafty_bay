import 'package:crafty_bay/presentation/state_holders/get_review_controller.dart';
import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.id});
  final int id;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<GetReviewController>().getReview(widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Review'),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            )),
        body: GetBuilder<GetReviewController>(
          builder: (getReviewController) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: getReviewController.reviewModel.reviewList?.length??0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: buildReviewCard(
                            getReviewController.reviewModel.reviewList![index]
                        ),
                      );
                    },
                  ),
                ),
                buildReviewContainer(
                    getReviewController.reviewModel.reviewList?.length??0
                ),
              ],
            );
          }
        ));
  }

  Card buildReviewCard(Review review) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 10,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  review.profile?.cusName ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
                review.description ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Container buildReviewContainer(int length) {
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
             Text(
              'Review ($length)',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  Get.to( CreateReviewScreen(id:widget.id));
                },
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
