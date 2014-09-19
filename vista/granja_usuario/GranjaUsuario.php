<?php
/**
*@package pXP
*@file gen-GranjaUsuario.php
*@author  (admin)
*@date 17-09-2014 19:02:44
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GranjaUsuario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.GranjaUsuario.superclass.constructor.call(this,config);
		this.init();
	
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_granja_usuario'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_granja'
			},
			type:'Field',
			form:true 
		},
		{
   			config:{
   				name:'id_usuario',
   				fieldLabel:'Usuario',
   				allowBlank:true,
   				emptyText:'Elija usuario...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Usuario/listarUsuario',
					id: 'id_usuario',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_usuario','desc_person','cuenta'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
   				valueField: 'id_usuario',
   				displayField: 'cuenta',
   				gdisplayField:'desc_persona',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>nnn   <b>{desc_person} <br/> {cuenta} </b></p></div></tpl>',
   				hiddenName: 'id_usuario',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona']);}
   			},
   			//type:'TrigguerCombo',
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'grus.desc_persona',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
       	},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'grus.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'grus.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'grus.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'grus.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'grus.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'granja usuario',
	ActSave:'../../sis_dieta/control/GranjaUsuario/insertarGranjaUsuario',
	ActDel:'../../sis_dieta/control/GranjaUsuario/eliminarGranjaUsuario',
	ActList:'../../sis_dieta/control/GranjaUsuario/listarGranjaUsuario',
	id_store:'id_granja_usuario',
	fields: [
		{name:'id_granja_usuario', type: 'numeric'},
		{name:'id_granja', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_persona', type: 'string'},
		{name:'cuenta', type: 'string'},
		
		
	],
	sortInfo:{
		field: 'id_granja_usuario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	
	
	loadValoresIniciales:function(){
    	Phx.vista.GranjaUsuario.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_granja').setValue(this.maestro.id_granja);
	},
	
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_granja:this.maestro.id_granja};
		this.load({params:{start:0, limit:50}})
		
	},

	
	
	
	
	
	
	}
)
</script>
		
		