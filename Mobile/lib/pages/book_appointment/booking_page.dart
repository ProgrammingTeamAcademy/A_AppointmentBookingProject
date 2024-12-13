import 'dart:convert';

import 'package:appointment_booking/controller/appointment_controller.dart';
import 'package:appointment_booking/model/appointment_model.dart';
import 'package:appointment_booking/model/doctor_model.dart';
import 'package:appointment_booking/pages/book_appointment/successfull_booking.dart';
import 'package:appointment_booking/pages/reservation/reservation_page.dart';
import 'package:appointment_booking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:appointment_booking/components/config.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.doctorModel,this.appointmentModel});
  DoctorModel doctorModel;

  AppointmentModel? appointmentModel = new AppointmentModel();
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime? _foucseDay ;
  DateTime? _currentDay;
  bool? isUpdateAppointment;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentDay = (!widget.appointmentModel.isNull)?DateFormat('dd-MM-yyyy').parse(widget.appointmentModel!.appointmentDate!):
        DateTime.now();
    _foucseDay = (!widget.appointmentModel.isNull)?DateFormat('dd-MM-yyyy').parse(widget.appointmentModel!.appointmentDate!):
        DateTime.now();
    _currentIndex = (!widget.appointmentModel.isNull)?getIntTime(widget.appointmentModel!.time!):null;
    selectedDate =(!widget.appointmentModel.isNull)? true : false;
    selectedTime =(!widget.appointmentModel.isNull)? true : false;
    isUpdateAppointment =(!widget.appointmentModel.isNull)? true : false;
  }
  int? _currentIndex;
  bool isWeekend = false;
  bool? selectedDate ;
  bool? selectedTime ;
  DoctorModel? doctorModel;
  @override
  Widget build(BuildContext context) {
    doctorModel = widget.doctorModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Book appointment",
          style: TextStyle(
              fontSize: config.font20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        leading:  Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.mainColor,
              boxShadow:[
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(1, 2),
                    blurRadius: 4
                )
              ]),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: FaIcon(Icons.arrow_back_ios_new),
            color: Colors.white,
            iconSize: 16,
          ),
        ),
        // actions: widget.actions,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _tableCalendar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.width10, vertical: config.height20),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontSize: config.font18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          isWeekend
              ? SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.width15, vertical: config.height30),
              alignment: Alignment.center,
              child: Text(
                'Weekend is not available, please select another date',
                style: TextStyle(
                  fontSize: config.font18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
              :SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      selectedTime = true;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(config.height10/2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currentIndex == index
                          ? AppColors.mainColor
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 9}:00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                        _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.5),
          ),
        ],
      ),
      bottomNavigationBar:  GetBuilder<AppointmentController>(
        builder: (appointmentController){
          return GestureDetector(
            onTap: (){
              if(!isUpdateAppointment!) {
                if (selectedDate! && selectedTime!) {
                  String day = getWeekDay(_currentDay!.weekday)!;
                  String time = getTime(_currentIndex!)!;
                  var outputFormat = DateFormat('dd-MM-yyyy');
                  var outputDate = outputFormat.format(_currentDay!);
                  Future res = appointmentController.bookAppointment(
                      doctorModel!.doctorClinicModel!.id!, outputDate, day,
                      time);
                  print(res);
                  Get.to(()=>SuccessfullBooking());
                }
              }else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(config.radius15)),
                    ),
                    title: Text('Update Appointment',
                        style: TextStyle(
                            fontSize: config.font18
                        )),
                    content: Text('Are you sure about update your appointment',
                        style: TextStyle(
                            fontSize: config.font14
                        )),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Get.close(1),
                        child: Text('No',
                            style: TextStyle(
                                fontSize: config.font16
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          setState((){
                            List app = json.decode(Get.find<AppointmentController>().sharedPreferences!.getString('appointments').toString());

                            String day = getWeekDay(_currentDay!.weekday)!;
                            String time = getTime(_currentIndex!)!;
                            var outputFormat = DateFormat('dd-MM-yyyy');
                            var outputDate = outputFormat.format(_currentDay!);
                            Future res = appointmentController.updateAppointment(
                                widget.appointmentModel!.id!,
                                widget.appointmentModel!.doctorClinicModel!.id!, outputDate, day,
                                time);
                            app.forEach((element) {
                              if(element['id'] == widget.appointmentModel!.id!){
                                print('${element['appointment_date']} ');
                                element['day'] = day;
                                element['time'] = time;
                                element['appointment_date'] = outputDate;
                                print('${element['id']} / ${widget.appointmentModel!.id!}');
                                print('${element['appointment_date']} ');
                              }
                            });
                            Get.find<AppointmentController>().sharedPreferences!.remove('appointments');
                            Get.find<AppointmentController>().sharedPreferences!.setString('appointments',json.encode(app));
                            print('udated successfully');
                            // Get.find<AppointmentController>().getAppointment();
                            // ReservationPageState().build(context);
                            Get.to(()=>SuccessfullBooking(update: true,));
                          });
                        },
                        child: Text('Update',
                            style: TextStyle(
                                fontSize: config.font16
                            )),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
                height: config.height45*1.2,
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: config.height15,
                  left: config.width20,
                  right: config.width20,
                  top: config.height15,
                ),
                margin: EdgeInsets.only(
                  bottom: config.height10,
                  left: config.width15,
                  right: config.width15,

                ),
                decoration: BoxDecoration(
                    color: selectedDate! && selectedTime! ? AppColors.mainColor :Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(config.radius15),
                    boxShadow:[
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(2, 3),
                          blurRadius: 4
                      )
                    ]
                ),
                child: Center(
                  child: Text(
                    isUpdateAppointment! ?
                        "Update Appointment":
                    "Make Appointment",
                    style: TextStyle(
                        fontSize: config.font18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                )
            ),
          );
        },
      ),
    );
  }


  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _foucseDay!,
      firstDay: DateTime.now(),
      lastDay: DateTime(2025,12,31),
      calendarFormat: _format,
      currentDay:  _currentDay,
      rowHeight: config.height45,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(color: AppColors.mainColor,shape: BoxShape.circle),
      ),
      availableCalendarFormats: {
        CalendarFormat.month : 'Month'
      },
      onFormatChanged: (Format){
        setState((){
          _format = Format ;
        });
      },
      onDaySelected: ((SelectedDay, Foucseday){
        setState((){
          _currentDay = SelectedDay;
          _foucseDay = Foucseday;
          selectedDate = true;
          if( SelectedDay.weekday ==7){
            isWeekend = true;
            selectedTime = false;
            _currentIndex = null;
          }else{
            isWeekend = false;
          }
        });
      }),
    );
  }
  
  String? getWeekDay(int weekDay){
    String? weekDayN;
    switch(weekDay){
      case 1 : weekDayN = "Monday"; break;
      case 2 : weekDayN = "Tuesday"; break;
      case 3 : weekDayN = "Wednesday"; break;
      case 4 : weekDayN = "Thursday"; break;
      case 5 : weekDayN = "Friday"; break;
      case 6 : weekDayN = "Saturday"; break;
      case 7 : weekDayN = "Sunday"; break;
    }
    return weekDayN;
  }

  String? getTime(int time){
    String? appointmentTime;
    switch(time){
      case 0 : appointmentTime = "09:00"; break;
      case 1 : appointmentTime = "10:00"; break;
      case 2 : appointmentTime = "11:00"; break;
      case 3 : appointmentTime = "12:00"; break;
      case 4 : appointmentTime = "13:00"; break;
      case 5 : appointmentTime = "14:00"; break;
      case 6 : appointmentTime = "15:00"; break;
      case 7 : appointmentTime = "16:00"; break;
    }
    return appointmentTime;
  }

  int? getIntTime(String time){
    int? appointmentTime;
    switch(time){
      case "09:00" : appointmentTime = 0; break;
      case "10:00" : appointmentTime = 1; break;
      case "11:00" : appointmentTime = 2; break;
      case "12:00" : appointmentTime = 3; break;
      case "13:00" : appointmentTime = 4; break;
      case "14:00" : appointmentTime = 5; break;
      case "15:00" : appointmentTime = 6; break;
      case "16:00" : appointmentTime = 7; break;
    }
    return appointmentTime;
  }
}
