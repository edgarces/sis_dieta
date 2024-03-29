CREATE OR REPLACE FUNCTION "dieta"."ft_ingrediente_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_ingrediente_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tingrediente'
 AUTOR: 		 (admin)
 FECHA:	        17-09-2014 21:31:18
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
	v_id_ingrediente	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_ingrediente_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_ING_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:18
	***********************************/

	if(p_transaccion='DA_ING_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tingrediente(
			precio,
			estado,
			estado_reg,
			nombre,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.precio,
			v_parametros.estado,
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_ingrediente into v_id_ingrediente;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','ingrediente almacenado(a) con exito (id_ingrediente'||v_id_ingrediente||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ingrediente',v_id_ingrediente::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_ING_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:18
	***********************************/

	elsif(p_transaccion='DA_ING_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tingrediente set
			precio = v_parametros.precio,
			estado = v_parametros.estado,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_ingrediente=v_parametros.id_ingrediente;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','ingrediente modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ingrediente',v_parametros.id_ingrediente::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_ING_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:18
	***********************************/

	elsif(p_transaccion='DA_ING_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tingrediente
            where id_ingrediente=v_parametros.id_ingrediente;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','ingrediente eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ingrediente',v_parametros.id_ingrediente::varchar);
              
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
ALTER FUNCTION "dieta"."ft_ingrediente_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
