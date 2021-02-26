/******************************************* CREATION DES PROCEDURES STOCKEES *******************************************/
Use BDD_Expression; -- utilise la BDD

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ajoutExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutExpression` (`p_mot` VARCHAR(255), `p_numGroupe` INT, `p_numRegion` INT)  BEGIN
    DECLARE id INT;
    INSERT INTO expression (mots, num_Groupe) 
    VALUES (p_mot, p_numGroupe);
    SELECT MAX(id_Expression) INTO id FROM expression;
    INSERT INTO region_expression (num_Region, num_Expression)
    Values (p_numRegion, id);
END$$

DROP PROCEDURE IF EXISTS `listeExpressionGroupeRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeExpressionGroupeRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression AS e INNER JOIN region_expression AS re ON e.id_Expression = re.num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `listeRegionParIdExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeRegionParIdExpression` (`p_numExpression` INT)  SELECT num_Region
	FROM region_expression
	Where num_Expression = p_numExpression$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroup`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroup` (`p_numGroupe` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroupEtRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroupEtRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `selectExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParId` (`p_id` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE id_expression = p_id$$

DROP PROCEDURE IF EXISTS `selectExpressionsByExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionsByExpression` (`p_mot` VARCHAR(255))  SELECT mots FROM expression WHERE num_Groupe = ( SELECT num_Groupe FROM expression WHERE mots = p_mot LIMIT 1)$$

DROP PROCEDURE IF EXISTS `selectGroupe`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupe` ()  SELECT *
    FROM groupe 
    ORDER BY mots_Ref$$

DROP PROCEDURE IF EXISTS `selectGroupeExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeExpression` ()  SELECT id_expression, mots, num_Groupe, num_Region
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    ORDER BY num_Groupe$$

DROP PROCEDURE IF EXISTS `selectRegions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectRegions` ()  SELECT id_Region, nom
    FROM region 
    ORDER BY nom$$

DROP PROCEDURE IF EXISTS `updateExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateExpressionParId` (`p_id` INT, `p_mots` VARCHAR(255), `p_numRegion` INT, `p_numGroupe` INT)  UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_Expression = p_id$$

DELIMITER ;

    -- Mis de côté
/*DROP PROCEDURE IF EXISTS updateExpressionParId; -- Supprime si elle existe déjà
DELIMITER |
CREATE PROCEDURE updateExpressionParId(p_id INT, p_mots varchar(255), p_numRegion INT, p_numGroupe INT) 
BEGIN
    UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe 
    WHERE id_expression = p_id;

    UPDATE region_expression
    SET num_Region = p_numRegion
    WHERE num_Expression = p_id;
END |*/

