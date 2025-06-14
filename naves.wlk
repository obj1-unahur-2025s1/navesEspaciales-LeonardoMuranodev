class Nave {
  var velocidad
  var dirRespectoAlSol
  var combustible

  //Metodos de consulta
  method dirRespectoAlSol() = limitadorSol.limite(dirRespectoAlSol)

  method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()

  method estaTranquila() = combustible > 4000 && velocidad < 12000

  method tienePocaActividad() = true

  //Metodos de indicacion
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method escapar(){}

  method avisar(){}

  method cargarCombustible(cuanto) {
    combustible += cuanto
  }

  method descargarCombustible(cuanto) {
    combustible = 0.max(combustible - cuanto)
  }

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
  var nuncaCambioElcolor = true

  //Metodos de consulta
  override method tienePocaActividad() = nuncaCambioElcolor

  override method estaTranquila() = super() && colorBaliza != "rojo"

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.paraleloAElSol()
  }

  override method escapar() {
    self.irHaciaElSol()
  }

  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }

  method cambiarColorDeBaliza(colorNuevo) {
    colorBaliza = colorNuevo
    if (nuncaCambioElcolor) {
      nuncaCambioElcolor = false
    }
  }
}

class NavePasajeros inherits Nave {
  const cantPasajeros
  var racionesComida
  var racionesBebidas
  var racionesComidaServidas = 0

  //Metodos de consulta
  override method tienePocaActividad() = racionesComidaServidas < 50

  override method prepararViaje() {
    super()
    self.cargarRacionComida(4 * cantPasajeros)
    self.cargarRacionBebidas(6 * cantPasajeros)
    self.acercarseUnPocoAlSol()
  } 

  override method escapar() {
    self.acelerar(velocidad * 2)
  }

  override method avisar() {
    self.descargarRacionComida(cantPasajeros)
    self.descargarRacionBebidas(cantPasajeros * 2)
  }

  method cargarRacionComida(numero) {
    racionesComida += numero
    racionesComidaServidas += numero
  }

  method descargarRacionComida(numero) {
    racionesComida = 0.max(racionesComida - numero)
  }

  method cargarRacionBebidas(numero) {
    racionesComida += numero
  }

  method descargarRacionBebidas(numero) {
    racionesBebidas = 0.max(racionesBebidas - numero)
  }
}

class NaveHospital inherits NavePasajeros {
  var quirofanosPreparados

  override method estaTranquila() = super() && !quirofanosPreparados

  override method recibirAmenaza() {
    super()
    quirofanosPreparados = true
  }
}

class NaveCombate inherits Nave {
  var estaInvisible
  var misilesDesplegados
  const property mensajesEmitidos = []

  //Metodos de consulta
  override method estaTranquila() = super() && !misilesDesplegados
  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados
  method esEscueta() = mensajesEmitidos.any({m => m.length() > 30})
  method primerMensaje() = mensajesEmitidos.first()
  method ultimoMensaje() = mensajesEmitidos.last()
  method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)

  //Metodos de indicacion
  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
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

class NaveCombateSigilosa inherits NaveCombate {
  override method estaTranquila() = super() && !estaInvisible  

  override method escapar() {
    self.desplegarMisiles()
    self.ponerseInvisible()
  }

}