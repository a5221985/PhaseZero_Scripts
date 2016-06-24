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
	