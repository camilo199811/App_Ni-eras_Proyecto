import 'package:babysitters_app/pages/parte2/Menu_Screen.dart';
import 'package:babysitters_app/pages/parte3/admin/editServiceOption.dart';
import 'package:babysitters_app/pages/parte3/admin/listservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//import 'package:nani/utils/colors.dart' as utils;

class homeAdmin extends StatefulWidget {
  @override
  _homeAdminState createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
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
                      colors: [Colors.red, Colors.blue, Colors.purple])),
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
          MaterialPageRoute(builder: (context) => (MenuScreen())),
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
              MaterialPageRoute(builder: (context) => (ListServicePage())),
            );
          },
          label: const Text('Ver Servicios'),
          icon: const Icon(Icons.remove_red_eye),
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
              MaterialPageRoute(builder: (context) => (editService())),
            );
          },
          label: const Text('Editar Servicios'),
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
            labelText: 'ectronico',
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
