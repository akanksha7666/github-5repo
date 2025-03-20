import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/controller/ui/appointment_scheduling_controller.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReportAndAnalyticSchedulingScreen extends StatefulWidget {
  const ReportAndAnalyticSchedulingScreen({super.key});

  @override
  State<ReportAndAnalyticSchedulingScreen> createState() => ReportAndAnalyticSchedulingScreenState();
}

class ReportAndAnalyticSchedulingScreenState extends State<ReportAndAnalyticSchedulingScreen> with UIMixin {
  ReportAndAnalyticSchedulingController controller = Get.put(ReportAndAnalyticSchedulingController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'appointment_scheduling_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Appointment Scheduling",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Appointment Scheduling', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  borderRadiusAll: 12,
                  height: 700,
                  child: SfCalendar(
                    view: CalendarView.workWeek,
                    allowedViews: const [
                      CalendarView.day,
                      CalendarView.week,
                      CalendarView.month,
                      CalendarView.workWeek,
                      CalendarView.timelineWorkWeek
                    ],
                    dataSource: controller.events,
                    allowDragAndDrop: true,
                    onDragEnd: controller.dragEnd,
                    monthViewSettings: const MonthViewSettings(showAgenda: true),
                    allowAppointmentResize: true,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
