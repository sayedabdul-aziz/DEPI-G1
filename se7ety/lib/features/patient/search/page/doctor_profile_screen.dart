import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/search/widgets/item_tile.dart';
import 'package:se7ety/features/patient/search/widgets/phone_tile.dart';
import 'package:url_launcher/url_launcher.dart';

// List<Widget> list1 = [1,2,3];
// List<Widget> list2 = [1,2,3];
// List<Widget> res = [1,2, if()...list2];

class DoctorProfileScreen extends StatelessWidget {
  final DoctorModel? doctorModel;

  const DoctorProfileScreen({super.key, this.doctorModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيانات الدكتور')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // ------------ Header ---------------
              Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.whiteColor,
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: 60,
                      backgroundImage: (doctorModel?.image != null)
                          ? NetworkImage(doctorModel!.image!)
                          : const AssetImage('assets/doc.png'),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "د. ${doctorModel?.name ?? ''}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.title,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctorModel?.specialization ?? '',
                          style: TextStyles.body,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              doctorModel?.rating.toString() ?? '0.0',
                              style: TextStyles.body,
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            PhoneButton(
                              onTap: () {
                                launchUrl(
                                  Uri.parse('tel:${doctorModel?.phone1}'),
                                );
                              },
                              backColor: AppColors.accentColor,
                              imgAssetPath: Icons.phone,
                              num: '1',
                            ),
                            if (doctorModel?.phone2?.isNotEmpty == true)
                              PhoneButton(
                                onTap: () {},
                                backColor: AppColors.accentColor,
                                imgAssetPath: Icons.phone,
                                num: '2',
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              Text(
                "نبذه تعريفية",
                style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(doctorModel?.bio ?? '', style: TextStyles.small),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text:
                          '${doctorModel?.openHour}:00 - ${doctorModel?.closeHour}:00',
                      icon: Icons.watch_later_outlined,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: doctorModel?.address ?? '',
                      icon: Icons.location_on_rounded,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                "معلومات الاتصال",
                style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text: doctorModel?.email ?? '',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: doctorModel?.phone1 ?? '',
                      icon: Icons.call,
                    ),
                    if (doctorModel?.phone2?.isNotEmpty == true) ...[
                      const SizedBox(height: 15),
                      TileWidget(
                        text: doctorModel?.phone2 ?? '',
                        icon: Icons.call,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: MainButton(
            text: 'احجز موعد الان',
            onPressed: () {
              pushTo(context, Routes.booking, extra: doctorModel);
            },
          ),
        ),
      ),
    );
  }
}
