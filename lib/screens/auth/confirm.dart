import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/utils/color.dart';

class ConfirmOTP extends StatefulWidget {
  const ConfirmOTP({super.key});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  final List<TextEditingController> _textControllers =
      List.generate(6, (i) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 1, child: Container()),
              const Text(
                "Confirm OTP code",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: appthemecolor),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "You just need to enter the OTP sent to the registered phone number 9119922076",
                style: TextStyle(height: 1.4, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Improved spacing
                  children: [
                    for (int i = 0; i < 6; i++) // Iterate 6 times
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            height: 80,
                            child: TextField(
                              key: ValueKey(i),
                              controller: _textControllers[i],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 25),
                              onChanged: (value) {
                                if (value.isNotEmpty && value.length == 1) {
                                  if (i + 1 < 6) {

                                    FocusScope.of(context)
                                        .nextFocus(); // Move focus forward
                                  }
                                } else if ( i > 0) {
                                
                                  FocusScope.of(context)
                                      .previousFocus(); // Move focus back on backspace
                                  _textControllers[i]
                                      .clear(); // Clear previous field on backspace
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appthemecolor),
                                ),
                                fillColor: appthemecolor.withOpacity(0.2),
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(flex: 5, child: Container()),
              InkWell(
                  onTap: () {}, child: SvgPicture.asset("assets/continue.svg")),
              Flexible(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
