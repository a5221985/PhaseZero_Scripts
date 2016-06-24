EXTENSION = scripts
EXTENSION_VERSION = 1.0
TYPE = .sql 

sql/$(EXTENSION)--$(EXTENSION_VERSION)$(TYPE): sql/create_table_ddl.sql sql/create_index.sql sql/create_constraint.sql
	cat $^ > $@

DATA = sql/$(EXTENSION)--$(EXTENSION_VERSION)$(TYPE)

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
