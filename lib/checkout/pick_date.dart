import 'package:flutter/material.dart';
import 'package:just_up/checkout/pick_places.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:table_calendar/table_calendar.dart';

class PickDate extends StatefulWidget {
  const PickDate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  TextStyle dayStyle(FontWeight fontWeight) {
    return const TextStyle(color: Color(0x00ff3038));
  }

  int from = 0, to = 10;

  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text("Дата поездки"),
            ),
            body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      TableCalendar(
                        locale: 'ru_RU',
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: const CalendarStyle(
                            todayTextStyle: TextStyle(color: Colors.white),
                            selectedTextStyle: TextStyle(color: Colors.white)
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                                color: Color(0xffDC3C4D),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                            weekendStyle: TextStyle(
                                color: Color(0xffDC3C4D),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            )
                        ),
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                                color: Color(0xffDC3C4D),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: Color(0xffDC3C4D),
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: Color(0xffDC3C4D),
                            )
                        ),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 30),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.55,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                            ),
                            color: Color(0xff2247e4)
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Text(
                                        "Продолжительность",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 12.5),
                                    child: Text(
                                        "От",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () => setState(() => from--),
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius: BorderRadius.circular(90)
                                            ),
                                            child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 20
                                            )
                                        )
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      from.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                        onTap: () => setState(() => from++),
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff00cf8d),
                                                borderRadius: BorderRadius.circular(90)
                                            ),
                                            child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 20
                                            )
                                        )
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 12.5),
                                    child: Text(
                                        "До",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() => to--),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(90)
                                          ),
                                          child: const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 20
                                          )
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      to.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () => setState(() => to++),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff00cf8d),
                                              borderRadius: BorderRadius.circular(90)
                                          ),
                                          child: const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 20
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                JustUpButton(
                                    text: 'Далее',
                                    color: const Color(0xffDC3C4D),
                                    press: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickPlaces()))
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
        )
      ],
    ),
  );
}