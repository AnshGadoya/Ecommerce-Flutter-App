import 'package:emart_app/consts/consts.dart';

import 'package:emart_app/view/home_Screen/bottom_nav_screen.dart';
import 'package:emart_app/view/home_Screen/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Widget_common/commonButton.dart';
import 'component/cart_controller.dart';

class PaymentMehtods extends StatefulWidget {
  const PaymentMehtods({Key? key}) : super(key: key);

  @override
  State<PaymentMehtods> createState() => _PaymentMehtodsState();
}

class _PaymentMehtodsState extends State<PaymentMehtods> {
  final _razorpay = Razorpay();
  final controller = Get.find<CartController>();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
_razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
  // Do something when payment succeeds
}

void _handlePaymentError(PaymentFailureResponse response) {
  // Do something when payment fails
}

void _handleExternalWallet(ExternalWalletResponse response) {
  // Do something when an external wallet was selected
}

@override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .size(18)
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
           
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                )
              : commonButton(
                  title: "Place Order",
                  color: redColor,
                  onPress: () async {
var options = {
  'key': 'rzp_test_41Sz88y9Lm3BB6',
  'amount': 100,
  'name': 'MRG_HUB',
  'description': 'Thank You For Buying',
  'prefill': {
    'contact': '7589562359',
    'email': 'mrg35590@gmail.com'
  }
};
//contact or email is optional it can only show on that id nd no.

_razorpay.open(options);
                    controller.addPalceOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Place Succesfully");
                    Get.offAll(() => BottomNavScreen());
                  },
                  textColor: whiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethods.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.chnagePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.black,
                            width:
                                controller.paymentIndex.value == index ? 4 : 2,
                            style: BorderStyle.solid)),
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 100,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsList[index],
                          fit: BoxFit.fill,
                          height: 100,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          width: double.maxFinite,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  value: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: "${paymentMethods[index]}"
                              .text
                              .size(14)
                              .fontFamily(semibold)
                              .make(),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
