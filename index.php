<?php include 'header.php' ?>




    <div class="container">
    <div class="col-lg-12 text-center mt-5">
        <h1>Rechercher une expression régionale</h1>
    </div>
    <!-- Barre de recherche -->
    <div class="col-md-4 offset-md-4 mt-5 border border-success pt-3">
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Search ......" aria-label="Recipient's username">
            <div class="input-group-append">
                <span class="input-group-text"><i class="fa fa-search"></i></span>
            </div>
        </div>
    </div>
    
    <div class="row justify-content-md-center">    
        <!-- Affichage du mot recherché ou générer -->
        <div class="col-md-auto p-2 m-4">
            <h1>Resultat</h1>
        </div>

        <!-- Bouton de refresh -->
        <div class="col-md-auto p-2 m-4">
            <a class="btn btn-primary btn-lg" href="#"><i class="fas fa-sync-alt"></i></a>
        </div>
    </div>

<?php include 'footer.php' ?>