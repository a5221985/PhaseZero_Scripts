CREATE SCHEMA IF NOT EXISTS pzv_aftermarket;

set search_path='pzv_aftermarket';

-- Main Tables
CREATE TABLE company
(       
    id BIGSERIAL   PRIMARY KEY NOT NULL,
	name           TEXT NOT NULL,
	type           TEXT,
	logo_url       TEXT,
	favicon_url    TEXT,
	theme          TEXT,
	history        TEXT,
	asset_sync_timestamp bigint,
	created_on     TIMESTAMP,
	modified_on    TIMESTAMP
);
	
CREATE TABLE category 
(
    id BIGSERIAL PRIMARY KEY NOT NULL,
	code        TEXT  NOT NULL,
	name        TEXT NOT NULL,
	parent_id   BIGINT,
	path        TEXT,
	comp_id     BIGINT,
	status INT default 1,
	created_on 	TIMESTAMP,
	modified_on	TIMESTAMP
);
 
CREATE TABLE attribute 
(
    id BIGSERIAL PRIMARY KEY NOT NULL,
	name TEXT NOT NULL,
	comp_id BIGINT,
	searchable boolean,
	sortable boolean,
	ui_order BIGINT,
	data_type TEXT,
	cat_id BIGINT,
	created_on TIMESTAMP,
	modified_on TIMESTAMP
);

CREATE TABLE part
 (
    id BIGSERIAL PRIMARY KEY NOT NULL,
	part_number TEXT,
	detail JSONB NOT NULL,
	comp_id BIGINT,
	status INT default 1,
	created_on TIMESTAMP,
	modified_on TIMESTAMP
);

CREATE TABLE scope_part
 (
	part_number TEXT,
	comp_id     BIGINT
 );


-- stage tables
CREATE TABLE stage_category 
(
  code TEXT NOT NULL,
  name TEXT NOT NULL,
  path TEXT,
  comp_id BIGINT,
  created_on TIMESTAMP,
  modified_on TIMESTAMP
);
 
CREATE TABLE stage_attribute 
(
        name TEXT NOT NULL,
        comp_id BIGINT,
        spec_id TEXT,
        src_order BIGINT,
        searchable boolean,
        sortable boolean,
        ui_order BIGINT,
        data_type TEXT,
        cat_path TEXT,
        created_on TIMESTAMP,
        modified_on TIMESTAMP
 );

CREATE TABLE stage_part
(
        part_number TEXT,
        detail JSONB NOT NULL,
        brand_name TEXT,
        comp_id BIGINT,
        cat_path TEXT,
        attr_exists boolean DEFAULT false,
        img_asset_exists boolean DEFAULT false,
        img_metadata_exists boolean DEFAULT false,
        doc_asset_exists boolean DEFAULT false,
        doc_metadata_exists boolean DEFAULT false,
        vid_asset_exists boolean DEFAULT false,
        vid_metadata_exists boolean DEFAULT false,
        created_on TIMESTAMP,
        modified_on TIMESTAMP
);
  
	
	
--Temp table for Stage post processing
create table temp_part_child (
   part_number text not null,
   child_number text not null,
   child_name text not null
);

CREATE TABLE display_metadata 
(    
	display_metadata_id		BIGINT	NOT NULL,
	obj_type				TEXT NOT NULL,
	obj_display_name  		TEXT,
	obj_id  				BIGINT,	
	created_on 				TIMESTAMP,
	modified_on				TIMESTAMP
);

CREATE TABLE orders
(
	id SERIAL  PRIMARY KEY NOT NULL,
	uuid BIGINT UNIQUE,
	description TEXT,
	from_firstname TEXT,
	from_lastname TEXT,
	from_email TEXT,
	from_phoneNumber TEXT,
	callback_status BOOLEAN,
	to_email TEXT,
	created_on TIMESTAMP,
	modified_on TIMESTAMP
);
 
CREATE TABLE order_parts
(
	id SERIAL PRIMARY KEY NOT NULL,
	part_name TEXT,
	part_img_url TEXT,
	part_category TEXT,
	part_number TEXT,
	quantity BIGINT,
	order_id BIGINT NOT NULL,
	created_on TIMESTAMP,
	modified_on TIMESTAMP
);

CREATE INDEX cat_parent_idx ON category (parent_id);
CREATE INDEX cat_comp_idx ON category (comp_id);

CREATE INDEX part_no_idx ON part (part_number);
CREATE INDEX cat_path_idx ON category (path);

CREATE INDEX disp_mdata_id_idx ON display_metadata (obj_id);
CREATE INDEX disp_mdata_type_idx ON display_metadata (obj_type);

CREATE INDEX scope_part_no_idx ON scope_part (part_number);
CREATE INDEX scope_comp_id_idx ON scope_part (comp_id);

CREATE INDEX stage_cat_comp_idx ON stage_category (comp_id);
CREATE INDEX stage_cat_code_idx ON stage_category (code);

CREATE INDEX stage_part_no_idx ON stage_part (part_number);
CREATE INDEX stage_part_cat_path_idx ON stage_part (cat_path);
CREATE INDEX stage_spec_id_idx ON stage_attribute (spec_id);
CREATE INDEX stage_src_order_idx ON stage_attribute (src_order);
CREATE INDEX stage_cat_path_idx ON stage_category (path);

create index part_child_part_number_idx on temp_part_child (part_number);

ALTER TABLE category
	ADD CONSTRAINT FK_cat_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);
    
ALTER TABLE attribute
	ADD CONSTRAINT FK_attribute_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);
	
ALTER TABLE part
	ADD CONSTRAINT FK_part_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);
	
ALTER TABLE stage_category
	ADD CONSTRAINT FK_stage_cat_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);

ALTER TABLE stage_attribute
	ADD CONSTRAINT FK_stage_attribute_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);

ALTER TABLE stage_part
	ADD CONSTRAINT FK_stage_part_comp_id FOREIGN KEY (comp_id)
    REFERENCES company (id);

ALTER TABLE order_parts
ADD CONSTRAINT FK_orderlist_id FOREIGN KEY (order_id)
REFERENCES orders (id);		
	