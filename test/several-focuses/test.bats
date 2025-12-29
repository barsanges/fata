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
}

@test "'fata list focuses' returns every focus in the directory" {
    run fata list focuses
    assert_output "L’empire des cyclopes
Les cynocéphales
La république des sciapodes"
}

@test "'fata list periods' returns every period in the directory" {
    run fata list periods
    assert_output "Période archaïque
Période classique"
}