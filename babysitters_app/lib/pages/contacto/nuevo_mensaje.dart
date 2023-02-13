// ignore_for_file: prefer_typing_uninitialized_variables, sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:math';

import 'package:babysitters_app/pages/home_screen.dart';
import 'package:babysitters_app/pages/loadings/loading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:babysitters_app/Styles/Styles.dart';

class NewMessage extends StatefulWidget {
  NewMessage({
    super.key,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  Random random = Random();

  TextEditingController nameController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descipcionController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController celularController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController ciudadController = TextEditingController();

  String urlprofile = "";
  TextEditingController estudios = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                bannerApp(),
                textDescription(),
                SizedBox(
                  height: media.height * 0.05,
                ),
                Column(
                  children: [
                    //Nombre de usuario
                    textFieltype(
                        "Usuario124",
                        "Nombre de usuario",
                        Icons.person,
                        TextInputType.name,
                        true,
                        false,
                        false,
                        nameController),
                    SizedBox(
                      height: media.width * 0.05,
                    ),

                    //Correo Electronico
                    textFieltype(
                        "Email@mail.com",
                        "Email@mail.com",
                        Icons.email,
                        TextInputType.emailAddress,
                        true,
                        false,
                        false,
                        emailController),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    textFielDescripcion(),
                    //Direccion

                    buttonLogin(),
                    textAtras()
                  ],
                ),
              ],
            ),
          ),
          (isloading == true) ? Loading() : Container()
        ],
      ),
    );
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  CollectionReference messageNew =
      FirebaseFirestore.instance.collection('message');

  Future<void> addUser(String uid) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000);
    String add = randomNumber.toString();

    String toname = add + "paquete@service.com";
    // Call the user's CollectionReference to add a new user
    var succes;
    await messageNew
        .doc(uid)
        .set({
          'name': nameController.text,
          'toname': toname,
          'email': emailController.text,
          'descripcion': descipcionController.text,
          'tipo': 'message'
        })
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => TestNotificaion(),
            ),
            (route) => false))
        .catchError((error) => succes == false);
    return succes;
    /* return users
          .add({
            
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error")); */
  }

  Widget buttonLogin() {
    Random random = Random();
    int randomNumber = random.nextInt(1000);
    String add = randomNumber.toString();

    String toname = add + "nuevomessage@message.com";
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: MaterialButton(
          onPressed: () async {
            if (!nameController.text.isNotEmpty &&
                !(nameController.text.length > 6)) {
              snac("El nombre de usuario debe ir completo");
            } else {
              if (!(emailController.text.isNotEmpty) &&
                  !(emailController.text.contains("@") &&
                      !emailController.text.contains("."))) {
                snac("Correo electrónico no valido");
              } else {
                if (!(descipcionController.text.length > 6)) {
                  snac("Por favor danos mas detalles de tu consulta");
                } else {
                  if (!(descipcionController.text.isNotEmpty)) {
                    snac("Agrega tu mensaje");
                  } else {
                    setState(() {
                      isloading = true;
                    });
                    var id;
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: toname,
                        password: nameController.text,
                      );
                      id = credential.user!.uid;
                      setState(() {
                        isloading = false;
                      });
                      addUser(id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        snac('La contraseña proporcionada es demasiado débil.');
                      } else if (e.code == 'email-already-in-use') {
                        setState(
                          () => isloading = false,
                        );
                        snac('Error,verifica tu email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }
              }
            }
          },
          color: colorprincipal,
          textColor: textColor1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      "Enviar Mensaje",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ));
  }

  void snac(String type) {
    final snackBar = SnackBar(
      backgroundColor: Colors.pink,
      content: Text('$type'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget textFielDescripcion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: 3,
          controller: descipcionController,
          decoration: InputDecoration(
              labelText: 'Asunto',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              suffixIcon: const Icon(Icons.book_outlined, color: Colors.black)),
        ),
      ),
    );
  }

  Widget textAtras() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 50,
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: const Icon(
          Icons.subdirectory_arrow_left_rounded,
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget textDescription() {
    //Titulo Bienvenido
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Text(
        '¡Nuevo Mensaje!',
        style: GoogleFonts.roboto(
          color: colorprincipal,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget textFieltype(
      String hintText,
      String labelText,
      IconData icon,
      TextInputType type,
      bool enabled,
      bool pas,
      bool telf,
      TextEditingController controller) {
    //Pedir Email
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextField(
        keyboardType: type,
        enabled: enabled,
        obscureText: pas,
        maxLength: (telf == true) ? 10 : null,
        controller: controller,
        cursorColor: colorprincipal,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: colorprincipal)),
            hintText: hintText,
            labelText: labelText,
            labelStyle: GoogleFonts.roboto(color: colorprincipal),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            suffixIcon: Icon(icon, color: coloricons.withOpacity(0.6))),
      ),
    );
  }

  Widget bannerApp() {
    //metodo para invocar la parte superior
    return ClipPath(
      //Fondo de los iconos
      child: Container(
        color: Colors.white70,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/img/icono.png',
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                '¡Eres nuestra prioridad,\n           escribenos!',
                style: GoogleFonts.pacifico(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PickImage() {}
}
