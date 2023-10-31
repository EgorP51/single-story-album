import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(const AlbumState()) {
    // Event handlers
    on<InitialEvent>(_handleInitialEvent);
    on<SaveAlbum>(_handleSaveAlbum);
    on<ShareAlbum>(_handleShareAlbum);
    on<ChangeAlbumTitle>(_handleChangeAlbumTitle);
    on<ChangeAlbumDescription>(_handleChangeAlbumDescription);
    on<AddPhotoSeparately>(_handleAddPhotoSeparately);
    on<AddPhotosTogether>(_handleAddPhotosTogether);
  }

  // Event handlers
  void _handleInitialEvent(InitialEvent event, Emitter<AlbumState> emit) async {
    WidgetsToImageController controller = WidgetsToImageController();
    List<Image?>? images = List.generate(8, (index) => null);
    emit(state.copyWith(controller: controller, images: images));
  }

  void _handleSaveAlbum(SaveAlbum event, Emitter<AlbumState> emit) async {
    try {
      final bytes = await state.controller!.capture();
      await ImageGallerySaver.saveImage(
        bytes!,
        quality: 100,
        name: "singleStoryApp",
      );

      _showToast("Image saved to gallery");
    } catch (e) {
      rethrow;
    }
  }

  void _handleShareAlbum(ShareAlbum event, Emitter<AlbumState> emit) async {
    final bytes = await state.controller!.capture();

    if (bytes != null) {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/single_story_album.png';
      File tempFile = File(tempPath);
      await tempFile.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(tempPath)],
        text: "Single story album app",
      );

      await tempFile.delete();
    } else {
      throw Error();
    }
  }

  void _handleChangeAlbumTitle(
      ChangeAlbumTitle event, Emitter<AlbumState> emit) {
    emit(state.copyWith(albumTitle: event.title));
  }

  void _handleChangeAlbumDescription(
      ChangeAlbumDescription event, Emitter<AlbumState> emit) {
    emit(state.copyWith(albumDescription: event.description));
  }

  void _handleAddPhotoSeparately(
      AddPhotoSeparately event, Emitter<AlbumState> emit) async {
    final Image? img = await _addPhotosSeparately(event, emit);
    List<Image?>? newImages = state.images?.toList();

    newImages?[event.id] = img;

    emit(state.copyWith(images: newImages));
  }

  void _handleAddPhotosTogether(
      AddPhotosTogether event, Emitter<AlbumState> emit) async {
    final List<Image?> images = await _addPhotoTogether(event, emit);

    emit(state.copyWith(images: images));
  }

  // Helper methods
  Future<Image?> _addPhotosSeparately(
      AddPhotoSeparately event, Emitter<AlbumState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageXFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    return await _convertXFileToImage(imageXFile);
  }

  Future<List<Image?>> _addPhotoTogether(
    AddPhotosTogether event,
    Emitter<AlbumState> emit,
  ) async {
    List<Image?> images = List.generate(8, (index) => null);
    final ImagePicker picker = ImagePicker();

    final List<XFile?> imagesXFile = await picker.pickMultiImage(
      imageQuality: 100,
      requestFullMetadata: true,
    );

    for (int i = 0; i < imagesXFile.length; i++) {
      images[i] = await _convertXFileToImage(imagesXFile[i]);
    }

    return images;
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

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  // Dialogs
  void changeDescriptionDialog(BuildContext context, AlbumState state) {
    showDialog(
      context: context,
      builder: (context) {
        String tempAlbumDescription = state.albumDescription ?? '';
        return AlertDialog(
          title: const Text('Enter album description'),
          content: TextField(
            controller: TextEditingController(text: state.albumDescription),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (text) {
              tempAlbumDescription = text;
            },
          ),
          actions: [
            FloatingActionButton(
              onPressed: () {
                add(
                  ChangeAlbumDescription(
                    tempAlbumDescription,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Icon(CupertinoIcons.pen),
            ),
          ],
        );
      },
    );
  }

  void changeTitleDialog(BuildContext context, AlbumState state) {
    showDialog(
      context: context,
      builder: (context) {
        String tempAlbumTitle = state.albumTitle ?? '';
        return AlertDialog(
          title: const Text('Enter album name'),
          content: TextField(
            controller: TextEditingController(text: state.albumTitle),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (text) {
              tempAlbumTitle = text;
            },
          ),
          actions: [
            FloatingActionButton(
              onPressed: () {
                add(
                  ChangeAlbumTitle(tempAlbumTitle),
                );
                Navigator.of(context).pop();
              },
              child: const Icon(CupertinoIcons.pen),
            ),
          ],
        );
      },
    );
  }
}
