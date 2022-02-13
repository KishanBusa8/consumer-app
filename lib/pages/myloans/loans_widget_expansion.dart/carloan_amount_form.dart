// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/property_suggestions_model.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

class CarLoanAmountForm extends StatefulWidget {
  CarLoanAmountForm(
      {Key? key,
      required this.carPriceController,
      required this.amountController,
      required this.postcodeController})
      : super(key: key);

  TextEditingController amountController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();

  @override
  State<CarLoanAmountForm> createState() => _CarLoanAmountFormState();
}

class _CarLoanAmountFormState extends State<CarLoanAmountForm> {
  var postcodeSuggesstionList = [];

  @override
  Widget build(BuildContext context) {
    const _locale = 'en';
    String _formatNumber(String s) =>
        NumberFormat.decimalPattern(_locale).format(int.parse(s));
    return ListView(
      shrinkWrap: true,
      children: [
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWithStyle("Your loan amount :"),

              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  maxLength: 15,
                  onChanged: (string) {
                    if (string.trim().isNotEmpty) {
                      string = '${_formatNumber(string.replaceAll(',', ''))}';
                      this.widget.amountController.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.trim().isNotEmpty) {
                      var carPriceWithoutComma = this
                          .widget
                          .carPriceController
                          .text
                          .replaceAll(",", '');

                      var carPrice = int.parse(carPriceWithoutComma);
                      var valueOfAmount = int.parse(value.replaceAll(',', ''));
                      if (value.trim().isEmpty) {
                        return 'Please enter valid amount';
                      } else if (valueOfAmount > carPrice -1) {
                        return 'Maximum loan amount allowed is \$${carPrice - 1}';
                      }
                      return null;
                    }
                    return null;
                  },
                  controller: this.widget.amountController,
                  keyboardType: TextInputType.number,
                  style: MasterStyle.whiteTextInputStyle,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: '\$50,000',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Your suburb/postcode :'),

              TypeAheadFormField(
                validator: (value) {
                  if (value.toString().trim().length < 3) {
                    return "Enter valid Australian post code";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                minCharsForSuggestions: 3,
                loadingBuilder: (context) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                    ),
                  );
                },
                // keepSuggestionsOnLoading: true,
                hideOnEmpty: true,
                hideOnLoading: false,
                textFieldConfiguration: TextFieldConfiguration(
                    onSubmitted: (value) {
                      setState(() {
                        widget.postcodeController.text = '';
                      });
                    },
                    controller: widget.postcodeController,
                    style: MasterStyle.whiteTextInputStyle,
                    cursorColor: MasterStyle.customGreyColor,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintText: 'E.g 2000 or Richmond',
                      hintStyle: MasterStyle.whiteHintStyle,
                      enabledBorder: SimplifiedWidgets.outlineInputBorder,
                      border: SimplifiedWidgets.outlineInputBorder,
                      focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    )),
                suggestionsCallback: (pattern) async {
                  var data = ApiServices.getPostCodeSuggestions(pattern);
                  data.then((value) {
                    postcodeSuggesstionList = value;
                    print(postcodeSuggesstionList);
                  });
                  return await ApiServices.getPostCodeSuggestions(pattern);
                },
                itemBuilder: (context, Map<String, String> suggestion) {
                  return Column(
                    children: [
                      ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          title: suggestion['status'] == "true"
                              ? Text(
                                  suggestion['suggestions']!,
                                  style: MasterStyle.greyNormalStyle,
                                )
                              : Text(
                                  suggestion['suggestions']!,
                                  style: MasterStyle.negativeStatusStyle,
                                )),
                      suggestion['status'] == "true" ? Divider() : SizedBox()
                    ],
                  );
                },
                onSuggestionSelected: (Map<String, String> suggestion) {
                  if (suggestion['status'] == "true") {
                    setState(() {
                      var postCodeSuggestion = suggestion['suggestions']!;
                      widget.postcodeController.text = postCodeSuggestion;
                    });
                  } else {}
                },
              ),

              //  Autocomplete<Suggestions>(
              //   displayStringForOption: (Suggestions option) {
              //     return option.suggestion;
              //   },
              //   optionsBuilder: (TextEditingValue textEditingValue) {
              //     var suggestions = ApiServices.fetchPostCodeSuggestions(
              //         textEditingValue.text);

              //     return suggestions;
              //   },
              //   // optionsViewBuilder: (context, onSelected, options) {
              //   //   return Material(
              //   //     elevation: 4,
              //   //     child: ListView.separated(
              //   //       padding: EdgeInsets.zero,
              //   //       itemBuilder: (context, index) {
              //   //         final option = options.elementAt(index);

              //   //         return ListTile(
              //   //           // title: Text(option.toString()),
              //   //           title: Text(option.suggestion,
              //   //               // term:  this.widget.postcodeController.text,
              //   //               style: MasterStyle.commonTextStyle),
              //   //           // onTap: () {
              //   //           //   onSelected(option);
              //   //           // },
              //   //         );
              //   //       },
              //   //       separatorBuilder: (context, index) => Divider(),
              //   //       itemCount: options.length,
              //   //     ),
              //   //   );
              //   // },
              //   // onSelected: (selectedString) {
              //   //   print(selectedString.suggestion);
              //   // },

              //   fieldViewBuilder:
              //       (context, controller, focusNode, onEditingComplete) {
              //     this.widget.postcodeController = controller;

              //     return TextFormField(
              //       onFieldSubmitted: (value) {},
              //       controller: controller,
              //       focusNode: focusNode,
              //       onEditingComplete: onEditingComplete,
              //       decoration: InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //         hintText: 'E.g 2000 or Richmond',
              //         hintStyle: MasterStyle.whiteHintStyle,
              //         enabledBorder: SimplifiedWidgets.outlineInputBorder,
              //         border: SimplifiedWidgets.outlineInputBorder,
              //         focusedBorder: SimplifiedWidgets.outlineInputBorder,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }

  labelWithStyle(label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: MasterStyle.secondarySemiBoldTextStyle,
      ),
    );
  }
}
