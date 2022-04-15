import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:health_app_fyp/screens/order_confirmation/order_confirmation.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../constants/layout_constants.dart';
import '../../controllers/basket_controller.dart';
import '../../designpatterns/strategy/delivery_interface.dart';
import '../../designpatterns/strategy/order.dart';
import '../../designpatterns/strategy/order_products.dart';

import '../../designpatterns/strategy/delivery_options.dart';
import '../../model/user_data.dart';
import '../../widgets/checkout_products.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../checkout/checkout_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  static String id = 'checkout_page';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  List paymentOptions = ["Paypal", "Card", "Bitcoin"];

  int _selectedIndex = 0;
  int index = 0;
  late ValueChanged<int?> onChanged;

  String cardNumber = "";
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showCard = false;
  bool showPaypal = false;
  bool showBitcoin = false;
  bool savedCard = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserInformation loggedInUser = UserInformation();
  bool isVisible = false;
  _showCard(savedCard) {
    if (showCard == false) {
      setState(() {
        showCard = false;
      });
    } else {
      setState(() {
        showCard = true;
      });
    }
  }

  _showBTC(showBitcoin) {
    if (showBitcoin == false) {
      setState(() {
        showBitcoin = false;
      });
    } else {
      setState(() {
        showBitcoin = true;
      });
    }
  }

  _showPaypal(showPaypal) {
    if (showPaypal == false) {
      setState(() {
        showPaypal = false;
      });
    } else {
      setState(() {
        showPaypal = true;
      });
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  var data = Get.arguments;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());

      cardNumber = loggedInUser.cardNum!;
      expiryDate = loggedInUser.expiryDate!;
      cardHolderName = loggedInUser.firstName! + " " + loggedInUser.secondName!;
      cvvCode = loggedInUser.cvv!;
    });
    if (mounted) {
      setState(() {});
    }
  }

  void asyncMethod(bool isVisible) async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());

      cardNumber = loggedInUser.cardNum!;
      expiryDate = loggedInUser.expiryDate!;
      cardHolderName = loggedInUser.firstName! + " " + loggedInUser.secondName!;
      cvvCode = loggedInUser.cvv!;

      if (mounted) {
        setState(() {});
      }
    });
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key(PaymentPage.id),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          asyncMethod(isVisible);
        },
        child: Scaffold(
            appBar: const CustomisedAppBar(title: "Payment"),
            bottomNavigationBar: const CustomisedNavigationBar(),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.grey,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
           
                child:
                   
                    SingleChildScrollView(
                  child: SizedBox(
                    height: 1250,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          SizedBox(
                            height: 100,
                          ),
                          for (var i = 0; i < paymentOptions.length; i++)
                            RadioListTile<int>(
                              title: Text(
                                paymentOptions[i],
                                style: TextStyle(color: Colors.white),
                              ),
                              value: i,
                              groupValue: index,
                      
                              onChanged: (int? value) {
                                setState(() {
                                  index = i;
                                });
                              },
                              dense: true,
                              activeColor: Colors.white,
                            ),

                          if (index == 0) ...[
                            Center(
                              child: SizedBox(
                                  height: 100,
                                  child: new Image.network(
                                      'https://1000logos.net/wp-content/uploads/2021/04/Paypal-logo.png')),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: NeumorphicButton(
                                child: const Text('Pay Now'),
                                onPressed: () {
                                  Get.to(OrderConfirmation());
                                },
                              ),
                            )
                          ],
                          if (index == 2) ...[
                            Center(
                              child: SizedBox(
                                  height: 100,
                                  child: new Image.network(
                                      "https://bitcoin.org/img/icons/opengraph.png?1648897668")),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: NeumorphicButton(
                                child: const Text('Pay Now'),
                                onPressed: () {
                                  Get.to(OrderConfirmation());
                                },
                              ),
                            ),
                          ],
                          if (index == 1) ...[
                            SizedBox(
                              height: 20,
                            ),
                            ListTileTheme(
                              child: ListTile(
                                leading: Icon(Icons.credit_card),
                                title: Text(
                                  'Saved Card',
                                  textScaleFactor: 1,
                                ),
                                trailing: Icon(Icons.chevron_right),
                                selected: false,
                                onTap: () => setState(
                                    () => isVisible = isVisible = false),
                              ),
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: 1,
                            ),

                           
                            CreditCardWidget(
                             
                              cardNumber: cardNumber,
                              expiryDate: expiryDate,
                              cardHolderName: cardHolderName,
                              cvvCode: cvvCode,
                              showBackView: isCvvFocused,
                              obscureCardNumber: true,
                              obscureCardCvv: true,
                              isHolderNameVisible: true,
                              cardBgColor: Colors.black,
                              backgroundImage: useBackgroundImage
                                  ? 'assets/card_bg.png'
                                  : null,
                              isSwipeGestureEnabled: true,
                              onCreditCardWidgetChange:
                                  (CreditCardBrand creditCardBrand) {},
                              customCardTypeIcons: <CustomCardTypeIcon>[
                                CustomCardTypeIcon(
                                  cardType: CardType.mastercard,
                                  cardImage: Image.asset(
                                    'assets/mastercard.png',
                                    height: 48,
                                    width: 48,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTileTheme(
                              child: ListTile(
                                leading: Icon(Icons.credit_card),
                                title: Text(
                                  'New Card',
                                  textScaleFactor: 1,
                                ),
                                trailing: Icon(Icons.chevron_right),
                                selected: false,
                                onTap: () =>
                                    setState(() => isVisible = !isVisible),
                              ),
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            if (isVisible) ShowCardForm(),

                           

                            SizedBox(
                              height: 20,
                            ),
                            const SizedBox(height: LayoutConstants.spaceM),

                            OrderDetails(
                              deliveryCostStrategy: data[0],
                              order: data[1],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: NeumorphicButton(
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.black,
                                 
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print('valid!');
                                    Get.to(OrderConfirmation());
                                  } else {
                                    print('invalid!');
                                  }
                                },
                              ),
                            ),
                          ],
                    
                        ]),
                  ),
                ))));
  }

  Expanded ShowCardForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CreditCardForm(
              formKey: formKey,
              obscureCvv: false,
              obscureNumber: false,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: cardHolderName,
              expiryDate: expiryDate,
              themeColor: Colors.blue,
              textColor: Colors.grey,
              cardNumberDecoration: InputDecoration(
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: border,
                enabledBorder: border,
              ),
              expiryDateDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Card Holder Name',
              ),
              onCreditCardModelChange: onCreditCardModelChange,
            ),
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}

void callThisMethod(bool isVisible) {
  debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
}

class ListTileButton extends StatelessWidget {
  final String text;
  final Widget leadingIcon;
  final Widget trailingIcon;
  final Function() onTap;
  final Color color;
  const ListTileButton(
      {required this.text,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.onTap,
      this.color = const Color(0xFF4338CA),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          text,
          textScaleFactor: 1,
        ),
        trailing: trailingIcon,
        selected: false,
        onTap: onTap,
      ),
      textColor: color,
      iconColor: color,
    );
  }
}
