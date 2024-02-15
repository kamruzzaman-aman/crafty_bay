import 'package:crafty_bay/data/models/payment_model.dart';
import 'package:crafty_bay/data/service/network_caller.dart';
import 'package:crafty_bay/data/utilities/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class InvoiceCreateController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  PaymentModel _paymentModel = PaymentModel();
  PaymentModel get paymentModel => _paymentModel;

  Future<bool> createInvoice() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(
        Urls.invoiceCreateUrl,token: Get.find<AuthController>().token);
    _isLoading = false;
    if (response.isSuccess) {
      _paymentModel = PaymentModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}