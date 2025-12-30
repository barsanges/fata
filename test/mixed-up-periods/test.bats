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

@test "'fata list focuses' fails if the periods are mixed up" {
    run fata list focuses
    assert_output "Erreur : les périodes de sciapodes.md (Période archaïque / Période classique) ne correspondent pas à celles de cynocéphales.md (Période héroïque / Période classique)"
}

@test "'fata list periods' fails if the periods are mixed up" {
    run fata list periods
    assert_output "Erreur : les périodes de sciapodes.md (Période archaïque / Période classique) ne correspondent pas à celles de cynocéphales.md (Période héroïque / Période classique)"
}

@test "'fata list keywords' fails if the periods are mixed up" {
    run fata list keywords
    assert_output "Erreur : les périodes de sciapodes.md (Période archaïque / Période classique) ne correspondent pas à celles de cynocéphales.md (Période héroïque / Période classique)"
}