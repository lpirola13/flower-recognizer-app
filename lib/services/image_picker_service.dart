import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ImageService {

  Future<File> getImage(bool isCamera);

  void deleteImage(File image);

}

class ImagePickerService implements ImageService {

  final _imagePicker = ImagePicker();
  final _log = Logger('ImagePickerService');

  @override
  Future<File> getImage(bool isCamera) async {
    var status = isCamera? await Permission.camera.request() : await Permission.photos.request();
    isCamera? _log.info('getImage - Camera permission is $status') : _log.info('getImage - Gallery permission is $status');
    if (status.isPermanentlyDenied){
      _log.info('getImage - asking to edit settings');
      if (isCamera) {
        throw('error-camera');
      } else {
        throw('error-gallery');
      }
    } else if (status.isDenied){
      isCamera? _log.info('getImage - Camera request permission') : _log.info('getImage - Gallery request permission');
      status = await Permission.camera.request();
      return null;
    } else {
      _log.info('getImage - took image');
      var pickedFile;
      if(status.isGranted){
        pickedFile = await _imagePicker.getImage(source: isCamera? ImageSource.camera : ImageSource.gallery );
      } else {
        pickedFile = null;
      }

      if (pickedFile == null) {
        _log.severe('getImage - no image');
        return null;
      }
      _log.info('getImage - picked file path ${pickedFile.path}');
      return File(pickedFile.path);
    }
  }



  @override
  void deleteImage(File image) async {
    bool imageExists = await image.exists();
    _log.info('deleteImage - delete image ${image.path}');
    if (imageExists) {
      image.delete();
    }
  }
}


