
import 'package:crafty_bay/presentation/state_holders/sentEmailOtpController.dart';
import 'package:crafty_bay/presentation/ui/screens/AuthScreen/otp_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    AssetsPath.applogo,
                    width: 100,
                  ),
                ),
                // craftyBayText(context,),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to CraftyBay',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your email address',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else if (!_emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<SentEmailOtpController>(builder: (controller) {
                  return Visibility(
                    visible: controller.isLoading == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => sentEmailOtpPressed(controller),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text('Continue'),
                        ),
                      ),
                    ),
                  );
                }),
                
              ],
            ),
          ),
        ));
  }

  Future<void> sentEmailOtpPressed(SentEmailOtpController controller) async {
    if (_formKey.currentState!.validate()) {
      final response =
          await controller.sentEmailOtp(_emailController.text.trim());
      if (response) {
        Get.to(() => OtpScreen(email: _emailController.text.trim()));
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: controller.errorMessage,
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }

}
