import 'package:flutter/material.dart';
import 'package:flutter_app_1/shared/components/components.dart';

class LoginScreen extends StatelessWidget
{

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  validator(void print){
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {

    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E21),
        shadowColor: Colors.transparent ,
        leading: IconButton(
          icon: Icon(Icons.menu), onPressed: () {var value;
value;},
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: IconButton(
                icon: Icon(Icons.search), onPressed: () {var value;
value;},
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: Icon(Icons.more_vert), onPressed: () {var value;
value;},
            ),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  // defaultFormField(
                  //     controller: emailController,
                  //     type: TextInputType.,
                  //     validate: validate,
                  //     label: 'Username',
                  //     prefix: prefix
                  // ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    onChanged: (String value){
                      print(value);
                    },
                    validator: (String? value){
                      if (value == null || value.trim().length == 0)
                      {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.remove_red_eye
                      ),
                      prefixIcon: Icon(
                          Icons.lock
                      ),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                        elevation: MaterialStateProperty.all(3),
                      ),
                      onPressed: (){validator(
                          print(emailController.text)
                      );
                      },
                      child:
                      Text('Login'),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: (){},
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont\'t have an account?',
                      ),
                      TextButton(
                          onPressed: (){},
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: Colors.indigo,
                            ),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
       ),
    );
  }
}

