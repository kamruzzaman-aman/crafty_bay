import 'package:crafty_bay/presentation/state_holders/invoice_create_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/CraftyBayScreen/billing_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InvoiceCreateController>().createInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout!'
          ),
        ),
          body: GetBuilder<InvoiceCreateController>(
          builder: (invoiceCreateController) {
        final invoice =
            invoiceCreateController.paymentModel.PaymentWrapperList?.first;
        return Visibility(
          visible: invoiceCreateController.isLoading == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.separated(
                  itemCount: invoice?.paymentMethodList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                          invoice?.paymentMethodList![index].logo ?? ''),
                      title: Text('${invoice?.paymentMethodList![index].name}'),
                      subtitle: Row(
                        children: [
                          Text('${invoice?.paymentMethodList![index].gw}'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('(${invoice?.paymentMethodList![index].type})'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Get.to(BillingScreen(url: invoice?.paymentMethodList![index].redirectGatewayURL??''));
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const Divider(
                      height: 10,
                    );
                  },
                ),
              ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: ${invoice?.total.toString() ?? ''}'),
                        Text('Vat: ${invoice?.vat.toString() ?? ''}'),
                        Text('Payable: ${invoice?.payable.toString() ?? ''}'),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          )

            ],
          ),
        );
      })),
    );
  }
}
