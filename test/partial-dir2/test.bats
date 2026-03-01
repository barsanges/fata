setup() {
    load '../../bats/bats-support/load'
    load '../../bats/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( dirname "$BATS_TEST_FILENAME" )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../../src:$PATH"
    cd "$DIR"

# Sauvegarde le fichier des questions :
    cp questions-posées.json ref-questions-posées.json
}

teardown() {
    rm -f banque.json
    # Annule les modifications apportées au fichier des questions :
    mv ref-questions-posées.json questions-posées.json
}

@test "'fata list' fails in a non-Fata directory" {
    run fata list keywords
    assert_failure
}

@test "'fata init' turns the directory into a Fata directory" {
    run fata init
    assert [ -e banque.json ]
    assert [ -e questions-posées.json ]
}

@test "'fata list' succeeds if the directory has been turned into a Fata directory" {
    run fata init
    run fata list focuses
    assert_output "Narragonie"
}

@test "'fata ask' succeeds if the directory has been turned into a Fata directory" {
    run fata init

    expected=0
    actual=$(jq -r '.[]' questions-posées.json | wc -l	)
    assert_equal "${actual}" "${expected}"

    run fata ask
    expected=1
    actual=$(jq -r '.[]' questions-posées.json | wc -l)
    assert_equal "${actual}" "${expected}"
}