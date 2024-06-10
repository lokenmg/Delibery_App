import 'package:flutter/material.dart';

class AcercaDeNosotrosScreen extends StatelessWidget {
  const AcercaDeNosotrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de nosotros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const <Widget>[
            Text(
              'Descripción del Negocio:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'DEMIXO ofrece un servicio de entrega a domicilio que permite a nuestros clientes obtener sus productos "Cuando quieran, donde quieran y lo que quieran", a través de nuestra aplicación móvil. Nos dirigimos a familias, establecimientos y empresas que enfrentan dificultades para adquirir sus productos de forma presencial debido a limitaciones de tiempo, salud o comodidad.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Visión:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Convertirnos en el proveedor líder en los municipios de Nogales y Camerino Z. Mendoza, Veracruz de servicios de entrega a domicilio, siendo reconocidos por nuestra eficiencia, confiabilidad y compromiso con la satisfacción del cliente. Queremos facilitar la vida de las personas al brindarles acceso conveniente a una amplia variedad de productos y servicios.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Misión:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ofrecer a nuestros clientes un servicio de entrega a domicilio comprometido con la satisfacción, excelencia en la entrega rápida y confiable con un amplio catálogo de productos y servicio para satisfacer las necesidades de personas con falta de tiempo, trabajo, enfermedad o simplemente por su comodidad.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
