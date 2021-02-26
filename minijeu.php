<?php 
include 'header.php';
?>

<?php
// On génère une expression parmis toutes celles qui existent dans la bdd
function randExpression($bdd){
    $maxRanded = maxExpression($bdd)->fetch();
    $randed = random_int(1,intval($maxRanded[0]));
    return($randed);
}

// correspond à l'id de l'expression choisie par la fonction
$chosen = randExpression($bdd);


// retourne la liste des régions dans la bdd
function getRegions($bdd){
    $listeRegions = SelectRegions($bdd);
    return($listeRegions);
}

// si il y en a, on créé un array de régions qui ont été choisies à la partie précédente
// Et on lance la vérification du jeu
if(isset($_GET['idRegion'])){
    $regions = $_GET['idRegion'];
    verifjeu($regions, $_GET['idExpression']);
}

// Là on vérifié si la page a été refresh ou si c'était une validation
// Si c'est une validation (premier cas) alors le mot affiché au milieu reste le même lors de l'affichage de la page
// Sinon, on affiche le mot qui a été choisit aléatoirement
if(isset($_GET['idExpression'])){ 
    $prev_id_expression = $_GET['idExpression'];
    $prev_expression = SelectExpressionParId($prev_id_expression,$bdd)->fetch();
    $expression_affich_nom = $prev_expression['mots'];
} else {
    $new_expression = SelectExpressionParId($chosen,$bdd)->fetch();
    $expression_affich_nom = $new_expression['mots'];
}

function verifJeu($regions, $id_prev_expression, $bdd){
    // On vérifié d'abord que le nombre de régions qui ont été proposées correspond au nombre de régions à qui l'expression correspond
    $region_parId = ListeExpressionParIdExpression($id_prev_expression, $bdd);
    $nb_regionParId = count($region_parId);
    // Si ce n'est pas le cas, pas besoin de faire la vérif
    if($nb_regionParId == $regions){
        foreach($regions as $region){
            // Ici il faut vérifier que les régions qui ont été cochées correspond aux régions de la bdd
            
        }
    } else {
        // défaite
    }
}

?>

    <div class="container">
        <div class="text-center">
            <p class="display-3">Le mini-jeu des expressions</p>
            <?php //var_dump(getRegions($bdd))?>
        </div>
        <div class="row mt-5 justify-content-md-center">    
            <!-- Mot aléatoire -->
            <div class="col-md-4  border border-success pt-4 display-4">
                <p id="mot_alea" class="text-center"><?php echo($expression_affich_nom); ?></p>   
            </div>

            <!-- Bouton de refresh -->
            <div class="col-md-auto p-2 m-4">
                <a style="background-color: #990099; border-color: #990099;" class="btn btn-primary btn-lg" href="minijeu.php"><i class="fas fa-sync-alt"></i></a>
            </div>
        </div>
        <!-- Le form avec les checkbox et les deux boutons -->
        <div class="row mt-5 justify-content-md-center">
            <form class="form display-5" action="minijeu.php" method="GET">
            <input type="text" style="display: none;" value="<?php echo($chosen)?>" name="idExpression">
            <?php 
            foreach(getRegions($bdd) as $region){

                echo("<div class='form-check'>
                    <input type='checkbox' name='idRegion[]' class='form-check-input' value='".$region['id_Region']."'>
                    <label class='form-check-label' for='".$region['id_Region']."'>".$region['nom']."</label>
                </div>");
            }
            
            ?>
                <input style="background-color: #990099; border-color: #990099;" type="submit" class="btn btn-primary mt-5 btn-lg" value="Valider"></button>
                <button style="display: none; background-color: #990099; border-color: #990099;" type="button" class="btn btn-primary mt-5 btn-lg">Rejouer</button>
            </form>
        </div>
    </div>

<?php include 'footer.php' ?>