import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    final dynamic role =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 5.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/logo.png",
                  width: 20.0.w,
                )
              ],
            ),
            Text(
              "Términos y acuerdos de privacidad",
              style: TextStyle(fontSize: 5.0.w),
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    Text(
                      """Esta Política de privacidad describe cómo manejamos la información personal recopilada, utilizada y compartida cuando un visitante o un cliente accede a Movitronia.

SECCIÓN 1 - INFORMACIÓN TRANSACCIONAL
¿Qué haces con mi información?

Cuando adquiere una cuenta o membrecía o compra algo en nuestro sitio web, como parte del proceso de compra y venta, recopilamos la información personal que nos proporciona, como su nombre, dirección y dirección de correo electrónico.

Cuando navega por nuestra tienda, también recibimos automáticamente la dirección de protocolo de Internet (IP) de su computadora para proporcionarnos información que nos ayude a conocer su navegador y sistema operativo.

Marketing por correo electrónico: Con su permiso, podemos enviarle correos electrónicos sobre nuestra tienda, nuevos productos y otras actualizaciones.

SECCIÓN 2 - CONSENTIMIENTO
¿Cómo se obtiene mi consentimiento?

Cuando nos proporciona información personal para completar una transacción, verificar su tarjeta de crédito, realizar un pedido, organizar una entrega o devolver una compra, entendemos que acepta que la recopilemos y la usemos solo por esa razón específica. Si solicitamos su información personal por un motivo secundario, como marketing, le pediremos directamente su consentimiento expreso o le daremos la oportunidad de decir que no.

¿Cómo retiro mi consentimiento?

Después de que se inscriba o adquiera una membrecía, si cambia de opinión, puede retirar su consentimiento para que nos comuniquemos con usted, para la recopilación, uso o divulgación continua de su información, en cualquier momento, contactándonos a contacto@movitronia.com o enviándonos un correo nosotros en: Movitronia Santa Maria del Boldo, Pasaje la Sequia # 02081 Curicó, Región del Maule, Chile.

SECCIÓN 3 - DIVULGACIÓN
¿Revelas mi información?

Podemos divulgar su información personal si la ley nos exige hacerlo o si no viola nuestros Términos de Servicio.

SECCIÓN 4 - SERVICIOS DE TERCEROS
En general, los proveedores externos que utilizamos solo recopilarán, usarán y divulgarán su información en la medida necesaria para permitirles realizar los servicios que nos brindan.

Sin embargo, ciertos proveedores de servicios de terceros, como las pasarelas de pago y otros procesadores de transacciones de pago, tienen sus propias políticas de privacidad con respecto a la información que estamos obligados a proporcionarles para sus transacciones relacionadas con la compra.

Para estos proveedores, le recomendamos que lea sus políticas de privacidad para que pueda comprender la manera en que estos proveedores manejarán su información personal.

Puede optar por no recibir publicidad dirigida desde:

Facebook: https://www.facebook.com/settings/?tab=ads

Google: https://www.google.com/settings/ads/anonymous

Bing: https://advertise.bingads.microsoft.com/en-us/resources/policies/personalized-ads

En particular, recuerde que ciertos proveedores pueden estar ubicados o tener instalaciones que se encuentran en una jurisdicción diferente a usted o nosotros. Por lo tanto, si elige continuar con una transacción que involucra los servicios de un proveedor de servicios externo, su información puede quedar sujeta a las leyes de las jurisdicciones en las que se encuentran ese proveedor de servicios o sus instalaciones.

Por ejemplo, si se encuentra en Chile y su transacción es procesada por una pasarela de pago ubicada en los Estados Unidos, entonces su información personal utilizada para completar esa transacción puede estar sujeta a divulgación bajo la legislación de los Estados Unidos, incluida la Ley Patriota.

Una vez que abandona el sitio web de nuestra tienda o es redirigido a un sitio web o aplicación de terceros, ya no se rige por esta Política de privacidad ni por los Términos de servicio de nuestro sitio web.

Enlaces:

Cuando hace clic en los enlaces de nuestra tienda, es posible que lo desvíen de nuestro sitio. No somos responsables del contenido o las prácticas de privacidad de otros sitios y le recomendamos que lea sus declaraciones de privacidad.

SECCIÓN 5 - SEGURIDAD
Para proteger su información personal, tomamos precauciones razonables y seguimos las mejores prácticas de la industria para asegurarnos de que no se pierda, use indebidamente, acceda, divulgue, altere o destruya de manera inapropiada.

SECCIÓN 6 - NO SEGUIR
Nuestro sitio web utiliza "cookies" como archivos de datos que se colocan en su dispositivo o computadora y, a menudo, incluyen un identificador único anónimo. Para obtener más información sobre las cookies y cómo deshabilitarlas, visite http://www.allaboutcookies.org.

Tenga en cuenta que no modificamos las prácticas de uso y recopilación de datos de nuestro Sitio cuando vemos una señal de No rastrear desde su navegador.

Si es residente europeo, tiene derecho a acceder a la información personal que tenemos sobre usted y a solicitar que se corrija, actualice o elimine su información personal. Si desea ejercer este derecho, comuníquese con nosotros a través de la información de contacto a continuación.

SECCIÓN 7 - EDAD DE CONSENTIMIENTO
Al utilizar este sitio, usted declara que tiene al menos la mayoría de edad legal, y nos ha dado su consentimiento para permitir a cualquiera de sus representados menores para usar este sitio.

SECCIÓN 8 - CAMBIOS A ESTA POLÍTICA DE PRIVACIDAD
Nos reservamos el derecho de modificar esta política de privacidad en cualquier momento, así que revísela con frecuencia. Los cambios y aclaraciones entrarán en vigor inmediatamente después de su publicación en el sitio web. Si realizamos cambios sustanciales a esta política, le notificaremos aquí que se ha actualizado, para que sepa qué información recopilamos, cómo la usamos y bajo qué circunstancias, si las hay, usamos y / o divulgamos. eso.

Si nuestra tienda es adquirida o fusionada con otra compañía, su información puede ser transferida a los nuevos propietarios para que podamos continuar vendiéndole productos o servicios.

PREGUNTAS E INFORMACIÓN DE CONTACTO
Si desea: acceder, corregir, enmendar o eliminar cualquier información personal que tengamos sobre usted, registrar una queja o simplemente desea más información, comuníquese con nuestro Oficial de Cumplimiento de Privacidad en contacto@movitronia.com o por correo a Movitronia [Re: Oficial de cumplimiento de la privacidad],Santa Maria del Boldo, Pasaje la Sequia # 02081 Curicó Maule Chile""",
                      style: TextStyle(
                          color: Colors.black, fontFamily: "", fontSize: 4.5.w),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              width: 90.0.w,
              height: 60.0.h,
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  buttonColor: cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  minWidth: 90.0.w,
                  height: 5.0.h,
                  child: RaisedButton(
                    onPressed: () {
                      goToBasal(role);
                      // Get.to(WelcomePage(
                      //   role: widget.role,
                      // ));
                    },
                    child: Text(
                      "Acepto",
                      style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  buttonColor: cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  minWidth: 90.0.w,
                  height: 5.0.h,
                  child: RaisedButton(
                    onPressed: () {
                      rechazo();
                    },
                    child: Text(
                      "Rechazo",
                      style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> pop() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pop(context);
    Navigator.pop(context);
    return false;
  }

  rechazo() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: null,
                  body: Column(
                    children: [
                      SizedBox(
                        height: 30.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 85.0.w,
                            child: Text(
                              "DEBES ACEPTAR LOS TÉRMINOS Y CONDICIONES PARA CONTINUAR EN MOVITRONIA.",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 5.5.w),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Container(
                        width: 90.0.w,
                        height: 5.0.h,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: green,
                          textColor: Colors.white,
                          child: Text("Continuar en Movitronia".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 5.0.w, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Container(
                        width: 90.0.w,
                        height: 5.0.h,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          onPressed: () {},
                          color: green,
                          textColor: Colors.white,
                          child: Text("Salir de Movitronia".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 5.0.w, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0.h,
                      ),
                      Image.asset(
                        "Assets/images/logo.png",
                        width: 20.0.w,
                      )
                    ],
                  ));
            }));
  }
}
