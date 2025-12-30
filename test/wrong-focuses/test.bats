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

@test "'fata list focuses' fails if there are several focuses within the same file" {
    run fata list focuses
    assert_output "Erreur : le fichier wrong.md doit contenir exactement un focus"
}

@test "'fata list periods' fails if there are several focuses within the same file" {
    run fata list periods
    assert_output "Erreur : le fichier wrong.md doit contenir exactement un focus"
}

@test "'fata list keywords' fails if there are several focuses within the same file" {
    run fata list keywords
    assert_output "Erreur : le fichier wrong.md doit contenir exactement un focus"
}