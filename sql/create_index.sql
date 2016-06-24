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

