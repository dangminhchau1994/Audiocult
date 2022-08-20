import 'dart:io';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/image/image_utils.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../w_components/list_photos/common_list_photos.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';

class PreViewImage extends StatefulWidget {
  const PreViewImage({
    Key? key,
    this.request,
    this.ratio,
  }) : super(key: key);

  final CreateEventRequest? request;
  final double? ratio;
  @override
  State<PreViewImage> createState() => _PreViewImageState();
}

class _PreViewImageState extends State<PreViewImage> {
  File? file;
  String errorTitle = '';
  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;
  int _page = 0;
  bool _isLoading = false;
  int _sizePerPage = 50;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _requestAssets,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        color: AppColors.borderOutline,
        dashPattern: const [20, 6],
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: AppColors.inputFillColor.withOpacity(0.2),
          child: file != null ? _buildImagePicked() : _buildChooseImage(),
        ),
      ),
    );
  }

  Future<void> _requestAssets() async {
    // Request permissions.
    final _ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }

    // Further requests can be only procceed with authorized or limited.
    if (_ps != PermissionState.authorized && _ps != PermissionState.limited) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(context.localize.t_camera_permission),
          content: Text(context.localize.t_need_photos),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(context.localize.t_cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text(context.localize.t_settings),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return;
    }

    // Obtain assets using the path entity.
    final paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
    );
    if (!mounted) {
      return;
    }

    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('No paths found.');
      return;
    }
    setState(() {
      _path = paths.first;
    });
    _totalEntitiesCount = _path!.assetCount;
    final entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });

    if (_ps == PermissionState.limited || _ps == PermissionState.authorized) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonListPhotos(
            entities: _entities,
            path: _path,
            isLoadingMore: _isLoadingMore,
            hasMoreToLoad: _hasMoreToLoad,
            loadMoreAsset: _loadMoreAsset,
            permissionState: _ps,
          ),
        ),
      );
      if (result != null) {
        result.file.then((value) async {
          file = value as File;
          final cropFile = await ImageUtils.cropImage(file?.path ?? '');
          file = File(cropFile!.path);
          setState(() {});
        });
      }
    }
  }

  Future<void> _loadMoreAsset() async {
    final entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  Widget _buildChooseImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.icUploadFrame,
          width: 48,
        ),
        Text(
          context.localize.t_upload_banner,
          style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlue, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          context.localize.t_limit_upload_event,
          style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildImagePicked() {
    widget.request?.image = file;
    return AspectRatio(
      aspectRatio: widget.ratio ?? 0,
      child: Center(
        child: Stack(
          children: [
            Image.file(
              File(file?.path ?? ''),
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    file = null;
                    widget.request?.image = file;
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
