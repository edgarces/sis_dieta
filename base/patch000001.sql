/***********************************I-SCP-ECR-DIETA-1-16/09/2014****************************************/

  CREATE TABLE dieta.tgranja (
  id_granja SERIAL, 
  nombre VARCHAR(30) NOT NULL, 
  descripcion VARCHAR(200), 
  CONSTRAINT pk_tgranja__id_granja PRIMARY KEY(id_granja)
) INHERITS (pxp.tbase)
WITHOUT OIDS;


CREATE TABLE dieta.tgranja_usuario(
id_granja_usuario serial not null,
id_granja integer NOT NULL,
id_usuario integer NOT NULL,  
CONSTRAINT pk_tgranja_usuario__id_granja_usuario PRIMARY KEY(id_granja_usuario),
CONSTRAINT fk_tgranja_usuario__id_granja FOREIGN KEY (id_granja) REFERENCES dieta.tgranja(id_granja), 
CONSTRAINT fk_tgranja_usuario__id_usuario FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario)
)INHERITS (pxp.tbase)
WITHOUT OIDS;


CREATE TABLE dieta.tnutriente (
id_nutriente SERIAL NOT NULL, 
nombre VARCHaR(30)NOT NULL, 
CONSTRAINT pk_tnutriente__id_nutriente PRIMARY KEY(id_nutriente)
)INHERITS (pxp.tbase)
WITHOUT OIDS;



CREATE TABLE dieta.tingrediente (
id_ingrediente SERIAL NOT NULL,
nombre VARCHAR(30)NOT NULL, 
estado VARCHAR(30)NOT NULL, 
precio NUMERIC(19,3) NOT NULL,
CONSTRAINT pk_tingrediente__id_ingrediente PRIMARY KEY(id_ingrediente)
)INHERITS (pxp.tbase)
WITHOUT OIDS;



CREATE TABLE dieta.tingrediente_nutriente (
id_ingrediente_nutriente SERIAL NOT NULL,
id_ingrediente integer NOT NULL, 
id_nutriente integer NOT NULL,
porcentaje_nutriente integer NOT NULL,
CONSTRAINT pk_tingrediente_nutriente__id_ingrediente_nutriente PRIMARY KEY(id_ingrediente_nutriente),
CONSTRAINT fk_tingrediente_nutriente__id_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES dieta.tingrediente(id_ingrediente),
CONSTRAINT fk_tingrediente_nutriente__id_nutriente FOREIGN KEY (id_nutriente) REFERENCES dieta.tnutriente(id_nutriente)
)INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-ECR-DIETA-1-16/09/2014****************************************/

/***********************************I-SCP-ECR-DIETA-2-18/09/2014****************************************/

CREATE TABLE dieta.tanimal (
id_animal SERIAL NOT NULL,  
raza VARCHAR(50)NOT NULL,
tip_raza VARCHAR(50),
edad INTEGER NOT NULL,
descripcion varchar(200), 
CONSTRAINT pk_tanimal__id_animal PRIMARY KEY(id_animal) 
)INHERITS (pxp.tbase)
WITHOUT OIDS;



CREATE TABLE dieta.tdieta (
id_dieta SERIAL NOT NULL,
id_animal INTEGER NOT NULL, 
tipo_dieta VARCHAR(30)NOT NULL,
descripcion varchar(200),  
CONSTRAINT pk_tdieta__id_dieta PRIMARY KEY(id_dieta),
CONSTRAINT fk_tdieta__id_animal FOREIGN KEY (id_animal) REFERENCES dieta.tanimal(id_animal)
)INHERITS (pxp.tbase)
WITHOUT OIDS;



CREATE TABLE dieta.tdieta_nutriente (
id_dieta_nutriente serial not null,
id_nutriente integer not null, 
id_dieta integer not NULL,
CONSTRAINT pk_tdieta_nutriente__id_dieta_nutriente PRIMARY KEY(id_dieta_nutriente),
CONSTRAINT fk_tdieta_nutriente__id_nutriente FOREIGN KEY (id_nutriente) REFERENCES dieta.tnutriente(id_nutriente),
CONSTRAINT fk_tdieta_nutriente__id_dieta FOREIGN KEY (id_dieta) REFERENCES dieta.tdieta(id_dieta)
)INHERITS (pxp.tbase)
WITHOUT OIDS;




ALTER TABLE dieta.tdieta_nutriente
  ADD COLUMN dieta_max NUMERIC(19,3);

ALTER TABLE dieta.tdieta_nutriente
  ADD COLUMN dieta_min NUMERIC(19,3);
  
ALTER TABLE dieta.tdieta_nutriente
  ADD COLUMN porcentaje INTEGER;



/***********************************F-SCP-ECR-DIETA-2-18/09/2014****************************************/
