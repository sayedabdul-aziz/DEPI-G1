import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/alert_dialog.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';
import 'package:se7ety/features/patient/booking/data/available_appointments.dart';

class BookingFormScreen extends StatefulWidget {
  final DoctorModel doctorModel;

  const BookingFormScreen({super.key, required this.doctorModel});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int selectedHour = -1;

  List<int> times = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('احجز مع دكتورك')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              IgnorePointer(
                ignoring: true,
                child: DoctorCard(doctor: widget.doctorModel),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '-- ادخل بيانات الحجز --',
                        style: TextStyles.title,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'اسم المريض',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      style: TextStyles.body.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'رقم الهاتف',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      style: TextStyles.body.copyWith(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'وصف الحاله',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyles.body.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'تاريخ الحجز',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل تاريخ الحجز';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyles.body.copyWith(),
                      decoration: const InputDecoration(
                        hintText: 'ادخل تاريخ الحجز',
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 18,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: TextStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (var hour in times)
                          ChoiceChip(
                            backgroundColor: AppColors.accentColor,
                            // showCheckmark: false,
                            checkmarkColor: AppColors.whiteColor,
                            // avatar: const Icon(Icons.abc),
                            selectedColor: AppColors.primaryColor,
                            label: Text(
                              // hh:mm (9,10,11,12)
                              //   + hour:00  (9:00 / 10:00)
                              '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
                              style: TextStyle(
                                color: hour == selectedHour
                                    ? AppColors.whiteColor
                                    : AppColors.darkColor,
                              ),
                            ),
                            selected: hour == selectedHour,
                            onSelected: (_) {
                              setState(() {
                                selectedHour = hour;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: MainButton(
          text: 'تأكيد الحجز',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (selectedHour != -1) {
                _createAppointment();
              } else {
                showMyDialog(context, 'من فضلك اختر وقت الحجز');
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    var appointmentData = AppointmentModel(
      patientID: FirebaseAuth.instance.currentUser?.uid ?? "",
      doctorID: widget.doctorModel.uid ?? '',
      name: _nameController.text,
      doctorName: widget.doctorModel.name ?? '',
      phone: _phoneController.text,
      description: _descriptionController.text,
      location: widget.doctorModel.address ?? '',
      date: DateTime.parse(
        '${_dateController.text} ${(selectedHour < 10) ? '0' : ''}$selectedHour:00:00',
      ), //yyyy-MM-dd hh:mm:ss
      isComplete: false,
    );
    await FirestoreServices.createAppointment(appointmentData).then((_) {
      showAlertDialog(
        context,
        title: 'تم تسجيل الحجز !',
        actionText: 'اضغط للانتقال',
        onTap: () {
          pushToBase(context, Routes.patientMain);
        },
      );
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      // selectableDayPredicate: (day) {
      //! Disable (sunday, saturday, friday) to select from the calendar
      //   if (day.weekday == DateTime.sunday ||
      //       day.weekday == DateTime.saturday) {
      //     return false;
      //   }
      //   return true;
      // },
    ).then((date) {
      if (date != null) {
        _dateController.text = DateFormat('yyyy-MM-dd').format(date);
        selectedHour = -1;
        times = getAvailableAppointments(
          date,
          widget.doctorModel.openHour ?? "0",
          widget.doctorModel.closeHour ?? "0",
        );
        setState(() {});
      }
    });
  }
}
