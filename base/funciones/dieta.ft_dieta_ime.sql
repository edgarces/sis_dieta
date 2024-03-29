CREATE OR REPLACE FUNCTION "dieta"."ft_dieta_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_dieta_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tdieta'
 AUTOR: 		 (admin)
 FECHA:	        18-09-2014 19:35:16
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
	v_id_dieta	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_dieta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_DIE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:35:16
	***********************************/

	if(p_transaccion='DA_DIE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tdieta(
			id_animal,
			descripcion,
			tipo_dieta,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_animal,
			v_parametros.descripcion,
			v_parametros.tipo_dieta,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_dieta into v_id_dieta;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta almacenado(a) con exito (id_dieta'||v_id_dieta||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta',v_id_dieta::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_DIE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:35:16
	***********************************/

	elsif(p_transaccion='DA_DIE_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tdieta set
			id_animal = v_parametros.id_animal,
			descripcion = v_parametros.descripcion,
			tipo_dieta = v_parametros.tipo_dieta,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_dieta=v_parametros.id_dieta;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta',v_parametros.id_dieta::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_DIE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:35:16
	***********************************/

	elsif(p_transaccion='DA_DIE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tdieta
            where id_dieta=v_parametros.id_dieta;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dieta eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dieta',v_parametros.id_dieta::varchar);
              
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
ALTER FUNCTION "dieta"."ft_dieta_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
