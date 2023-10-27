import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(const AlbumState()) {
    on<InitialEvent>((event, emit) {
      _initialEvent(event, emit);
    });
    on<SaveAlbum>(
      (event, emit) {
        _saveAlbum(event, emit);
      },
    );
    on<ShareAlbum>(
      (event, emit) {
        _shareAlbum(event, emit);
      },
    );
    on<ChangeAlbumTitle>((event, emit) {
      _changeAlbumTitle(event, emit);
    });
    on<ChangeAlbumDescription>((event, emit) {
      _changeAlbumDescription(event, emit);
    });
    on<AddPhoto>((event, emit) async {
      final img = await _addPhoto(event, emit);
      List<Image?>? newImages = state.images?.toList();

      newImages?[event.id] = img;

      emit(state.copyWith(images: newImages));
    });
  }

  void _initialEvent(event, emit) async {
    WidgetsToImageController controller = WidgetsToImageController();
    List<Image?>? images = List.generate(8, (index) => null);
    emit(state.copyWith(
      controller: controller,
      images: images,
    ));
  }

  void _saveAlbum(event, emit) async {
    try {
      final bytes = await state.controller!.capture();

      await ImageGallerySaver.saveImage(
        bytes!,
        quality: 100,
        name: "singleStoryApp",
      );

      Fluttertoast.showToast(
        msg: "Image saved to gallery",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } catch (e) {
      rethrow;
    }
  }

  void _shareAlbum(event, emit) async {

    // TODO: add the ability to send a file directly to telegram!
    // final bytes = await state.controller!.capture();
    //
    // if (bytes != null) {
    //   await Share.shareXFiles(
    //     [XFile.fromData(bytes)],
    //     text: "Single story album app",
    //   );
    // } else {
    //   throw Error();
    // }
    
    await Share.share('This functionality has not yet been implemented');
  }

  void _changeAlbumTitle(ChangeAlbumTitle event, emit) {
    emit(state.copyWith(albumTitle: event.title));
  }

  void _changeAlbumDescription(ChangeAlbumDescription event, emit) {
    emit(state.copyWith(albumDescription: event.description));
  }

  Future<Image?> _addPhoto(AddPhoto event, emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageXFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    return await _convertXFileToImage(imageXFile);
  }

  Future<Image?> _convertXFileToImage(XFile? xFile) async {
    if (xFile == null) {
      return null;
    }

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: xFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 100,
    );

    if (croppedFile != null) {
      final List<int> bytes = await croppedFile.readAsBytes();
      final Image image = Image.memory(
        Uint8List.fromList(bytes),
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      );

      return image;
    }

    return null;
  }
}
