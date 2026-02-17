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

@test "'fata' display the help text if no argument is given" {
    run fata
    assert_output "Fata 0.0.1

Commandes :
    fata list (periods|focuses|keywords|all)
        Liste les périodes, les focus ou les mots-clefs actuellement définis
        dans le projet, ou tout cela ensemble dans un tableau.
    fata ask
        Pose une question au hasard à partir du fichier 'banque.json'.
    fata help
        Affiche ce texte.
    fata version
        Affiche la version utilisée.

https://github.com/barsanges/fata"
}

@test "'fata' fails if it is given a wrong argument" {
    run fata tsil
    assert_output "Commande inconnue 'tsil'
Tapez 'fata help' pour voir la liste des commandes disponibles"
    assert_failure
}

@test "'fata list' fails if it misses an argument" {
    run fata list
    assert_output "Vous devez fournir un argument à 'fata list' : 'fata list focuses', 'fata list periods', 'fata list keywords' ou 'fata list all'"
    assert_failure
}

@test "'fata list' fails if it is given a wrong argument" {
    run fata list sesucof
    assert_output "Argument inconnu 'sesucof'
Les commandes admissibles sont 'fata list focuses', 'fata list periods', 'fata list keywords' ou 'fata list all'"
    assert_failure
}