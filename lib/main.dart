// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AgeCalculator()));
}

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({super.key});

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime selectedDate = DateTime.now();
  String age = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pick = await showDatePicker(
        context: context, firstDate: DateTime(1947), lastDate: selectedDate);

    if (pick != null && pick != selectedDate) {
      setState(() {
        selectedDate = pick;
        age = calculateAge(pick, DateTime.now());
      });
    }
  }

  String calculateAge(DateTime birthday, DateTime today) {
    int years = today.year - birthday.year;
    int months = today.month - birthday.month;
    int days = today.month - birthday.day;

    //when days less than 0, then we remove one month & add these days with current month days which are less than 0
    if (days < 0) {
      days += DateUtils.getDaysInMonth(today.year, today.month - 1);
    }

    // same case here we remove one year, add months of removed year to this current month which are less than 0
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return "$years years $months months $days days";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today Date : ${DateFormat('dd-MM-yyyy').format(DateTime.now())}",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Age : $age",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Text(
                    "Select your date of birth",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
