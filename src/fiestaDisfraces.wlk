object noSeRealizaCambioExc inherits Exception("Ambos se quedaron con su disfraz original"){}
object noTieneDisfrazExc inherits Exception("no puede entrar a la fiesta alguien sin disfraz"){}

//                                          FIESTA:

object fiesta{
	var lugar = "Casa de Tina"
	var property fecha = new Date()
	var property invitados = #{}
	
	method esInolvidable(){
		return invitados.all( { invitado => invitado.conformeConDisfraz() } )
	}
	
	method estaBuena(){
		return invitados.any( { invitado => invitado.conformeConDisfraz() } )
	}
	// se sabe que una fiesta es un bodrio si no esta buena
	
	method mejorDisfrazado(){
		return invitados.max({ invitado => invitado.puntosPorDisfraz() })
	}
	// el mejor disfraz de la fiesta va de la mano con los puntos de comodidad, ya que complementan al disfraz
	
	method cambiarLugar(nuevoLugar){
		lugar = nuevoLugar
	}
	method cambiarFecha(nuevaFecha){
		fecha = nuevaFecha
	}
	method invitarA(invitado){
		if(invitado.disfraz().esDisfraz()) invitados.add(invitado)
		else throw noTieneDisfrazExc
	}
	method quitarA(invitado){
		invitados.remove(invitado)
	}
	method confirmarInvitados(listaInvitados){
		return listaInvitados.all({ invitado => invitados.contains(invitado)})
	}
}

// Originalmente era class, pero tuve que hacer a la fiesta un well known object 
// para saber la fecha de antiguedad en Tobara; pasar por parametro quedaria horrible.
// Encima asumo que cada vez que corra el programa solo me interesa que exista una unica fiesta.

//                                         INVITADOS:

class Persona{
	var property disfraz
	var property edad
	var idGenero // mujer, varon o noAclara
	var exigencia
	
	method cambiarDisfraz(nuevoDisfraz){
		disfraz = nuevoDisfraz
	}
	
	method puntosPorDisfraz(){
		return idGenero.puntosComodidad(self) + disfraz.puntuacion(self)
	}
	
	method cambiarIdGenero(otroGenero){
		idGenero = otroGenero
	}
	
	method conformeConDisfraz(){
		return self.puntosPorDisfraz() > 10
	}
	
	method disconforme(){
		return !self.conformeConDisfraz()
	}
	
	// ESTE PROXIMO METHOD ES BASTANTE FEO, YA SE, PERO NO SE ME OCURRIO COMO HACER PARA EVALUAR 
	// UNA SITUACION HIPOTETICA SIN PRIMERO CAMBIARLA Y DESPUES VOLVERLA A LA NORMALIDAD :'(
	
	method felicesCambiandoDisfraz(otroInvitado){
		var queremosCambiar
		var disfrazAux = disfraz
		
		self.cambiarDisfraz(otroInvitado.disfraz())
		otroInvitado.cambiarDisfraz(disfrazAux)
		var conformeConDisfrazDeOtro = self.conformeConDisfraz()
		var conformeOtroConMiDisfraz = otroInvitado.conformeConDisfraz()
		if (conformeConDisfrazDeOtro && conformeOtroConMiDisfraz){
			queremosCambiar = true
		}else{
			queremosCambiar = false
		}
		otroInvitado.cambiarDisfraz(self.disfraz())
		self.cambiarDisfraz(disfrazAux)
		return queremosCambiar
	}
	
    // este proximo method tambien esta medio hecho un choclo, 
    // pero esta fue la solucion mas expresiva que pude hacer :/
    
	method intercambiarDisfrazCon(invitado){
		
		var involucradosEnTrueque = [self,invitado]
		var ambosAsistieron = fiesta.confirmarInvitados(involucradosEnTrueque)
		var algunoDisconforme = involucradosEnTrueque.any({ involucrado => involucrado.disconforme() })
		var quierenCambiarDisfraz = self.felicesCambiandoDisfraz(invitado)
		
		if(ambosAsistieron && algunoDisconforme && quierenCambiarDisfraz){
			var disfrazAux = disfraz
			
			self.cambiarDisfraz(invitado.disfraz())
		    invitado.cambiarDisfraz(disfrazAux)
		    
		}else{
			throw noSeRealizaCambioExc
		}
		
	}
}

// No dice que las personas se califican en las siguientes personalidades,
// solo que existen este tipo de personas (que no cambian). Asi que creo que 
// se puede instanciar un new Persona: Persona no la hago clase abstracta.

class Caprichoso inherits Persona{
	override method conformeConDisfraz(){
		var cantLetrasNombre = disfraz.nombre().length()
		return super() && cantLetrasNombre.even()
	}
}

// pretenciosos no tiene "ademas", interpreto que no necesita super()

class Pretencioso inherits Persona{
	override method conformeConDisfraz(){
		return fiesta.fecha() - disfraz.fechaConfeccion() < 30
	}
}

class Numerologo inherits Persona{
	override method conformeConDisfraz(){
		return super() && (disfraz.puntuacion(self) == exigencia )
	}
}


//                                        IDENTIDAD DE GENERO:

object mujer{
	method puntosComodidad(persona){
		if (persona.disfraz().genero() == "femenino") return 20
		else return 0
	}
}

object varon{
	method puntosComodidad(persona){
		if (persona.disfraz().genero() == "masculino") return 20
		else return 0
	}
}
	
object noAclara{
	method puntosComodidad(persona){
		if (persona.disfraz().genero() == "neutro") return 25
		else return 20
	}
}

// Creo que esto no es repetir logica, por mas que las lineas sean parecidas...
// Es el mismo dilema que tuve con Crear/Eliminar o Agregar/Sacar en el parcial.


//                                           DISFRAZ:

class Disfraz{
	var property nombre = ""
	var property fechaConfeccion //  new Date(dia,mes,anio)
	var property caracteristicas // []
	var property gracia // de 1 a 10
	var property genero = "femenino" // o "masculino" o "neutro"
	
	method puntuacion(persona){
		return caracteristicas.sum( { caracteristica => caracteristica.valor(persona) } )
	}
	method esDisfraz(){
		return true
	}
}


//well known object noEsDisfraz? que no tiene nada en especifico?
// me hace mucho ruido esto, pero nunca voy a evaluar nada de "ningun disfraz"
// ni el puntaje, ni nada relacionado a la fiesta porque el enunciado avisa que si
// la persona no tiene disfraz no va a asistir a la fiesta... entonces lo dejo asi??
object noEsDisfraz{
	method esDisfraz(){
		return false
	}
}


//                                        CARACTERISTICAS:

object gracioso{
	method valor(persona){
		var nivelGracia = persona.disfraz().gracia()
		if (persona.edad() > 50) return nivelGracia * 3
		else return nivelGracia
	}
}

object tobara{
	method valor(persona){
	var antiguedad = fiesta.fecha() - persona.disfraz().fechaConfeccion()
	if (antiguedad >= 2) return 5
	else return 3
	}
}

class Careta{
	var valorPersonaje
	method valor(persona){
		return valorPersonaje
	}
}

