// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/pages/myaccount/mydocumentvault/visibilitysettings.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DocumentVault extends StatefulWidget {
  DocumentVault(
      {Key? key,
      required this.consumerDocumentListModel,
      required this.consumerDashboardModel})
      : super(key: key);
  ConsumerDocumentListModel? consumerDocumentListModel;
  ConsumerDashboardModel? consumerDashboardModel;

  @override
  _DocumentVaultState createState() => _DocumentVaultState();
}

class _DocumentVaultState extends State<DocumentVault> {
  String? _fileName;
  List<PlatformFile>? _paths;
  bool isSelected = false;
  late List<bool> isCheckBoxList = [];
  late List documents = [];
  late List<String> selctedFileId = [];
  bool _isFileUploading = false;
  bool _isDeleting = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  late File file;
  int id = 99999;
  int i = 0;
  @override
  void initState() {
    super.initState();
    if (InitialData.uploaded_files.length == 0) {
      for (i; i < widget.consumerDocumentListModel!.documents.length; i++) {
        InitialData.uploaded_files.add({
          "isCheck": false,
          "id": i.toString(),
          "filename": widget.consumerDocumentListModel!.documents[i].metaName
              .toString(),
          "updatedAt": widget.consumerDocumentListModel!.documents[i].updatedAt
              .toString(),
          "database_id":
              widget.consumerDocumentListModel!.documents[i].id.toString()
        });
      }
    }
    for (i = 0; i < InitialData.uploaded_files.length; i++)
      isCheckBoxList.add(false);
  }

 showDeleteAlertBox(context)  {
     return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: spinkit(),

          );
        });

        }

  deleteConsumerDocuments(context) async {
// await showDeleteAlertBox(context);
    setState(() {
      _isDeleting = true;
    });
    var deleteConsumerDocumentServices =
        await ApiServices.deleteConsumerDocuments(documentIds: selctedFileId);

    setState(() {
      for (i = 0; i < isCheckBoxList.length; i++)
        if (isCheckBoxList[i]) {
          InitialData.uploaded_files.removeAt(i);
          isCheckBoxList.removeAt(i);
          i--;
        }
      isSelected = false;
      selctedFileId.clear();
    });
    return deleteConsumerDocumentServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: MasterStyle.backgroundColor,
          title: Text(
            "Document Vault",
            style: MasterStyle.appBarTitleStyle,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: MasterStyle.appBarIconColor)),
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(Icons.search, color: MasterStyle.appBarIconColor)),
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: ListView(
              children: [
                RichText(
                  text: TextSpan(
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                    children: [
                      TextSpan(
                          text:
                              'Use your documents to securely store and share your important documents. The document vault is protected by AES-256 encryption, meaning your files will never be accessed by anyone other than you and your broker (if you choose to share with them). \n\nTo share an uploaded document tick the checkbox beside the document or documents, then select the  '),
                      WidgetSpan(
                        child: SvgPicture.asset(
                          'assets/icons/eye_icon.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                      TextSpan(
                          text:
                              ' button. You can choose to add or remove your brokers’ access for any files in your document vault, at any time.'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                  child: Text(
                    'Upload New Document',
                    style: MasterStyle.whiteTextStyleNormal,
                  ),
                ),
                InkWell(
                  onTap: _isFileUploading
                      ? null
                      : () {
                          _pickFiles();
                        },
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: DottedBorder(
                          radius: Radius.circular(5),
                          color: MasterStyle.dottedBorder,
                          child: Center(
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 33.h),
                                  child: _isFileUploading
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: spinkit())
                                      : SvgPicture.asset(
                                          'assets/icons/file_upload.svg'))))),
                ),
                InitialData.uploaded_files.length != 0
                    ? ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                            InitialData.uploaded_files.length > 1
                                ? 'Your Files'
                                : 'Your File',
                            style: MasterStyle.whiteTextStyleNormal),
                        trailing: !isSelected
                            ? SizedBox()
                            : SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: _isFileUploading
                                            ? null
                                            : () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VisibilitySettings(
                                                              consumerDashboardModel:
                                                                  widget
                                                                      .consumerDashboardModel,
                                                              selctedFileId:
                                                                  selctedFileId,
                                                            )));
                                              },
                                        child: SvgPicture.asset(
                                            'assets/icons/eye_icon.svg')),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    // Container(
                                    //   child: SvgPicture.asset(
                                    //       'assets/icons/save_icon.svg'),
                                    //   padding:
                                    //       EdgeInsets.symmetric(horizontal: 20),
                                    // ),
                                    InkWell(
                                      onTap: _isFileUploading
                                          ? null
                                          : () {
                                              deleteConsumerDocuments(context);
                                            },
                                      child: SvgPicture.asset(
                                          'assets/icons/delete_icon.svg'),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    : SizedBox(),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: InitialData.uploaded_files.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: GestureDetector(
                      onTap: _isFileUploading
                          ? null
                          : () {
                              setState(() {
                                isCheckBoxList[index] = !isCheckBoxList[index];
                                if (isCheckBoxList[index])
                                  selctedFileId.add(InitialData
                                      .uploaded_files[index]["database_id"]);
                                else if (selctedFileId.contains(InitialData
                                    .uploaded_files[index]["database_id"]))
                                  selctedFileId.remove(InitialData
                                      .uploaded_files[index]["database_id"]);
                                if (selctedFileId.isEmpty)
                                  isSelected = false;
                                else
                                  isSelected = true;
                              });
                            },
                      child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          leading: Container(
                            color: isCheckBoxList[index]
                                ? MasterStyle.appSecondaryColor
                                : Colors.white,
                            height: 17,
                            width: 17,
                            child: Checkbox(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => isCheckBoxList[index]
                                        ? MasterStyle.appSecondaryColor
                                        : Colors.white),
                                checkColor: MasterStyle
                                    .appSecondaryColor, // color of tick Mark
                                activeColor: MasterStyle.appSecondaryColor,
                                value: isCheckBoxList[index],
                                onChanged: _isFileUploading
                                    ? null
                                    : (value) {
                                        setState(() {
                                          isCheckBoxList[index] =
                                              !isCheckBoxList[index];
                                          if (isCheckBoxList[index])
                                            selctedFileId.add(InitialData
                                                    .uploaded_files[index]
                                                ["database_id"]);
                                          else if (selctedFileId.contains(
                                              InitialData.uploaded_files[index]
                                                  ["database_id"]))
                                            selctedFileId.remove(InitialData
                                                    .uploaded_files[index]
                                                ["database_id"]);
                                          if (selctedFileId.isEmpty)
                                            isSelected = false;
                                          else
                                            isSelected = true;
                                        });
                                      }),
                          ),
                          title: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                InitialData.uploaded_files[index]["filename"],
                                style: MasterStyle.whiteStyleWithRegular,
                              )),
                          trailing: Text(
                            InitialData.uploaded_files[index]["updatedAt"],
                            style:
                                MasterStyle.whiteStyleOpacityWithLigthRegular,
                          )),
                    ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: HexColor('#C2C2C2'),
                      thickness: 1,
                    );
                  },
                )
              ],
            )));
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: _multiPick,
      onFileLoading: (FilePickerStatus status) => print(status),
      allowedExtensions: [
        'jpg',
        'pdf',
        'doc',
        'jpeg',
        'png',
        'gif',
        'csv',
        'docx',
        'xls'
      ],
    );
    var file;
    var fileName;
    if (result != null) {
      setState(() {
        _isFileUploading = true;
      });
      file = File(result.files.single.path!);
      fileName = File(result.files.single.name);
      print("fileName   *********$fileName");
      print("file_path   *********${result.files.single.path}");
    } else {
      setState(() {
        _isFileUploading = false;
      });
      // User canceled the picker
    }
    String name = basename(fileName.path);
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);
    await ApiServices.addConsumerDocumentFile(result!.files.single.path);
    setState(() {
      print('object  ${_fileName}');
      InitialData.uploaded_files.add({
        "isCheck": false,
        "id": InitialData.uploaded_files.length,
        "filename": name,
        "updatedAt": formattedDate,
        "database_id": (id++).toString()
      });
      isCheckBoxList.add(false);
      _isFileUploading = false;
    });
  }

  spinkit() {
    return SpinKitThreeBounce(color: MasterStyle.appSecondaryColor, size: 30);
  }
}
