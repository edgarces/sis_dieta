<?php
/**
*@package pXP
*@file gen-ACTDietaNutriente.php
*@author  (admin)
*@date 18-09-2014 21:17:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDietaNutriente extends ACTbase{    
			
	function listarDietaNutriente(){
		$this->objParam->defecto('ordenacion','id_dieta_nutriente');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_dieta')!=''){
	    	$this->objParam->addFiltro("dinu.id_dieta = ".$this->objParam->getParametro('id_dieta'));	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDietaNutriente','listarDietaNutriente');
		} else{
			$this->objFunc=$this->create('MODDietaNutriente');
			
			$this->res=$this->objFunc->listarDietaNutriente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDietaNutriente(){
		$this->objFunc=$this->create('MODDietaNutriente');	
		if($this->objParam->insertar('id_dieta_nutriente')){
			$this->res=$this->objFunc->insertarDietaNutriente($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDietaNutriente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDietaNutriente(){
			$this->objFunc=$this->create('MODDietaNutriente');	
		$this->res=$this->objFunc->eliminarDietaNutriente($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>