/******************************************* CREATION DES PROCEDURES STOCKEES *******************************************/
Use BDD_Expression -- utilise la BDD
GO

DROP PROCEDURE listeExpressionGroupeRegion; -- Supprime si elle existe déjà
CREATE PROCEDURE listeExpressionGroupeRegion (p_numGroupe INT, p_numRegion INT) 
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numRegion && num_Region = p_numRegion;
Go

DROP PROCEDURE ajoutExpression; -- Supprime si elle existe déjà
CREATE PROCEDURE ajoutExpression (p_mot varchar(255), p_numGroupe INT, p_numRegion INT) 
    INSERT INTO expression (mot, num_Groupe, num_Region) 
    VALUES (p_mot, p_numGroupe, p_numRegion);
Go

DROP PROCEDURE selectExpressionParId; -- Supprime si elle existe déjà
CREATE PROCEDURE selectExpressionParId (p_id INT) 
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE id_expression = p_id;
Go

DROP PROCEDURE selectGroupeExpression; -- Supprime si elle existe déjà
CREATE PROCEDURE selectGroupeExpression 
    SELECT * 
    FROM expression 
    ORDER BY num_Groupe;
Go

DROP PROCEDURE selectExpressionParGroup; -- Supprime si elle existe déjà
CREATE PROCEDURE selectExpressionParGroup
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe;
Go

DROP PROCEDURE updateExpressionParId; -- Supprime si elle existe déjà
CREATE PROCEDURE updateExpressionParId(p_id INT, p_mots varchar(255), p_numRegion INT, p_numGroupe INT) 
    UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_expression = p_id;
Go
