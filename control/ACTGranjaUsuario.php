<?php
/**
*@package pXP
*@file gen-ACTGranjaUsuario.php
*@author  (admin)
*@date 17-09-2014 19:02:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGranjaUsuario extends ACTbase{    
			
	function listarGranjaUsuario(){
		$this->objParam->defecto('ordenacion','id_granja_usuario');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_granja')!=''){
	    	$this->objParam->addFiltro("grus.id_granja = ".$this->objParam->getParametro('id_granja'));	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGranjaUsuario','listarGranjaUsuario');
		} else{
			$this->objFunc=$this->create('MODGranjaUsuario');
			
			$this->res=$this->objFunc->listarGranjaUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGranjaUsuario(){
		$this->objFunc=$this->create('MODGranjaUsuario');	
		if($this->objParam->insertar('id_granja_usuario')){
			$this->res=$this->objFunc->insertarGranjaUsuario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGranjaUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGranjaUsuario(){
			$this->objFunc=$this->create('MODGranjaUsuario');	
		$this->res=$this->objFunc->eliminarGranjaUsuario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>