import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import '../../services/media_service.dart';

class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(context.localize.t_upload_from_gallery),
          onPressed: () => Navigator.of(context).pop(AppImageSource.gallery),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(context.localize.t_cancel),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
