import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/list_photos/common_photo_item.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// ignore: must_be_immutable
class CommonListPhotos extends StatefulWidget {
  CommonListPhotos(
      {Key? key,
      this.entities,
      this.isLoadingMore,
      this.hasMoreToLoad,
      this.loadMoreAsset,
      this.path,
      this.permissionState})
      : super(key: key);

  List<AssetEntity>? entities;
  bool? isLoadingMore;
  bool? hasMoreToLoad;
  Function()? loadMoreAsset;
  AssetPathEntity? path;
  PermissionState? permissionState;

  @override
  State<CommonListPhotos> createState() => _CommonListPhotosState();
}

class _CommonListPhotosState extends State<CommonListPhotos> {
  int _selectedIndex = -1;
  List<AssetEntity>? entities;
  late AssetEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.localize.t_photos,
        centerTitle: true,
        actions: [
          if (_selectedIndex >= 0)
            InkWell(
              onTap: () {
                setState(() {
                  entity = widget.entities![_selectedIndex];
                });
                Navigator.pop(context, entity);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(context.localize.t_done),
              ),
            )
          else
            const SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.permissionState != PermissionState.authorized)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      flex: 7,
                      child: Text(
                        'You have granted access to some photos. You can add photos or allow access to all photos',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () async {
                          await PhotoManager.presentLimited();
                          final paths = await PhotoManager.getAssetPathList(onlyAll: true);
                          widget.path = paths.first;
                          widget.entities = await widget.path!.getAssetListPaged(page: 0, size: 50);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryButtonColor,
                          ),
                          child: Text(
                            context.localize.t_add_image,
                            style: context.bodyTextStyle()?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox(),
            _buildBody(context)
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (widget.path == null) {
      return Center(child: Text(context.localize.t_request_path_first));
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == widget.entities!.length - 8 && !widget.isLoadingMore! && widget.hasMoreToLoad!) {
            widget.loadMoreAsset!();
          }
          entity = widget.entities![index];
          return CommonPhotoItem(
            key: ValueKey<int>(index),
            entity: entity,
            selectedIndex: _selectedIndex,
            index: index,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            onTap: () {
              setState(() {
                _selectedIndex = index;
                entity = widget.entities![_selectedIndex];
              });
            },
          );
        },
        childCount: widget.entities?.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }
}
