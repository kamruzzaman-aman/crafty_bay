import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/create_review_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/review_screen.dart';
class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.id});
  final int id;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        )
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            TextFormField(
              maxLines: 3,
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Write Your Review',
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _ratingController,
              decoration: const InputDecoration(
                hintText: 'Rating',
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<CreateReviewController>(
              builder: (createReviewController) {
                return SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: createReviewController.isLoading==false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(onPressed: () async {
                      final response=await createReviewController.createReview(
                        _descriptionController.text,
                         widget.id.toString(),
                        _ratingController.text
                      );
                      if(response){
                        Get.to(()=>ReviewScreen(id: widget.id));
                      }
                      else{
                        Get.snackbar('Error', 'Failed to create review');
                      }
                    }, child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Submit'),
                    )
                    ),
                  ),
                );
              }
            )],
        ),
      )
    );
  }
}
