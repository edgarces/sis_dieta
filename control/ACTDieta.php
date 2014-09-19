<?php
/**
*@package pXP
*@file gen-ACTDieta.php
*@author  (admin)
*@date 18-09-2014 19:35:16
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDieta extends ACTbase{    
			
	function listarDieta(){
		$this->objParam->defecto('ordenacion','id_dieta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_animal')!=''){
	    	$this->objParam->addFiltro("die.id_animal = ".$this->objParam->getParametro('id_animal'));	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDieta','listarDieta');
		} else{
			$this->objFunc=$this->create('MODDieta');
			
			$this->res=$this->objFunc->listarDieta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDieta(){
		$this->objFunc=$this->create('MODDieta');	
		if($this->objParam->insertar('id_dieta')){
			$this->res=$this->objFunc->insertarDieta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDieta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDieta(){
			$this->objFunc=$this->create('MODDieta');	
		$this->res=$this->objFunc->eliminarDieta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>