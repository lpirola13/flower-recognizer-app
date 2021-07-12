import 'dart:io';
import 'package:flower_recognizer/commond_widgets/custom_button.dart';
import 'package:flower_recognizer/models/prediction.dart';
import 'package:flower_recognizer/services/image_picker_service.dart';
import 'package:flower_recognizer/services/tflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flower_recognizer/app/pages/settings/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingImagePage extends StatefulWidget {
  @override
  _LoadingImagePageState createState() => _LoadingImagePageState();
}

class _LoadingImagePageState extends State<LoadingImagePage> {
  File _image;
  final _tfliteService = TfliteService();
  final _imagePickerService = ImagePickerService();
  bool _isImageLoad = false;
  List<Prediction> _predictions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isImageLoad
            ? Text('loading_page_title_loaded').tr()
            : Text('loading_page_title_not_loaded').tr(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _openSettings(context))
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: Colors.green[50],
        ),
        child: _isImageLoad
            ? _buildPageImageLoaded(context)
            : _buildPageImageNotLoaded(),
      ),
    );
  }

  Center _buildPageImageNotLoaded() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 50, 8, 20),
              child: Image(
                key: Key('init_image_loading_image_page'),
                image: AssetImage('assets/graphics/welcome.png'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.green[100],
                  ),
                  padding: EdgeInsets.all(30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: 'loading_image_page_init1'.tr() + '\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.1)),
                        TextSpan(text: '\n' + 'loading_image_page_init2'.tr()),
                      ],
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: _buildLoadingButton('gallery_button'.tr(),
                    Icons.photo_library, 'init_button_loading_image_page', false)),
            Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                child: _buildLoadingButton('camera_button'.tr(),
                    Icons.camera, 'init_button_camera_loading_image_page', true)) 
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildPageImageLoaded(context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.green[100],
                    ),
                    padding: EdgeInsets.all(30),
                    child: Column(children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'your_image'.tr() + '\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.1)),
                      ),
                      Center(
                        child: Image.file(
                          _image,
                          key: Key('image_loaded'),
                        ),
                      )
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.green[100],
                    ),
                    padding: EdgeInsets.all(30),
                    child: Column(children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'results'.tr() + '\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.1)),
                      ),
                      FutureBuilder(
                          future: _tfliteService.runModelOnImage(_image),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              _predictions = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _predictions.length,
                                itemBuilder: (context, index) {
                                  return _buildResultCard(_predictions[index]);
                                },
                              );
                            }
                          })
                    ])),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                  child: _buildGoBackButton('go_back'.tr(), 'go_back_button'))
            ],
          ),
        ],
      ),
    );
  }

  CustomButton _buildGoBackButton(String title, String key) {
    return CustomButton(
        key: Key(key),
        elevation: 10,
        backgroundcolor: Colors.green[100],
        borderRadius: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        onPressed: () async {
          _imagePickerService.deleteImage(_image);
          setState(() {
            _isImageLoad = false;
            _image = null;
          });
        });
  }

  CustomButton _buildLoadingButton(String title, IconData icon, String key, bool isCamera) {
    return CustomButton(
        key: Key(key),
        elevation: 10,
        backgroundcolor: Colors.green[100],
        borderRadius: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 1.1
                ),
            ),
            Opacity(child: Icon(icon), opacity: 0,),
          ],
        ),
        onPressed: () async {
          var image = await _imagePickerService
              .getImage(isCamera)
              .onError((error, stackTrace) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildPermissionDialog(error);
                  },
                );
                return null;
              });

          // chiamare il service crop e ridimensionare l'immagine

          setState(() {
            if (image != null) {
              _image = image;
              _isImageLoad = true;
            }
          });
        });
  }

  Card _buildResultCard(Prediction prediction) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          child: ListTile(
        title: Text(
          prediction.label.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text((prediction.confidence * 100).toStringAsFixed(2) + '%'),
      )),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  AlertDialog _buildPermissionDialog(error) {
    return AlertDialog(
      title: error=="error-camera" ? Text("camera_permission".tr()) : Text("photos_permission".tr()),
      content: error=="error-camera" ? Text("camera_permission_description".tr()) : Text("photos_permission_description".tr()),
      actions: [
        TextButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: Text("open_settings".tr())),
      ],
    );
  }
}
