import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const ProfileScreen({Key? key, required this.params}) : super(key: key);
  static Map<String, dynamic> createArguments({required String id}) => {
        'userId': id,
      };

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          expandedHeight: 260,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Goa',
            ),
            background: Image.asset(
              AppAssets.imgHeaderDrawer,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              return ListTile(
                leading: Container(padding: EdgeInsets.all(8), width: 100, child: Placeholder()),
                title: Text('Place ${index + 1}', textScaleFactor: 2),
              );
            },
            childCount: 40,
          ),
        ),
      ],
    ));
  }
}
