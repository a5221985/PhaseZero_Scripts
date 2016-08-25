EXTENSION = scripts
EXTENSION_VERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\\([^']*\\)'/\\1/")

SCRIPT_EXTENSION = .sql 

sql/$(EXTENSION)--$(EXTENSION_VERSION)$(SCRIPT_EXTENSION): sql/create_table_ddl.sql sql/create_index.sql sql/create_constraint.sql
	cat $^ > $@

DATA = sql/$(EXTENSION)--$(EXTENSION_VERSION)$(SCRIPT_EXTENSION)

PG_CONFIG = /usr/pgsql-9.5/bin/pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
