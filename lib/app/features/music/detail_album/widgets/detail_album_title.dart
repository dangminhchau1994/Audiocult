import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/datetime/date_time_utils.dart';
import '../../../../utils/route/app_route.dart';
import '../../../profile/profile_screen.dart';

class DetailAlbumTitle extends StatelessWidget {
  const DetailAlbumTitle({
    Key? key,
    this.title,
    this.userName,
    this.time,
    this.userId,
  }) : super(key: key);

  final String? title;
  final String? userName;
  final String? time;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 230,
      left: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.routeProfile,
                    arguments: ProfileScreen.createArguments(id: userId ?? ''),
                  );
                },
                child: Text(
                  userName ?? 'N/A',
                  style: context.bodyTextPrimaryStyle()!.copyWith(color: Colors.white, fontSize: 16),
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
                DateTimeUtils.formatyMMMMd(int.parse(time ?? '')),
                style: context.bodyTextPrimaryStyle()!.copyWith(color: Colors.white, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
