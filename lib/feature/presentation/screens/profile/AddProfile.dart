import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/netflix_bloc.dart';
import 'ProfileSelection.dart';


class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {

  final NetflixBloc netflixBloc = NetflixBloc();

  final profileTextController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    profileTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
     bloc: netflixBloc,
      builder: (BuildContext context, state) {
       return Scaffold(
         appBar: AppBar(
           title: Text("Add Profile"),
           actions: [
             InkWell(
                 onTap: (){
                   netflixBloc.add(AddUserEvent(profileTextController.text));
                   Navigator.push(context, MaterialPageRoute( builder: (context) => const ProfileSelectionScreen()));
                   },
                 child: Container(
                     margin: EdgeInsets.only(right: 20),
                     child: Center(child: Text("Save",style: TextStyle(fontSize: 20),))))
           ],
         ),
         body: Column(
           children: [

             Container(
               margin: EdgeInsets.all(50),
               child: TextField(
                 controller: profileTextController,
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: 'Add Profile',
                 ),
               ),
             ),
           ],
         ),
       );


      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}