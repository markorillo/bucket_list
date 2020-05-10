import 'package:bucketlist/bloc/challenge_bloc.dart';
import 'package:bucketlist/bloc/challenge_event.dart';
import 'package:bucketlist/widgets/challenge_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/challenge.dart';


class AddChallenge extends StatefulWidget {
  AddChallenge();
  @override
  AddChallengeState createState() => AddChallengeState();
}

class AddChallengeState extends State<AddChallenge> {
  DateTime _dateTime = new DateTime.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateTimeController = TextEditingController();

  void _selectDate() async  {
    DateTime current = new DateTime.now();
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: current,
        lastDate: DateTime(2101)
    );
    if(picked != null) setState(() => _dateTime = picked);
    _dateTimeController.text = picked.toString();
  }

  void _addChallenge() {
    final ChallengeBloc challengeBloc = BlocProvider.of<ChallengeBloc>(context);
    Challenge challenge = Challenge();
    challenge.name = _nameController.text;
    challenge.description = _descriptionController.text;
    challenge.dateTime = _dateTime;
    challengeBloc.add(AddChallengeEvent(challenge));
    Navigator.of(context).pop(challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('New challenge')
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Challenge",
                  hintText: 'Title of the challenge',
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: 'Write a description',
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate();   // Call Function that has showDatePicker()
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: _dateTimeController,
                    decoration: InputDecoration(labelText: 'Due')
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => _addChallenge(),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Add Challenge'),
              )
            ]
          )
        )
      )
    );
  }
}