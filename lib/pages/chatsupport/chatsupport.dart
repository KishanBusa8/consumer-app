import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/pages/leave_page/leave_page_components/leave_page_components.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ChatWithSupport extends StatefulWidget {
  ChatWithSupport({Key? key}) : super(key: key);

  @override
  State<ChatWithSupport> createState() => _ChatWithSupportState();
}

class _ChatWithSupportState extends State<ChatWithSupport> {
  final _formKey = GlobalKey<FormState>();
  late List fileNames = [];
  late TextEditingController emailController = TextEditingController(text: '');
  late TextEditingController optionalController =
      TextEditingController(text: '');
  late TextEditingController howICanController =
      TextEditingController(text: '');
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MasterStyle.backgroundColor,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 36,
              color: MasterStyle.appIconColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Leave us a message',
                style: MasterStyle.primaryContentWithBold,
              ),
              SizedBox(
                height: 16.h,
              ),
              DetailsWidget(
                title: 'Your name(optional)',
                hinttext: "example@email.com",
              ),
              OptionalFormField(controller: optionalController),
              SizedBox(
                height: 13.5.h,
              ),

              DetailsWidget(
                title: 'E-mail address',
                hinttext: "",
              ),
              // SizedBox(height: 15.h,),
              EmailFormField(controller: emailController),
              SizedBox(
                height: 13.h,
              ),
              DetailsWidget(
                title: "How can we help you?",
                hinttext: "",
              ),
            
              HowCanIHelpYou(controller: howICanController),
             
              DetailsWidget(
                title: "How can we help you?",
                hinttext: "",
              ),
             
            
              // DetailsWidget(title:'E-mail address',hinttext: '',),
              // MessageWidget(),
                  // Builder(
                  //   builder: (BuildContext context) => _isLoading
                  //       ? Padding(
                  //           padding: const EdgeInsets.only(bottom: 10.0),
                  //           child: const CircularProgressIndicator(),
                  //         )
                  //       : _userAborted
                  //           ? Padding(
                  //               padding: const EdgeInsets.only(bottom: 10.0),
                  //               child: const Text(
                  //                 'User has aborted the dialog',
                  //               ),
                  //             )
                  //           : _directoryPath != null
                  //               ? ListTile(
                  //                   title: const Text('Directory path'),
                  //                   subtitle: Text(_directoryPath!),
                  //                 )
                  //               : _paths != null
                  //                   ? Container(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 30.0),
                  //                       height:
                  //                           MediaQuery.of(context).size.height *
                  //                               0.50,
                  //                       child: Scrollbar(
                  //                           child: ListView.separated(
                  //                         itemCount: _paths != null &&
                  //                                 _paths!.isNotEmpty
                  //                             ? _paths!.length
                  //                             : 1,
                  //                         itemBuilder: (BuildContext context,
                  //                             int index) {
                         
                  //                           final bool isMultiPath =
                  //                               _paths != null &&
                  //                                   _paths!.isNotEmpty;
                  //                           final String name =
                  //                               'File $index: ' +
                  //                                   (isMultiPath
                  //                                       ? _paths!
                  //                                           .map((e) => e.name.toString())
                  //                                           .toList()[index]
                  //                                       : _fileName ?? '...');
                  //                           final path = kIsWeb
                  //                               ? null
                  //                               : _paths!
                  //                                   .map((e) => e.size)
                  //                                   .toList()[index]
                  //                                   .toString();
                                                 
          

                  //                           return ListTile(
                  //                             title: Text(
                  //                               name,
                  //                             ),
                  //                             subtitle: Text(path ?? ''),
                  //                           );
                  //                         },
                  //                         separatorBuilder:
                  //                             (BuildContext context,
                  //                                     int index) =>
                  //                                 const Divider(),
                  //                       )),
                  //                     )
                  //                   : _saveAsFileName != null
                  //                       ? ListTile(
                  //                           title: const Text('Save file'),
                  //                           subtitle: Text(_saveAsFileName!),
                  //                         )
                  //                       : const SizedBox(),
                  // ),
              // ListView.separated(
              //                             itemCount: _paths != null &&
              //                                     _paths!.isNotEmpty
              //                                 ? _paths!.length
              //                                 : 1,
              //                             itemBuilder: (BuildContext context,
              //                                 int index) {
                         
              //                               final bool isMultiPath =
              //                                   _paths != null &&
              //                                       _paths!.isNotEmpty;
              //                               final String name =
              //                                   'File $index: ' +
              //                                       (isMultiPath
              //                                           ? _paths!
              //                                               .map((e) => e.name.toString())
              //                                               .toList()[index]
              //                                           : _fileName ?? '...');
              //                               final path = kIsWeb
              //                                   ? null
              //                                   : _paths!
              //                                       .map((e) => e.size)
              //                                       .toList()[index]
              //                                       .toString();
                                                 
          

              //                               return ListTile(
              //                                 title: Text(
              //                                   name,style: MasterStyle.whiteTextNormal,
              //                                 ),
              //                                 // subtitle: Text(path ?? ''),
              //                               );
              //                             },
              //                             separatorBuilder:
              //                                 (BuildContext context,
              //                                         int index) =>
              //                                     const Divider(),
              // ),
              SizedBox(height: 10,),
                         ListView.builder(
                           shrinkWrap: true,
                           itemCount: fileNames.length,
                           itemBuilder: (context ,index){
                           return Container(
                             padding: EdgeInsets.all(6),
                             margin: EdgeInsets.only(bottom: 10),
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.all(Radius.circular(10))
                             ),
                             child: ListTile(title: Text(fileNames[index],style: MasterStyle.commonTextStyle,),
                             trailing: IconButton(onPressed: (){
                              setState(() {
                                 fileNames.removeAt(index);
                              });

                             }, icon: Icon(Icons.close)),
                             ));
                         })       ,    
              InkWell(
                onTap:(){
                    _pickFiles();
// Navigator.push(context, MaterialPageRoute(builder: (context)=> FilePickerDemo()));
                },
                child: DottedWidget()),
              ButtonWidget(formKey: _formKey)

            ],
          ),
        ),
      ),
    );
  }
   void _pickFiles() async {
    // _resetState();

    if(fileNames.length != 5){
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
         var replace= _fileName!.replaceAll('(', '');
         var filename= replace.replaceAll(')', '');
          fileNames.add(filename);
print('object  ${_fileName}');
          _logException(_fileName.toString());
      _userAborted = _paths == null;
    });
    }else{
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: MasterStyle.appSecondaryColor,
                content: Text(
                  'Attachment limit reached You can upload a maximum of 5 attachments.',
                  style: MasterStyle.whiteStyleRegularSmall,
                )),
          );
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

}
