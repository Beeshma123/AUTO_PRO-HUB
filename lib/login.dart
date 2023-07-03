

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Login1 extends StatefulWidget {
  const Login1({Key? key}) : super(key: key);
  @override
  State<Login1> createState() => _Login1State();
}
class _Login1State extends State<Login1> {
  final formkey=GlobalKey<FormState>();
  final email=TextEditingController();
  final Password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:SingleChildScrollView(
          child:Form(
            key: formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SIGN IN ",
                    style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                  Text("TO CONTINUE",

                    style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                     child:TextFormField(
                      validator:(val){
                        if(val!.isEmpty){
                          return "email cannot empty";
                        }else if(val.length<3){
                          return "email must be atleast 3 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText:"info@petermocanu.com",
                      ),

                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:TextFormField(
                      validator:(val){
                        if(val!.isEmpty){
                          return "password cannot empty";
                        }else if(val.length<8){
                          return "password must be atleast 8 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: ".......",
                          suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    if(formkey.currentState!.validate()){
                      debugPrint("All validation pressed");
                    }
                    Fluttertoast.showToast(msg:"Login success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,timeInSecForIosWeb:3,
                      backgroundColor: Colors.blue,
                      fontSize: 10,
                    );
                    // Timer(
                    //     Duration(seconds: 3),
                        () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Welcome()));
                  },child: Text("Login",)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Login1();
                        },));
                      },
                      child: Text("Lost password?",style:TextStyle(color: Colors.black),),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.g_mobiledata_rounded,color: Colors.red,
                            size: 24.0,
                          ),
                          label: const Text('Google'),
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.facebook,color: Colors.black,
                            size: 24.0,
                          ),
                          label: const Text('facebook'),
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                          ),
                        ),
                      ]
                  ),
                  SizedBox(
                    height:70 ,
                  ),

                  Text('''
               -------------
                '''
                  ),
                  TextButton(onPressed: (){
                    },
                      child: Text("Don't have an account?Register" )),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
