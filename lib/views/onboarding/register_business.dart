import 'package:credigy/commands/register_business_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:flutter/material.dart';

class RegisterBusinessPage extends StatefulWidget {
  const RegisterBusinessPage({Key? key}) : super(key: key);

  @override
  State<RegisterBusinessPage> createState() => _RegisterBusinessPageState();
}

class _RegisterBusinessPageState extends State<RegisterBusinessPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _cashController =
      TextEditingController(text: "0");
  final TextEditingController _bankController =
      TextEditingController(text: "0");

  late DateTime date;
  late String? gender;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _cashController.dispose();
    _bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Business Name",
                  style: TextStyles.subtitle.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 15,
                ),
                UiTextField(
                  preffixIcon: const Icon(Icons.person),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "length of value must be greater than 3";
                    }
                  },
                  hintText: "Enter your business name",
                ),
                const SizedBox(height: 15),
                Text(
                  "Address",
                  style: TextStyles.body.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 8,
                ),
                UiTextField(
                  preffixIcon: const Icon(Icons.location_city_rounded),
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "length of value must be greater than 3";
                    }
                  },
                  hintText: "Enter your business address",
                ),
                const SizedBox(height: 15),
                Text(
                  "Email",
                  style: TextStyles.body.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 8,
                ),
                UiTextField(
                  preffixIcon: const Icon(Icons.email_rounded),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "length of value must be greater than 3";
                    }
                  },
                  hintText: "Enter your business email",
                ),
                const SizedBox(height: 15),
                Text(
                  "Phone",
                  style: TextStyles.body.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 8,
                ),
                UiTextField(
                  preffixIcon: const Icon(Icons.phone_android_rounded),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "length of value must be greater than 3";
                    }
                  },
                  hintText: "Enter your business address",
                ),
                /*   const SizedBox(height: 20),
                Text(
                  "Cash In Hand",
                  style: TextStyles.body.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(height: 10),
                UiTextField(
                  preffixIcon: const Icon(Icons.money_rounded),
                  hintText: "Enter amount of cash at hand",
                  controller: _cashController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Text("Money in Bank",
                    style: TextStyles.body.copyWith(letterSpacing: 1.5)),
                const SizedBox(height: 10),
                UiTextField(
                  preffixIcon: const Icon(Icons.money_off_csred_rounded),
                  hintText: "Enter amount of money in bank",
                  controller: _bankController,
                  keyboardType: TextInputType.number,
                ), */
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        var name = _nameController.value.text;
                        var address = _addressController.value.text;
                        var email = _emailController.value.text;
                        var phone = _phoneController.value.text;
                        var cash = double.parse(_cashController.text);
                        var bank = double.parse(_bankController.text);

                        await RegisterBusinessCommand().run(
                            businessName: name,
                            address: address,
                            email: email,
                            phone: phone);
                        Navigator.maybeOf(context)!.pushNamedAndRemoveUntil(
                            LandingPage.routeName, (route) => false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Submit",
                            style: TextStyles.h6,
                          ),
                          const Icon(Icons.navigate_next_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
