import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_colors.dart';
import 'featured_album_page.dart';

class FeaturedAlbumItem extends StatelessWidget {
  const FeaturedAlbumItem({
    Key? key,
    this.onPageChange,
    this.onRetry,
    this.onShowAll,
    this.pageController,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final Function()? onShowAll;
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 140,
            imageUrl: 'https://ctmobile.vn/upload/dims.jpg',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'Chim Trang Mo Coi',
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Chau Dang',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.subTitleColor,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '15 songs',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.subTitleColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              WButtonInkwell(
                onPressed: onShowAll,
                child: Text(
                  'See all songs',
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        fontSize: 16,
                        color: AppColors.lightBlue,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          FeaturedAlbumPage(
            onPageChange: onPageChange,
            pageController: pageController,
            onRetry: onRetry,
          )
        ],
      ),
    );
  }
}
