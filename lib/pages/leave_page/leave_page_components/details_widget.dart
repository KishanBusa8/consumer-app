import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/styles/masterstyle.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _selectFolder() async {
    _resetState();
    try {
      String? path = await FilePicker.platform.getDirectoryPath();
      setState(() {
        _directoryPath = path;
        _userAborted = path == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFile() async {
    _resetState();
    try {
      String? fileName = await FilePicker.platform.saveFile(
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        type: _pickingType,
      );
      setState(() {
        _saveAsFileName = fileName;
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DropdownButton<FileType>(
                        hint: const Text('LOAD PATH FROM'),
                        value: _pickingType,
                        items: FileType.values
                            .map((fileType) => DropdownMenuItem<FileType>(
                                  child: Text(fileType.toString()),
                                  value: fileType,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                              _pickingType = value!;
                              if (_pickingType != FileType.custom) {
                                _controller.text = _extension = '';
                              }
                            })),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 100.0),
                    child: _pickingType == FileType.custom
                        ? TextFormField(
                            maxLength: 15,
                            autovalidateMode: AutovalidateMode.always,
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'File extension',
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                          )
                        : const SizedBox(),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 200.0),
                    child: SwitchListTile.adaptive(
                      title: Text(
                        'Pick multiple files',
                        textAlign: TextAlign.right,
                      ),
                      onChanged: (bool value) =>
                          setState(() => _multiPick = value),
                      value: _multiPick,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => _pickFiles(),
                          child: Text(_multiPick ? 'Pick files' : 'Pick file'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _selectFolder(),
                          child: const Text('Pick folder'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _saveFile(),
                          child: const Text('Save file'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _clearCachedFiles(),
                          child: const Text('Clear temporary files'),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) => _isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: const CircularProgressIndicator(),
                          )
                        : _userAborted
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: const Text(
                                  'User has aborted the dialog',
                                ),
                              )
                            : _directoryPath != null
                                ? ListTile(
                                    title: const Text('Directory path'),
                                    subtitle: Text(_directoryPath!),
                                  )
                                : _paths != null
                                    ? Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.50,
                                        child: Scrollbar(
                                            child: ListView.separated(
                                          itemCount: _paths != null &&
                                                  _paths!.isNotEmpty
                                              ? _paths!.length
                                              : 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final bool isMultiPath =
                                                _paths != null &&
                                                    _paths!.isNotEmpty;
                                            final String name =
                                                'File $index: ' +
                                                    (isMultiPath
                                                        ? _paths!
                                                            .map((e) => e.name)
                                                            .toList()[index]
                                                        : _fileName ?? '...');
                                            final path = kIsWeb
                                                ? null
                                                : _paths!
                                                    .map((e) => e.path)
                                                    .toList()[index]
                                                    .toString();

                                            return ListTile(
                                              title: Text(
                                                name,
                                              ),
                                              subtitle: Text(path ?? ''),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        )),
                                      )
                                    : _saveAsFileName != null
                                        ? ListTile(
                                            title: const Text('Save file'),
                                            subtitle: Text(_saveAsFileName!),
                                          )
                                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.title,
    required this.hinttext,
  }) : super(key: key);
  final String title;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: MasterStyle.whiteStyleWithBold,
    );
  }
}

class EmailFormField extends StatefulWidget {
  const EmailFormField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        // enabled: isEnabled,

        cursorColor: MasterStyle.appSecondaryColor,
        keyboardType: TextInputType.emailAddress,
        style: MasterStyle.whiteTextNormal,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom:8.5.h,top: 10.h),
          // hintText: "enter your email",
          hintStyle: MasterStyle.whiteHintStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
        ),
      ),
    );
  }
}

class OptionalFormField extends StatefulWidget {
  const OptionalFormField({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  _OptionalFormFieldState createState() => _OptionalFormFieldState();
}

class _OptionalFormFieldState extends State<OptionalFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        cursorColor: MasterStyle.appSecondaryColor,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        style: MasterStyle.whiteTextNormal,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom:8.5.h,top: 10.h),
          hintText: "enter your name",
          hintStyle: MasterStyle.whiteHintStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
        ),
      ),
    );
  }
}

class HowCanIHelpYou extends StatelessWidget {
  const HowCanIHelpYou({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 161.h,
      margin: EdgeInsets.only(top: 15.h, bottom: 13.h),
      child: TextFormField(
        controller: this.controller,
        // enabled: isEnabled,

        cursorColor: MasterStyle.appSecondaryColor,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.words,
        style: MasterStyle.formTextStyle,
        maxLines: 10,
        decoration: InputDecoration(
          fillColor: MasterStyle.appearenceCardColor,
          filled: true,
          contentPadding: EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: MasterStyle.formBorderColor),
          ),
        ),
      ),
    );
  }
}


/*
  Autocomplete(
                // optionsViewBuilder: (context, onSelected, options) {
                //   return Align(
                //     alignment: Alignment.topLeft,
                //     child: Container(
                //       height: 200,
                //       child: Material(
                //         elevation: 4,
                //         child: ListView.separated(
                //           padding: EdgeInsets.zero,
                //           itemBuilder: (context, index) {
                //             final option = options.elementAt(index);

                //             return ListTile(
                //               // title: Text(option.toString()),
                //               title: Text(option.toString(),
                //                   // term:  this.widget.postcodeController.text,
                //                   style: MasterStyle.commonTextStyle),

                //             );
                //           },
                //           separatorBuilder: (context, index) => Divider(),
                //           itemCount: options.length,
                //         ),
                //       ),
                //     ),
                //   );
                // },

                fieldViewBuilder:
                    (context, controller, focusNode, onEditingComplete) {
                  return TextFormField(
                    //  onFieldSubmitted: (value) {},
                    controller: this.widget.buildYearController,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (int.parse(value) > currentYear) {
                        setState(() {
                          this.widget.buildYearController.text =
                              currentYear.toString();
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintText: 'E.g 2000 or Richmond',
                      hintStyle: MasterStyle.whiteHintStyle,
                      enabledBorder: SimplifiedWidgets.outlineInputBorder,
                      border: SimplifiedWidgets.outlineInputBorder,
                      focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    ),
                  );
                },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return buildYear;
                  }
                  return buildYear.where((String option) {
                    return option
                        .toString()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  // var suggestions = Future.value(
                  //     {
                  //       buildYear.map((e) => e.toString()).toList()
                  //     // getSuggestions()
                  //       }
                  //     );

                  // return suggestions;
                },
              ),
              Container(
                height: 35.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MasterStyle.whiteColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: AwesomeDropDown(
                  numOfListItemToShow: 5,
                  elevation: 0,
                  padding: 0.4,
                  dropDownBGColor: Colors.transparent,
                  dropDownTopBorderRadius: 0,
                  dropDownBottomBorderRadius: 0,
                  dropDownBorderRadius: 0,
                  isPanDown: false,
                  dropDownList: buildYear as List<String>,
                  dropDownIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                    size: 23,
                  ),
                  selectedItem: "_selectedItem",
                  onDropDownItemClick: (selectedItem) {
                    // _selectedItem = selectedItem;
                  },
                  dropStateChanged: (isOpened) {
                    //  _isDropDownOpened = isOpened;

                    if (!isOpened) {
                      //   _isBackPressedOrTouchedOutSide = false;

                    }
                  },
                ),
              ),
            */