import 'package:babysitters_app/pages/parte3/admin/editServiceOption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:flutter/cupertino.dart';

//import 'package:nani/utils/colors.dart' as utils;

class ServiceDosEdit extends StatefulWidget {
  @override
  _ServiceDosEditState createState() => _ServiceDosEditState();
}

class _ServiceDosEditState extends State<ServiceDosEdit> {
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  TextEditingController nameControllerEdit = TextEditingController();
  bool _activo = false;

  final _scaffkey = GlobalKey<ScaffoldState>();

  final CollectionReference servicio =
      FirebaseFirestore.instance.collection("serviciosdisponibles");

  bool searchState = false;
  final CollectionReference _service =
      FirebaseFirestore.instance.collection("serviciosdisponibles");

  String valor = '';

  @override
  void initState() {
    // TODo implement initState
    super.initState();

    //readData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget appBarTitle = Text(
    "Buscar Servicio",
    style: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'omegle',
    ),
  );

  @override
  Widget build(BuildContext context) {
    ('metodo build');

    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade50,
        title: !searchState
            ? Text(
                "Paquete Prémium",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'omegle',
                ),
              )
            : TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Buscar...",
                    hintStyle: TextStyle(color: Colors.black)),
                onChanged: (text) {},
              ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => (editService())),
              );
            },
            child: const Text(
              'Atrás',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'omegle',
              ),
            ),
          ),
        ],
        shadowColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            espacio(),
            ActualizarNombre(),
            ActualizarDescricpcion(),
            ActualizarPrecioDia(),
            ActualizarPrecioNoche(),
            ActualizarCantidadNinos()
          ],
        ),
      ),
    );
  }

  Widget ActualizarNombre() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: Text('Actualizar Nombre'),
            onPressed: openDialog,
          ),
        ));
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Actualizar Nombre Paquete",
              style: TextStyle(
                  fontFamily: 'omegle', fontSize: 20, color: Colors.blueAccent),
            ),
            content: TextField(
              textCapitalization: TextCapitalization.sentences,
              //onTap: openDialog2,
              //controller: edit.nameController,

              onChanged: (value) {
                valor = value;
              },

              autofocus: true,
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Editar Nombre Paquete',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            actions: [
              TextButton(onPressed: submit, child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _service
                        .doc('0mbhF1aAjhEDNCcX2reJ')
                        .update({'nombre': valor});
                    Navigator.of(context).pop();
                  },
                  child: Text("Actualizar")),
            ],
          ));
  void submit() {
    Navigator.of(context).pop();
  }

  Widget ActualizarDescricpcion() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: Text('Actualizar Descripción'),
            onPressed: openDialogDescripcion,
          ),
        ));
  }

  Future openDialogDescripcion() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Actualizar Descripcion",
              style: TextStyle(
                  fontFamily: 'omegle', fontSize: 20, color: Colors.blueAccent),
            ),
            content: TextField(
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              //onTap: openDialog2,
              //controller: edit.nameController,

              onChanged: (value) {
                valor = value;
              },

              autofocus: true,
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Editar Descripcion',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            actions: [
              TextButton(onPressed: submit, child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _service
                        .doc('0mbhF1aAjhEDNCcX2reJ')
                        .update({'descripcion': valor});
                    Navigator.of(context).pop();
                  },
                  child: Text("Actualizar")),
            ],
          ));

  Widget espacio() {
    //Pedir Email
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    );
  }

  Widget ActualizarPrecioDia() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: Text('Actualizar Precio Dia'),
            onPressed: openDialogPrecioDia,
          ),
        ));
  }

  Future openDialogPrecioDia() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Editar Precio Hora de Dia",
              style: TextStyle(
                  fontFamily: 'omegle', fontSize: 20, color: Colors.blueAccent),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              //onTap: openDialog2,
              //controller: edit.nameController,

              onChanged: (value) {
                valor = value;
              },

              autofocus: true,
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Editar Precio',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            actions: [
              TextButton(onPressed: submit, child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _service
                        .doc('0mbhF1aAjhEDNCcX2reJ')
                        .update({'precio_hora_dia': valor});
                    Navigator.of(context).pop();
                  },
                  child: Text("Actualizar")),
            ],
          ));

  Widget ActualizarCantidadNinos() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: Text('Actualizar Cantidad Niños'),
            onPressed: openDialogCantidad,
          ),
        ));
  }

  Future openDialogCantidad() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Actualizar Cantidad Niños",
              style: TextStyle(
                  fontFamily: 'omegle', fontSize: 20, color: Colors.blueAccent),
            ),
            content: TextField(
              //onTap: openDialog2,
              //controller: edit.nameController,

              onChanged: (value) {
                valor = value;
              },

              autofocus: true,
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Editar Cantidad Niños',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            actions: [
              TextButton(onPressed: submit, child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _service
                        .doc('0mbhF1aAjhEDNCcX2reJ')
                        .update({'c_ninos': valor});
                    Navigator.of(context).pop();
                  },
                  child: Text("Actualizar")),
            ],
          ));

  Widget ActualizarPrecioNoche() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: Text('Actualizar Precio Noche'),
            onPressed: openDialogPrecioNoche,
          ),
        ));
  }

  Future openDialogPrecioNoche() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Editar Precio Hora de Noche",
              style: TextStyle(
                  fontFamily: 'omegle', fontSize: 20, color: Colors.blueAccent),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              //onTap: openDialog2,
              //controller: edit.nameController,

              onChanged: (value) {
                valor = value;
              },

              autofocus: true,
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Editar Precio',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            actions: [
              TextButton(onPressed: submit, child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _service
                        .doc('0mbhF1aAjhEDNCcX2reJ')
                        .update({'precio_hora_noche': valor});
                    Navigator.of(context).pop();
                  },
                  child: Text("Actualizar")),
            ],
          ));
}
