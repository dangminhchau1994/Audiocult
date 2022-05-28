import 'package:flutter/cupertino.dart';
import '../../services/media_service.dart';

class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Upload From Gallery'),
          onPressed: () => Navigator.of(context).pop(AppImageSource.gallery),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
