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
		if(invitado.tieneDisfraz()) invitados.add(invitado)
		else throw noTieneDisfrazExc
	}
	method quitarA(invitado){
		invitados.remove(invitado)
	}
	method asistio(unInvitado){
		return invitados.contains(unInvitado)
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
	method generoDisfraz(){
		return disfraz.genero()
	}
	method tieneDisfraz(){
		return !(disfraz == null)
	}
	method conformeCon(unDisfraz){
		var personaConOtroDisfraz = new Persona(disfraz =unDisfraz,edad=edad,idGenero=idGenero,exigencia = exigencia)
		return personaConOtroDisfraz.conformeConDisfraz()
	}
	
	method felicesCambiandoDisfraz(otroInvitado){
		return self.conformeCon(otroInvitado.disfraz())&& otroInvitado.conformeCon(disfraz)
	}
    
    method puedenHacerCambio(invitado){
    	var ambosAsistieron = fiesta.asistio(invitado) && fiesta.asistio(self) 
		var algunoDisconforme = self.disconforme() || invitado.disconforme()
		var quierenCambiarDisfraz = self.felicesCambiandoDisfraz(invitado)
		return ambosAsistieron && algunoDisconforme && quierenCambiarDisfraz
    }
    
	method intercambiarDisfrazCon(invitado){
		if(self.puedenHacerCambio(invitado)){
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

class Genero{
	method puntosComodidad(persona){
		if (persona.generoDisfraz() == self) return self.puntosMismoGenero() 
		else return self.puntosDistintoGenero()
	}
	method puntosMismoGenero(){
		return 20
	}
	method puntosDistintoGenero(){
		return 0
	}
}

object mujer inherits Genero{}

object varon inherits Genero{}

// podria poner aca los valores 20 y 0 y hacer genero clase abstracta, que priorizo?
	
object noAclara inherits Genero{
	override method puntosMismoGenero(){
		return 25
	}
	override method puntosDistintoGenero(){
		return 20
	}
}

//                                           DISFRAZ:

class Disfraz{
	var property nombre = ""
	var property fechaConfeccion //  new Date(dia,mes,anio)
	var property caracteristicas = #{}
	var property gracia // de 1 a 10
	var property genero = mujer // o varon o noAclara... o cualsea??
	
	method puntuacion(persona){
		return caracteristicas.sum( { caracteristica => caracteristica.valor(persona) } )
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
