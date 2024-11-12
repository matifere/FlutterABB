import 'package:flutter/material.dart';
import 'package:flutter_abb/view/abb_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double searchPad = 0;
  double movimiento = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Arbol binario de busqueda',
                  style: TextStyle(fontFamily: 'Pacifico', fontSize: 40),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.only(left: searchPad),
                  child: GestureDetector(
                      onTap: () {
                        searchPad += movimiento;
                        if (searchPad > movimiento) {
                          searchPad = 0;
                        }
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.search,
                        size: 40,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Image.asset('images/TreeSet.jpg',
                width: MediaQuery.sizeOf(context).width / 3,
                height: MediaQuery.sizeOf(context).height / 3),
            const Text(
              'A continuacion se implementa un ABB',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 15),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    //cambiar de pagina
                    return const abbPage();
                  })); //nombre de la clase
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.white)),
                child: const Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
