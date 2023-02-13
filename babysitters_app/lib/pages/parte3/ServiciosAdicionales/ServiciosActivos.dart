import 'package:babysitters_app/Styles/Styles.dart';
import 'package:babysitters_app/pages/loadings/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiciosActivosD extends StatefulWidget {
  String tipo;
  ServiciosActivosD({required this.tipo});
  @override
  _ServiciosActivosDState createState() => _ServiciosActivosDState();
}

class _ServiciosActivosDState extends State<ServiciosActivosD> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('servicios')
      .where('idUsuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('terminado', isEqualTo: false)
      .snapshots();
  final Stream<QuerySnapshot> _usersStream2 = FirebaseFirestore.instance
      .collection('servicios')
      .where('idNinera', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('terminado', isEqualTo: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: (widget.tipo == "client") ? _usersStream : _usersStream2,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Tus servicios'),
          ),
          body: ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              print(data);
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: media.width * 0.9,
                    height: media.width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.7),
                        borderRadius: BorderRadius.all(Radius.circular(19))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          (data['idNinera'] != null)
                              ? Icons.bookmark_outlined
                              : Icons.bookmark_outline_sharp,
                          color: Color.fromARGB(255, 247, 184, 205),
                          size: media.width * 0.08,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['tipo'],
                              style: GoogleFonts.poppins(
                                color: textColor1,
                                fontSize: media.width * 0.05,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${data['precio']}',
                                  style: GoogleFonts.poppins(
                                    color: textColor1,
                                    fontSize: media.width * 0.03,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Fecha:${(data['fechainicial'] != '') ? data['fechainicial'] : "null"}',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.poppins(
                                        color: textColor1,
                                        fontSize: media.width * 0.03,
                                      ),
                                    ),
                                    Text(
                                      'Hora:${(data['Hora'] != '') ? data['Hora'] : "null"}',
                                      style: GoogleFonts.poppins(
                                        color: textColor1,
                                        fontSize: media.width * 0.03,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        (widget.tipo == 'client')
                            ? (data['idNinera'] != null)
                                ? InkWell(
                                    onTap: () {
                                      descpackage(data, document.id);
                                    },
                                    child: Icon(
                                      Icons.info,
                                      color: Color.fromARGB(255, 247, 184, 205),
                                      size: media.width * 0.08,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      cancelarservice(document.id);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 247, 184, 205),
                                      size: media.width * 0.08,
                                    ),
                                  )
                            : InkWell(
                                onTap: () {
                                  infoservice(data, document.id);
                                },
                                child: Icon(
                                  Icons.info,
                                  color: Color.fromARGB(255, 247, 184, 205),
                                  size: media.width * 0.08,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> descpackage(var data, String uid) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          height: 200,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    "Información de tu servicio",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pacifico(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: colorprincipal),
                  ),
                  Text(
                    "Niñera seleccionada: ${data['ninera']}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: colorprincipal),
                  ),
                  Text(
                    "Telefono de la niñera: ${data['telefono']}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: colorprincipal),
                  ),
                  Text(
                    "Observaciones: ${data['observaciones']}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: colorprincipal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _launched = _makePhoneCall(data['telefono']);
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: coloricons, width: 3),
                              color: textColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                            "Llamar a la niñera",
                            style: GoogleFonts.poppins(
                                color: colorprincipal,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          CollectionReference users = FirebaseFirestore.instance
                              .collection('servicios');
                          users
                              .doc(uid)
                              .update({'terminado': true, 'cancelado': true})
                              .then((value) => {
                                    print("User Updated"),
                                    Navigator.pop(context)
                                  })
                              .catchError((error) =>
                                  print("Failed to update user: $error"));
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: coloricons, width: 3),
                              color: textColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                            "Cancelar Servicio",
                            style: GoogleFonts.poppins(
                                color: colorprincipal,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> cancelarservice(String uid) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          height: 200,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cancelar Servicio",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pacifico(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: colorprincipal),
                  ),
                  Text(
                    "¿Deseas cancelar este servicio solicitado?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: colorprincipal),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('servicios');
                      users
                          .doc(uid)
                          .update({
                            'terminado': true,
                            'cancelado': true,
                            'estado': false
                          })
                          .then((value) =>
                              {print("User Updated"), Navigator.pop(context)})
                          .catchError((error) =>
                              print("Failed to update user: $error"));
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: coloricons, width: 3),
                          color: textColor1,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        "Cancelar Servicio",
                        style: GoogleFonts.poppins(
                            color: colorprincipal, fontWeight: FontWeight.w500),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> infoservice(var data, String uid) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          height: 300,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Informacion de tu servicio",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pacifico(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: colorprincipal),
                  ),
                  Text(
                    "Datos de tu servicio",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorprincipal),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Acudiente:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorprincipal),
                      ),
                      Text(
                        "${data['NombreUsuario']}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorprincipal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fecha inicial:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorprincipal),
                      ),
                      Text(
                        "${data['fechainicial']}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorprincipal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Direccion:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorprincipal),
                      ),
                      Text(
                        // "${data['']}/${data['municipio']}",
                        "${data['direccion']}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorprincipal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cantidad Horas:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorprincipal),
                      ),
                      Text(
                        "${data['cantidadHoras']}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorprincipal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Observaciones:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorprincipal),
                      ),
                      Text(
                        // "${data['']}/${data['municipio']}",
                        "${data['observaciones']}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorprincipal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _launched = _makePhoneCall(data['celular']);
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: coloricons, width: 3),
                              color: textColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                            "Llamar al Acudiente",
                            style: GoogleFonts.poppins(
                                color: colorprincipal,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          CollectionReference users = FirebaseFirestore.instance
                              .collection('servicios');
                          users
                              .doc(uid)
                              .update({
                                'terminado': true,
                              })
                              .then((value) => {
                                    print("User Updated"),
                                    Navigator.pop(context)
                                  })
                              .catchError((error) =>
                                  print("Failed to update user: $error"));
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: coloricons, width: 3),
                              color: textColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                            "Finalizar servicio",
                            style: GoogleFonts.poppins(
                                color: colorprincipal,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void>? _launched;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
