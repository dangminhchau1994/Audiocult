part of 'my_cart_screen.dart';

class CartItemWidget extends StatelessWidget {
  final Song song;
  final VoidCallback? removableCheckboxOnChange;
  final VoidCallback? onTap;
  final bool isChecked;
  final String currency;

  const CartItemWidget(
    this.song, {
    this.removableCheckboxOnChange,
    this.onTap,
    this.isChecked = false,
    required this.currency,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _ownerImageWidget(),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameLabelWidget(context),
                        const SizedBox(height: 4),
                        _timeWidget(context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _priceLabelWidget(context),
                        _removableItemCheckbox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ownerImageWidget() {
    return Center(
      child: CachedNetworkImage(
        width: 100,
        height: 100,
        errorWidget: (_, error, __) => const Icon(Icons.error),
        placeholder: (_, __) => const LoadingWidget(),
        imageUrl: song.imagePath ?? '',
        imageBuilder: (_, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.scaleDown,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _nameLabelWidget(BuildContext context) {
    return Text(
      song.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.headerStyle(),
    );
  }

  Widget _priceLabelWidget(BuildContext context) {
    return Text(
      '${NumberFormat.compact().format(double.tryParse(song.cost ?? '0'))} $currency',
      style: context.subtitleTextStyle(),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Text(
      DateTimeUtils.formatyMMMMd(int.tryParse(song.timeStamp ?? '') ?? 0),
      style: context.subtitleTextStyle()?.copyWith(color: AppColors.subTitleColor),
    );
  }

  Widget _removableItemCheckbox() {
    return TextButton(
      onPressed: () {
        removableCheckboxOnChange?.call();
      },
      child:
          isChecked ? SvgPicture.asset(AppAssets.squareCheckedIcon) : SvgPicture.asset(AppAssets.squareUncheckedIcon),
    );
  }
}
