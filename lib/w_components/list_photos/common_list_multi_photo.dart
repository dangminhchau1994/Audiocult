// ignore: must_be_immutable
import 'dart:collection';

import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/list_photos/common_multi_photo_item.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../app/utils/constants/app_colors.dart';
import '../appbar/common_appbar.dart';

// ignore: must_be_immutable
class CommonListMultiPhotos extends StatefulWidget {
  CommonListMultiPhotos(
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
  State<CommonListMultiPhotos> createState() => _CommonListMultiPhotosState();
}

class _CommonListMultiPhotosState extends State<CommonListMultiPhotos> {
  List<AssetEntity>? entities = [];
  HashSet selectItems = HashSet();
  bool isMultiSelectionEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: isMultiSelectionEnabled ? getSelectedItemCount() : context.l10n.t_photos,
        centerTitle: false,
        leading: isMultiSelectionEnabled
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isMultiSelectionEnabled = false;
                    selectItems.clear();
                  });
                },
                icon: const Icon(Icons.close),
              )
            : null,
        actions: [
          if (selectItems.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  widget.entities?.forEach((element) {
                    if (selectItems.contains(element.id)) {
                      entities?.add(element);
                    }
                  });
                });
                Navigator.pop(context, entities);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(context.l10n.t_done),
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
                            context.l10n.t_add_image,
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

  String getSelectedItemCount() {
    return selectItems.isNotEmpty ? '${selectItems.length} item selected' : 'No item selected';
  }

  void doMultiSelection(String path) {
    if (isMultiSelectionEnabled) {
      setState(() {
        if (selectItems.contains(path)) {
          selectItems.remove(path);
        } else {
          selectItems.add(path);
        }
      });
    }
  }

  Widget _buildBody(BuildContext context) {
    if (widget.path == null) {
      return const Center(child: Text('Request paths first.'));
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
          return CommonMultiPhotoItem(
            key: ValueKey<int>(index),
            entity: widget.entities![index],
            index: index,
            selectItems: selectItems,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            onTap: () {
              isMultiSelectionEnabled = true;
              doMultiSelection(widget.entities![index].id);
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
