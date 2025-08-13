# En cas de problème à l'exécution, se référer à :
#     https://github.com/casey/just/issues/2702

check:
    shellcheck src/* --color=always --enable=all --severity=style

get_bats:
    #!/usr/bin/env bash
    if [[ ! -d bats ]]; then
      mkdir -p bats/bats-core
      curl -sL https://github.com/bats-core/bats-core/archive/refs/tags/v1.11.1.tar.gz | tar xz -C bats/bats-core --strip-components 1
      mkdir -p bats/bats-support
      curl -sL https://github.com/bats-core/bats-support/archive/refs/tags/v0.3.0.tar.gz | tar xz -C bats/bats-support --strip-components 1
      mkdir -p bats/bats-assert
      curl -sL https://github.com/bats-core/bats-assert/archive/refs/tags/v2.1.0.tar.gz | tar xz -C bats/bats-assert --strip-components 1
      mkdir -p bats/bats-file
      curl -sL https://github.com/bats-core/bats-file/archive/refs/tags/v0.4.0.tar.gz | tar xz -C bats/bats-file --strip-components 1
    fi

test: get_bats
    bats/bats-core/bin/bats --recursive test
