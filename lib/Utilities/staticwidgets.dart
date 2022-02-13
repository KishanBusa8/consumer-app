// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hashching/Utilities/simplefiedwidgets.dart';
// import 'package:hashching/styles/hexcolor.dart';
// import 'package:hashching/styles/masterstyle.dart';

// class StaticWidgets{
//     Future _otpInputDialog({context,phoneController, otpFormKey,otpController,onchanged,otpResend,}) async {

//     return showDialog(
//       context: context,
//       barrierDismissible:
//           true, // dialog is dismissible with a tap on the barrier
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(14.0))),
//           contentPadding: EdgeInsets.only(top: 19.0),
//           backgroundColor: HexColor('#D1D5DB'),
//           content: NewColumnMin(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Enter verification code',
//                 style: MasterStyle.blackWithSemiBoldStyle,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 25, right: 22, bottom: 16, top: 4),
//                 child: Text(
//                   'Enter the OTP sent to ${phoneController.text}',
//                   style: MasterStyle.blackWithSmallStyle,
//                 ),
//               ),
//               Form(
//                 key: otpFormKey,
//                 child: Container(
//                   // height: 30,
//                   margin: EdgeInsets.only(left: 16, right: 17, bottom: 4),
//                   padding: EdgeInsets.only(top: 0),
//                   child: new TextFormField(
//                     maxLength: 6,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter the otp';
//                       } else if (value.trim().length < 6) {
//                         return 'Please enter the valid otp';
//                       }
//                       return null;
//                     },
//                     controller: otpController,
//                     cursorColor: MasterStyle.appSecondaryColor,
//                     keyboardType: TextInputType.number,
//                     decoration: new InputDecoration(
//                         isDense: true,
//                         focusedErrorBorder: InputBorder.none,
//                         hoverColor: MasterStyle.whiteColor,
//                         contentPadding: EdgeInsets.only(
//                           top: 7,
//                           left: 5,
//                           bottom: 5,
//                         ),
//                         filled: true,
//                         counterText: '',
//                         fillColor: MasterStyle.whiteColor,
//                         errorBorder: const OutlineInputBorder(
//                           gapPadding: 50.0,
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 0.0),
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 0.0),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 0.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                           gapPadding: 50.0,
//                         ),
//                         hintText: 'Enter the OTP',
//                         hintStyle: GoogleFonts.sourceSerifPro(
//                             color: HexColor("#3C3C434D"), fontSize: 13)),
//                     onChanged: onchanged
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () => otpResend,
//                 child: Container(
//                   padding: EdgeInsets.only(right: 20),
//                   child: isResend
//                       ? CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                               MasterStyle.backgroundColor),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                               Text(
//                                 'Resend code',
//                                 style: MasterStyle.primaryContentStyle,
//                               )
//                             ]),
//                 ),
//               ),
//               Divider(
//                 color: Colors.grey,
//                 thickness: 1,
//               ),
//               Container(
//                 padding: EdgeInsets.only(bottom: 4),
//                 child:
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   TextButton(
//                     child: Text(
//                       'Verify',
//                       style: MasterStyle.primaryContentStyle,
//                     ),
//                     onPressed: () async {
//                       if (_otpFormKey.currentState!.validate()) {
//                         FocusScope.of(context).unfocus();
//                         var checkIfValidate = await ApiServices.verifyMobileOtp(
//                             mobile: phoneController.text.substring(1),
//                             sms: otpController.text,
//                             uuid: responseId);
//                         if (checkIfValidate['status'] != null) {
//                           if (checkIfValidate['status'] == 'pass') {
//                             snackBar('Phone number successfully verified!');
//                             verifiedConsumer.add(phoneController.text);
//                             otpController.clear();
//                             Navigator.pop(context);
//                           } else if (checkIfValidate['status'] == 'failed') {
//                             snackBar(checkIfValidate['message']['error']);
//                           }
//                         } else {
//                           snackBar(checkIfValidate['message'].toString());
//                         }

//                         setState(() {
//                           isSendCode = true;
//                         });
//                       } else {}
//                     },
//                   )
//                 ]),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

// }