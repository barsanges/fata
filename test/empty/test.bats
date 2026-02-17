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
    # Annule les modifications apportées au fichier des questions :
    mv ref-questions-posées.json questions-posées.json
}

@test "'fata list focuses' returns nothing if there is no focus" {
    run fata list focuses
    assert_output ""
}

@test "'fata list periods' returns nothing if there is no focus" {
    run fata list periods
    assert_output ""
}

@test "'fata list keywords' returns nothing if there is no focus" {
    run fata list keywords
    assert_output ""
}

@test "'fata list all' returns nothing if there is no focus" {
    run fata list all
    assert_output ""
}

@test "'fata ask' returns nothing if there is no question to ask" {
    run fata ask
    assert_output "Aucune question à poser !"

    expected=""

    actual=$(jq -r '.[]' questions-posées.json | sort)
    assert_equal "${actual}" "${expected}"
}