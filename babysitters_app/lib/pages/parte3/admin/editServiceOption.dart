import 'package:babysitters_app/pages/parte2/Menu_Screen.dart';
import 'package:babysitters_app/pages/parte3/admin/editBasico.dart';
import 'package:babysitters_app/pages/parte3/admin/editFamiliar.dart';
import 'package:babysitters_app/pages/parte3/admin/editPremium.dart';
import 'package:babysitters_app/pages/parte3/admin/homeadmin.dart';
import 'package:babysitters_app/pages/parte3/admin/listservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//import 'package:nani/utils/colors.dart' as utils;

class editService extends StatefulWidget {
  @override
  _editServiceState createState() => _editServiceState();
}

class _editServiceState extends State<editService> {
  @override
  void initState() {
    // TODo implement initState
    super.initState();

    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ('metodo build');
    return Scaffold(
      body: Stack(
        children: [
          //bannerApp(),
          //_googleMapsWidget(),

          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.red,
                    Color.fromARGB(255, 202, 170, 195),
                    Color.fromARGB(255, 174, 134, 182)
                  ])),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buttomCenterPosition()],
                  ),
                  textDescription(),
                  //textLogin(),
                  listarUsuarios(),
                  services(),
                  servicestres(),

                  Expanded(child: Container()),
                  //buttonApp(),
                  //textNoCuenta()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttomCenterPosition() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => (homeAdmin())),
        );
      },
      child: Container(
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: const Icon(
              Icons.rotate_left_outlined,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonApp() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(children: [
        ElevatedButton(onPressed: () {}, child: const Text('I gotta pee')),
        ElevatedButton.icon(
          onPressed: () {},
          label: const Text('Plus One'),
          icon: const Icon(Icons.plus_one),
        )
      ]),
    );
  }

  Widget listarUsuarios() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => (ServiceOneEdit())),
            );
          },
          label: const Text('Paquete Básico'),
          icon: const Icon(Icons.edit),
        )
      ]),
    );
  }

  Widget services() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => (ServiceDosEdit())),
            );
          },
          label: const Text('Paquete Premium'),
          icon: const Icon(Icons.edit),
        )
      ]),
    );
  }

  Widget servicestres() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => (ServiceTresEdit())),
            );
          },
          label: const Text('Paquete Familiar'),
          icon: const Icon(Icons.edit),
        )
      ]),
    );
  }

  Widget aceptarUsuario() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(children: [
        ElevatedButton(onPressed: () {}, child: const Text('I gotta pee')),
        ElevatedButton.icon(
          onPressed: () {},
          label: const Text('Plus One'),
          icon: const Icon(Icons.plus_one),
        )
      ]),
    );
  }

  Widget addAdmin() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(children: [
        ElevatedButton(onPressed: () {}, child: const Text('I gotta pee')),
        ElevatedButton.icon(
          onPressed: () {},
          label: const Text('Plus One'),
          icon: const Icon(Icons.plus_one),
        )
      ]),
    );
  }

  Widget textDescription() {
    //Titulo Bienvenido
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: const Text(
        '¡Nuestros Servicios!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'omegle',
        ),
      ),
    );
  }

  Widget textFielEmail() {
    //Pedir Email
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: const TextField(
        //controller: con.emailController,
        decoration: InputDecoration(
            hintText: 'Correo@gmail.com',
            labelText: 'Correo electrónico',
            suffixIcon: Icon(Icons.email_outlined, color: Colors.pink)),
      ),
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
