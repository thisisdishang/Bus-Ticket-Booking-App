import 'package:bus_ticket_booking_app/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Add extends StatefulWidget {

  const Add({Key? key,
    this.id,
    this.name,
    this.mobileNo,
    this.age,
    this.gender,
    this.date,
    this.fromcity,
    this.tocity,
    this.bustype,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? mobileNo;
  final String? age;
  final String? gender;
  final String? date;
  final String? fromcity;
  final String? tocity;
  final String? bustype;

  @override
  State<Add> createState() => _AddState();
}
// for Authentication login and signup
class _AddState extends State<Add> {


  TextEditingController username = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController dateofJourney = TextEditingController();
  AuthController authController=Get.put(AuthController());

//list for gender
  String? selectedGender;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedFromCity ;
  List<String> get FromCity => [
    'Surat',
    'Ahmedabad',
    'Vadodra',
    'Bharuch',
    'Vapi',
    'Rakot',
  ];
  String? selectedToCity;
  List<String> get ToCity => [
    'Rajasthan',
    'Delhi',
    'Karnatak',
    'Banglore',
    'Mumbai',
    'Jaipur',
  ];
  String? selectedbustype;
  final List<String> _locations =[
    'AC Sleeper(2+2)',
    'AC Seater(3+2)',
    'Non AC Sleeper',
    'Non AC Sleeper(2+2)',
    'Volvo Multi-Axle A/C Semi Sleeper',
    'Single Deck',
    'Double Deck'
  ];
  String? onclick;
  bool seepwd = false;
  bool changebutton =false;
  final _formkey = GlobalKey<FormState>();
// navigation and animation button code
  /*moveToHome(BuildContext context) async{
    if(_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
       Navigator.push(
        context, MaterialPageRoute(builder: (context) => Submit()),);
      setState(() {
        changebutton = false;
      });
    }
  }*/

  @override
  void initState() {
    widget.id!=null?username.text=widget.name.toString():"";
    widget.id!=null?age.text=widget.age.toString():"";
    widget.id!=null?number.text=widget.mobileNo.toString():"";
    widget.id!=null?selectedGender=widget.gender.toString():"";
    widget.id!=null?selectedbustype=widget.bustype.toString():"";
    widget.id!=null?selectedFromCity=widget.fromcity.toString():"";
    widget.id!=null?selectedToCity=widget.tocity.toString():"";
    widget.id!=null?dateofJourney.text=widget.date.toString():"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child:  Text("BusTicket Booking",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //------Textformfiled code-------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      child : Column(
                          children: [
                            TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Enter Your Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  labelText: "Name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: age,
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  counterText: "",
                                  hintText: "Enter Your Age(In Yrs)",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Age"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Age cannot be empty";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: number,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  counterText: "",
                                  filled: true,
                                  hintText: "Enter Your Mobile Number",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Mobile Number"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Mobile Number cannot be empty";
                                }else if(value.length > 10)
                                  return "Mobile number should be 10 digit";
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Gender :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Select Your Gender',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: genderItems
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select gender.';
                                  }
                                },
                                value: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value.toString();
                                  });
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("From :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Select Your City',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: FromCity
                                    .map((items) =>
                                    DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(
                                        items,
                                        style:  TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                validator: (value){
                                  if(value == null)
                                    return 'Please select city';
                                },
                                value: selectedFromCity,
                                onChanged: (fromvalue) {
                                  selectedFromCity = fromvalue.toString();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("TO :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint:  const Text(
                                  'Select Your City',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                value: selectedToCity,
                                onChanged: (tovalue) {
                                  setState(() {
                                    selectedToCity = tovalue.toString();
                                  });
                                },
                                items: ToCity
                                    .map((items) =>
                                    DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(
                                        items,
                                        style:  TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                validator: (value){
                                  if(value==null)
                                    return 'Please select city';
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Select Class :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Select Bus Type',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                value: selectedbustype,
                                onChanged: (newvalue) {
                                  setState(() {
                                    selectedbustype = newvalue.toString();
                                  });
                                },
                                items: _locations
                                    .map((location) =>
                                    DropdownMenuItem<String>(
                                      value: location,
                                      child: Text(
                                        location,
                                        style:  TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                validator: (value){
                                  if(value==null)
                                    return 'Please select class';
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Date :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(

                                readOnly: true,
                                controller: dateofJourney,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    hintText: 'Pick your Date'
                                ),
                                validator: (value){
                                  if(value==false)
                                    return 'Please select Date';
                                  return null;
                                },
                                onTap: () async {
                                  DateFormat('dd/mm/yyyy').format(DateTime.now());
                                  var date =  await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:DateTime.now(),
                                      lastDate: DateTime(2100));
                                  dateofJourney.text = date.toString().substring(0,10);
                                },),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //-----------Login Button code---------------
                            InkWell(
                              onTap: () => Submit(),
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width:changebutton? 50: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child:changebutton? Icon(Icons.done):Text(widget.id==null?"Submit":"Update",style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 18),),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(changebutton ? 50:8)
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
  Submit() async{
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    if(_formkey.currentState!.validate()){
      try{
        setState(() {
          changebutton=true;
        });
        if(widget.id ==null){
          await FirebaseFirestore.instance.collection("Busticketbook").add({
            'name': username.text,
            'age': age.text,
            'mobileno':number.text,
            'gender': selectedGender,
            'fromcity': selectedFromCity,
            'tocity': selectedToCity,
            'bustype': selectedbustype,
            'date': dateofJourney.text,
            'userId':userId,
          }).whenComplete(() {
            Get.snackbar("Bus-Ticket Book", "Ticket book successfully",snackPosition: SnackPosition.BOTTOM);
            Navigator.of(context).pop();
          });
        }else{//update code
          await FirebaseFirestore.instance.collection("Busticketbook").doc(widget.id).update({
            'name': username.text,
            'age': age.text,
            'mobileno':number.text,
            'gender':selectedGender,
            'fromcity': selectedFromCity,
            'tocity': selectedToCity,
            'bustype': selectedbustype,
            'date': dateofJourney.text,
            'userId':userId
          }).whenComplete((){
            Get.snackbar('Update Bus-Ticket Book', 'Update Ticket book succesfully',snackPosition: SnackPosition.BOTTOM);
            Navigator.of(context).pop();
          });
        }
        setState(() {
          changebutton=false;
        });
      }catch(e){
        print(e);
        setState(() {
          changebutton = false;
        });
        Get.snackbar('Something went wrong',e.toString(),snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}


