object knightRider {
	var property peso = 500
	var property peligrosidad = 500
}

object bumblebee {
	var property peso = 800
	var property peligrosidad = 15
	
	method cambioForma(forma){
		peligrosidad=forma.peligro()
	}
}

object auto{
		method peligro() = 15
}
	
object robot{
		method peligro() = 30	
}

object ladrillos {
	var property peligrosidad = 2
	var cantLadrillos = 0
	
	method cantLadrillos(cantidad){
		cantLadrillos=cantLadrillos+cantidad
		return cantLadrillos
	}
	method peso(){
		return cantLadrillos*2
	}
}

object camion{
	var property cargas=[]
	var property cargaMax = 1000
	
	method cargar(cosa){
		if (self.puedeCargar(cosa)){
		cargas.add(cosa)}
	}
	method descargar(cosa){
		cargas.remove(cosa)
	}
	method cargaActual(){
		return cargas.sum({carga=>carga.peso()})
	}
	method cargaDisponible(){
		return cargaMax-self.cargaActual()
	}
	method puedeCargar(cosa){
		return (self.cargaActual()+cosa.peso())<=cargaMax
	}
	method maxPeligrosidad(){
		return cargas.max{carga=>carga.peligrosidad()}
	}
	method puedeCircular(limite){
		return cargas.all{carga=>carga.peligrosidad()<=limite}
	}
}

object motoneta{
	var property cargas=[]
	var property cargaMax = 100
	
	method cargar(cosa){
		if (self.puedeCargar(cosa)){
		cargas.add(cosa)}
	}
	method cargaActual(){
		return cargas.sum({carga=>carga.peso()})
	}
	method cargaDisponible(){
		return cargaMax-self.cargaActual()
	}
	method puedeCargar(cosa){
		return (cosa.peligrosidad()<=5) and ((self.cargaActual()+cosa.peso())<=cargaMax)
	}
}

object contenedor{
	var property cargas=[]
	var property peligrosidad = 0
	const pesoPropio=100
	
	method cargar(cosa){
		cargas.add(cosa)
		peligrosidad=(cargas.max{carga=>carga.peligrosidad()}).peligrosidad()
	}
	method peso(){
		return pesoPropio+cargas.sum{carga=>carga.peso()}
	}
}

object embalaje{
	var cosaEnvuelta
	
	method envolver(cosa){
		cosaEnvuelta=cosa
	}
	method peso(){
		return cosaEnvuelta.peso()
	}
	method peligrosidad(){
		return cosaEnvuelta.peligrosidad()/2
	}
}

object deposito{
	var property cargasDeposito=[]
	
	method recibir(cosa){
		cargasDeposito.addAll(cosa)
	}
	method llenar(transporte){
		cargasDeposito.forEach{ cosa => transporte.cargar(cosa) }
		cargasDeposito.clear()
	}
}
