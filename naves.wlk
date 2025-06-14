class Nave {
  var velocidad
  var dirRespectoAlSol

  method dirRespectoAlSol() = limitadorSol.limite(dirRespectoAlSol)

  //Metodos de indicacion
  method prepararViaje() {}

  method acelerar(cuanto) {
    velocidad = 100000.min(velocidad + cuanto)
  }

  method desacelerar(cuanto) {
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol() {
    dirRespectoAlSol = 10
  }

  method escaparDelSol() {
    dirRespectoAlSol = -10
  }

  method paraleloAElSol() {
    dirRespectoAlSol = 0
  }

  method acercarseUnPocoAlSol() {
    dirRespectoAlSol = 10.min(dirRespectoAlSol + 1)
  }

  method alejarseUnPocoAlSol() {
    dirRespectoAlSol = -10.max(dirRespectoAlSol - 1)
  }
}

object limitadorSol{
  method limite(valor) = if (valor < -10) -10 else if (valor > 10) 10 else valor
}

class NaveBaliza inherits Nave {
  var colorBaliza

  override method prepararViaje() {
    self.cambiarColorDeBaliza("verde")
    self.paraleloAElSol()
  }

  method cambiarColorDeBaliza(colorNuevo) {
    colorBaliza = colorNuevo
  }
}

class NavePasajeros inherits Nave {
  const cantPasajeros
  var racionesComida
  var racionesBebidas

  override method prepararViaje() {
    self.cargarRacionComida(4 * cantPasajeros)
    self.cargarRacionBebidas(6 * cantPasajeros)
    self.acercarseUnPocoAlSol()
  } 

  method cargarRacionComida(numero) {
    racionesComida += numero
  }

  method descargarRacionComida() {
    racionesComida = 0.max(racionesComida - 1)
  }

  method cargarRacionBebidas(numero) {
    racionesComida += numero
  }

  method descargarRacionBebidas() {
    racionesBebidas = 0.max(racionesBebidas - 1)
  }
}

class NaveCombate inherits Nave {
  var estaInvisible
  var misilesDesplegados
  const property mensajesEmitidos = []

  //Metodos de consulta
  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados
  method esEscueta() = mensajesEmitidos.any({m => m.length() > 30})
  method primerMensaje() = mensajesEmitidos.first()
  method ultimoMensaje() = mensajesEmitidos.last()
  method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)

  //Metodos de indicacion
  override method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  method ponerseVisible() {
    estaInvisible = false
  }

  method ponerseInvisible() {
    estaInvisible = true
  }

  method replegarMisiles() {
    misilesDesplegados = false
  }

  method desplegarMisiles() {
    misilesDesplegados = true
  }

  method emitirMensaje(unMensaje) {
    mensajesEmitidos.add(unMensaje)
  }
}