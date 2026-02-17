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
    assert_output "L’empire des cyclopes
Les cynocéphales
La république des sciapodes"
}

@test "'fata list periods' returns every period in the directory" {
    run fata list periods
    assert_output "Période archaïque
Période classique"
}

@test "'fata list keywords' returns every keyword in the directory" {
    run fata list keywords
    assert_output "Akhilleus
Hélios
Hèphaistos
illustre Boiteux des deux pieds
Okéanos
Pèléide"
}

@test "'fata list all' returns a table associating focuses, periods and keywords" {
    run fata list all
    assert_output "  Focus                         Chapeau           Période archaïque                             Période classique
  ----------------------------- ----------------- --------------------------------------------- --------------------------------------------------------
  L'empire des cyclopes         Hélios, Okéanos                                                 Hèphaistos
  Les cynocéphales                                Hèphaistos, illustre Boiteux des deux pieds   illustre Boiteux des deux pieds
  La république des sciapodes   Hèphaistos        Pèléide                                       Akhilleus, Hèphaistos, illustre Boiteux des deux pieds"
}

@test "'fata ask' asks a new question" {
    run fata ask
    run fata ask
    run fata ask
    run fata ask
    run fata ask
    assert_success

    expected="Pendant 'Période archaïque', le pouvoir dans 'La république des sciapodes' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', le pouvoir dans 'Les cynocéphales' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', le pouvoir dans 'L’empire des cyclopes' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', y a-t-il des sociétés dominantes et des sociétés marginalisées ?
Pendant 'Période classique', le pouvoir dans 'La république des sciapodes' est-il centralisé ou fragmenté ?
Pendant 'Période classique', le pouvoir dans 'Les cynocéphales' est-il centralisé ou fragmenté ?
Pendant 'Période classique', le pouvoir dans 'L’empire des cyclopes' est-il centralisé ou fragmenté ?
Pendant 'Période classique', y a-t-il des sociétés dominantes et des sociétés marginalisées ?"

    actual=$(jq -r '.[]' questions-posées.json | sort)
    assert_equal "${actual}" "${expected}"
}

@test "'fata ask' fails if there is no question to ask" {
    run fata ask
    run fata ask
    run fata ask
    run fata ask
    run fata ask
    run fata ask
    assert_failure

    expected="Pendant 'Période archaïque', le pouvoir dans 'La république des sciapodes' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', le pouvoir dans 'Les cynocéphales' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', le pouvoir dans 'L’empire des cyclopes' est-il centralisé ou fragmenté ?
Pendant 'Période archaïque', y a-t-il des sociétés dominantes et des sociétés marginalisées ?
Pendant 'Période classique', le pouvoir dans 'La république des sciapodes' est-il centralisé ou fragmenté ?
Pendant 'Période classique', le pouvoir dans 'Les cynocéphales' est-il centralisé ou fragmenté ?
Pendant 'Période classique', le pouvoir dans 'L’empire des cyclopes' est-il centralisé ou fragmenté ?
Pendant 'Période classique', y a-t-il des sociétés dominantes et des sociétés marginalisées ?"

    actual=$(jq -r '.[]' questions-posées.json | sort)
    assert_equal "${actual}" "${expected}"
}