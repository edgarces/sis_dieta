CREATE OR REPLACE FUNCTION "dieta"."ft_dieta_nutriente_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_dieta_nutriente_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tdieta_nutriente'
 AUTOR: 		 (admin)
 FECHA:	        18-09-2014 21:17:39
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
	v_id_dieta_nutriente	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_dieta_nutriente_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_DINU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 21:17:39
	***********************************/

	if(p_transaccion='DA_DINU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tdieta_nutriente(
			id_nutriente,
			id_dieta,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
			dieta_max,
			dieta_min,
			porcentaje
          	) values(
			v_parametros.id_nutriente,
			v_parametros.id_dieta,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			null,
			null,
			v_parametros.dieta_max,
    		v_parametros.dieta_min,				
			v_parametros.porcentaje
			
			)RETURNING id_dieta_nutriente into v_id_dieta_nutriente;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta nutriente almacenado(a) con exito (id_dieta_nutriente'||v_id_dieta_nutriente||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta_nutriente',v_id_dieta_nutriente::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_DINU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 21:17:39
	***********************************/

	elsif(p_transaccion='DA_DINU_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tdieta_nutriente set
			id_nutriente = v_parametros.id_nutriente,
			id_dieta = v_parametros.id_dieta,
			porcentaje = v_parametros.porcentaje,
			dieta_max = v_parametros.dieta_max,
			dieta_min = v_parametros.dieta_min,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_dieta_nutriente=v_parametros.id_dieta_nutriente;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta nutriente modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta_nutriente',v_parametros.id_dieta_nutriente::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_DINU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 21:17:39
	***********************************/

	elsif(p_transaccion='DA_DINU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tdieta_nutriente
            where id_dieta_nutriente=v_parametros.id_dieta_nutriente;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta nutriente eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta_nutriente',v_parametros.id_dieta_nutriente::varchar);
              
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
ALTER FUNCTION "dieta"."ft_dieta_nutriente_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
