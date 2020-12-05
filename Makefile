
VAULTS = $(patsubst %/vault_open.yml,%/vault.yml, $(shell find . -type f -name 'vault_open.yml'))
VAULTS_OPEN = $(patsubst %/vault.yml,%/vault_open.yml, $(shell find . -type f -name 'vault.yml'))


encrypt: $(VAULTS)

decrypt: $(VAULTS_OPEN)

%/vault_open.yml: %/vault.yml
	@if [ -f $@ ]]; then cp $@ $@.bak; fi
	ansible-vault decrypt --output=$@ $<
	@if [ -f $@.bak ]]; then diff -Naur $@ $@.bak > $@.patch || true; fi
	@if [ ! -s $@.patch ]; then rm -f $@.patch $@.bak; fi

%/vault.yml: %/vault_open.yml
	ansible-vault encrypt --output=$@ $<
