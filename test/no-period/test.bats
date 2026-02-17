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

@test "'fata list focuses' returns every focus in the directory" {
    run fata list focuses
    assert_output "Les acéphales"
}

@test "'fata list periods' returns nothing if there is no period in the directory" {
    run fata list periods
    assert_output ""
}

@test "'fata list keywords' returns every keyword in the directory" {
    run fata list keywords
    assert_output "temple d’Apollon"
}

@test "'fata list all' returns a table associating focuses, periods and keywords" {
    run fata list all
    assert_output "  Focus           Chapeau
  --------------- ------------------
  Les acéphales   temple d'Apollon"
}

@test "'fata ask' returns a question which has not been asked already" {
    run fata ask
    assert_output "L'histoire de 'Les acéphales' est-elle traversée par des dilemmes fondamentaux ? Si oui, lesquels ?"

    expected="L'histoire de 'Les acéphales' est-elle traversée par des dilemmes fondamentaux ? Si oui, lesquels ?
Quels mythes entourent la fondation de 'Les acéphales' ?"

    actual=$(jq -r '.[]' questions-posées.json | sort)
    assert_equal "${actual}" "${expected}"
}