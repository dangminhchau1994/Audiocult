import 'package:audio_cult/app/features/music/featured_albums/widgets/featured_album_item.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../search/search_args.dart';

class FeaturedAlbumsScreen extends StatefulWidget {
  const FeaturedAlbumsScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SearchArgs arguments;

  @override
  State<FeaturedAlbumsScreen> createState() => _FeaturedAlbumsScreenState();
}

class _FeaturedAlbumsScreenState extends State<FeaturedAlbumsScreen> {
  final _pageController = PageController(viewportFraction: 0.96);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_featured_album,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.inputFillColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.filterIcon,
              fit: BoxFit.cover,
            ),
          ),
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoute.routeSearch,
                arguments: widget.arguments,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputFillColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppAssets.searchIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: kVerticalSpacing,
          horizontal: kHorizontalSpacing,
        ),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FeaturedAlbumItem(
              pageController: _pageController,
              onPageChange: (index) {
                debugPrint('$index');
              },
              onRetry: () {},
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 0.1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
