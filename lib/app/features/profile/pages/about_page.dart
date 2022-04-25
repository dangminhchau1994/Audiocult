import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  final ProfileData? profile;
  const AboutPage({Key? key, this.profile}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biography'.toUpperCase(),
            style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(widget.profile?.biography ?? ''),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              Text(
                'Audio Artist Category:'.toUpperCase(),
                style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
              ),
              Wrap(
                children: widget.profile?.audioArtistCategory
                        ?.map<Widget>((e) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text('$e,'),
                            ))
                        .toList() ??
                    [],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              Text(
                'Favorite Genres Of Music:'.toUpperCase(),
                style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
              ),
              Wrap(
                children: widget.profile?.favoriteGenresOfMusic
                        ?.map<Widget>((e) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text('$e,'),
                            ))
                        .toList() ??
                    [],
              )
            ],
          )
        ],
      ),
    );
  }
}
