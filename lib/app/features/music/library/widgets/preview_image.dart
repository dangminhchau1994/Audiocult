import 'dart:io';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../w_components/list_photos/common_list_photos.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/image/image_utils.dart';

class PreViewImage extends StatefulWidget {
  const PreViewImage({
    Key? key,
    this.request,
  }) : super(key: key);

  final CreatePlayListRequest? request;

  @override
  State<PreViewImage> createState() => _PreViewImageState();
}

class _PreViewImageState extends State<PreViewImage> {
  File? file;
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
    return _buildPreViewImage();
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
          title: Text(context.l10n.t_camera_permission),
          content: Text(context.l10n.t_need_photos),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(context.l10n.t_settings),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text(context.l10n.t_settings),
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
          file = await ImageUtils.cropImage(file?.path ?? '');
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

  Widget _buildPreViewImage() {
    widget.request?.file = file;
    return GestureDetector(
      onTap: _requestAssets,
      child: Container(
        padding: EdgeInsets.all(file != null ? 0 : 35),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.secondaryButtonColor,
          border: Border.all(color: AppColors.outlineBorderColor, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: file != null
            ? Stack(
                children: [
                  GestureDetector(
                    onTap: _requestAssets,
                    child: Image.file(
                      File(file?.path ?? ''),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          file = null;
                          widget.request?.file = file;
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
              )
            : Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.activeLabelItem.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: AppColors.activeLabelItem,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
