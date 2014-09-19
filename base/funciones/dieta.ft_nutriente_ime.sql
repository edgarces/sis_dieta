CREATE OR REPLACE FUNCTION "dieta"."ft_nutriente_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_nutriente_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tnutriente'
 AUTOR: 		 (admin)
 FECHA:	        17-09-2014 21:31:22
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_nutriente	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_nutriente_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_NUT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:22
	***********************************/

	if(p_transaccion='DA_NUT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tnutriente(
			estado_reg,
			nombre,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_nutriente into v_id_nutriente;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','nutriente almacenado(a) con exito (id_nutriente'||v_id_nutriente||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nutriente',v_id_nutriente::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_NUT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:22
	***********************************/

	elsif(p_transaccion='DA_NUT_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tnutriente set
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_nutriente=v_parametros.id_nutriente;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','nutriente modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nutriente',v_parametros.id_nutriente::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_NUT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:22
	***********************************/

	elsif(p_transaccion='DA_NUT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tnutriente
            where id_nutriente=v_parametros.id_nutriente;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','nutriente eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nutriente',v_parametros.id_nutriente::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "dieta"."ft_nutriente_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
