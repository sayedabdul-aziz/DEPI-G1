import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    var userData = SharedPref.getUserData();
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userData?.image ?? '',
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        Gap(13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData?.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.styleSize20,
              ),
              Gap(6),
              Text(
                userData?.email ?? '',
                style: TextStyles.styleSize12.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {
            pushTo(context, Routes.editProfile).then((value) {
              setState(() {});
              // when poop back from edit profile screen
            });
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }
}
