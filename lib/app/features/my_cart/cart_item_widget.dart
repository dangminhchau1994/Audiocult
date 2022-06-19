part of 'my_cart_screen.dart';

class CartItemWidget extends StatefulWidget {
  final Song song;
  final VoidCallback? deleteButtonOnTap;
  final VoidCallback? onTap;

  const CartItemWidget(this.song, {this.deleteButtonOnTap, this.onTap, Key? key}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _ownerImageWidget(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _nameLabelWidget(),
                      const SizedBox(height: 8),
                      _timeWidget(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _priceLabelWidget(),
                      _deleteButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ownerImageWidget() {
    return CachedNetworkImage(
      width: 100,
      height: 100,
      errorWidget: (_, error, __) => const Icon(Icons.error),
      placeholder: (_, __) => const LoadingWidget(),
      imageUrl: widget.song.imagePath ?? '',
      imageBuilder: (_, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _nameLabelWidget() {
    return Text(
      widget.song.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.headerStyle(),
    );
  }

  Widget _priceLabelWidget() {
    return Text(
      widget.song.cost.toString(),
      style: context.subtitleTextStyle(),
    );
  }

  Widget _timeWidget() {
    return Text(
      DateTimeUtils.formatyMMMMd(int.tryParse(widget.song.timeStamp ?? '') ?? 0),
      style: context.subtitleTextStyle()?.copyWith(color: AppColors.subTitleColor),
    );
  }

  Widget _deleteButton() {
    return TextButton(
      onPressed: widget.deleteButtonOnTap,
      child: Text(context.l10n.t_delete),
    );
  }
}
