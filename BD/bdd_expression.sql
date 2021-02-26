-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 26 fév. 2021 à 05:23
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdd_expression`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutExpression` (`p_mot` VARCHAR(255), `p_numGroupe` INT, `p_numRegion` INT)  BEGIN
    DECLARE id INT;
    INSERT INTO expression (mots, num_Groupe) 
    VALUES (p_mot, p_numGroupe);
    SELECT MAX(id_Expression) INTO id FROM expression;
    INSERT INTO region_expression (num_Region, num_Expression)
    Values (p_numRegion, id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listeExpressionGroupeRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression AS e INNER JOIN region_expression AS re ON e.id_Expression = re.num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listeRegionParIdExpression` (`p_numExpression` INT)  SELECT num_Region
	FROM region_expression
	Where num_Expression = p_numExpression$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroup` (`p_numGroupe` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroupEtRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParId` (`p_id` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE id_expression = p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionsByExpression` (`p_mot` VARCHAR(255))  SELECT mots FROM expression WHERE num_Groupe = ( SELECT num_Groupe FROM expression WHERE mots = p_mot LIMIT 1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionsWithGroupe` (IN `p_numGroupe` INT)  SELECT mots from expression where num_Groupe = p_numGroupe && id_Expression 
    IN (SELECT num_Expression FROM region_expression)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupe` ()  SELECT *
    FROM groupe 
    ORDER BY mots_Ref$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeExpression` ()  SELECT id_expression, mots, num_Groupe, num_Region
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    ORDER BY num_Groupe$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeWithExpression` (IN `p_mot` VARCHAR(255))  SELECT num_Groupe from expression where mots = p_mot$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectRegions` ()  SELECT id_Region, nom
    FROM region 
    ORDER BY nom$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectRegionsByExpression` (IN `p_mot` VARCHAR(255))  SELECT region_expression.num_Region
    FROM region_expression 
    INNER JOIN expression ON region_expression.num_Expression=expression.id_Expression
    WHERE expression.mots = p_mot$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateExpressionParId` (`p_id` INT, `p_mots` VARCHAR(255), `p_numRegion` INT, `p_numGroupe` INT)  UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_Expression = p_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `expression`
--

CREATE TABLE `expression` (
  `id_Expression` int(11) NOT NULL,
  `mots` varchar(255) COLLATE latin1_bin NOT NULL,
  `num_Groupe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `expression`
--

INSERT INTO `expression` (`id_Expression`, `mots`, `num_Groupe`) VALUES
(1, 'Serpillère', 1),
(2, 'toiles', 1),
(3, 'Wassingue', 1),
(4, 'Piéce', 1),
(5, 'Petit pain au chocolat', 2),
(6, 'Pain au chocolat', 2),
(7, 'Chocolatine', 2),
(8, 'Crayon de bois', 3),
(9, 'Crayon à papier', 3),
(10, 'Crayon gris', 3),
(11, 'Crayon de papier', 3),
(12, 'Pelle', 4),
(13, 'Ramasse-bourrier', 4),
(14, 'Pelle-à-cheni', 4),
(15, 'Pain aux raisins', 5),
(16, 'Escargot', 5),
(17, 'Kebab', 6),
(18, 'Grec', 6),
(19, 'Döner', 6),
(20, 'Barrer', 7),
(21, 'Clencher', 7),
(22, 'Fermer à clef', 7),
(23, 'Ducasse', 8),
(24, 'Fête', 8),
(25, 'Fest-noz', 8),
(26, 'Frairie', 8),
(27, 'Vogue', 8),
(28, 'Fête votive', 8),
(29, 'Galette des rois', 9),
(30, 'Gâteau des rois', 9);

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `id_Groupe` int(11) NOT NULL,
  `mots_Ref` varchar(255) COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id_Groupe`, `mots_Ref`) VALUES
(1, 'Serpillère'),
(2, 'Pain au chocolat'),
(3, 'Crayon de bois'),
(4, 'Ramasse-bourrier'),
(5, 'Pain aux raisins'),
(6, 'Kebab'),
(7, 'Fermer à clef'),
(8, 'Fête'),
(9, 'Galette des rois');

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `id_Region` int(11) NOT NULL,
  `nom` varchar(255) COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`id_Region`, `nom`) VALUES
(1, 'Hauts-de-France'),
(2, 'Normandie'),
(3, 'Bretagne'),
(4, 'Pays de la Loire'),
(5, 'Centre'),
(6, 'Ile de France'),
(7, 'Grand-Est'),
(8, 'Bourgogne Franche-Compté'),
(9, 'Nouvelle Aquitaine'),
(10, 'Auvergne-Rhône Alpes'),
(11, 'Occitanie'),
(12, 'Provence-Alpes-Cote-d-Azur'),
(13, 'Corse');

-- --------------------------------------------------------

--
-- Structure de la table `region_expression`
--

CREATE TABLE `region_expression` (
  `num_Region` int(11) NOT NULL,
  `num_Expression` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `region_expression`
--

INSERT INTO `region_expression` (`num_Region`, `num_Expression`) VALUES
(1, 1),
(1, 5),
(1, 8),
(1, 12),
(1, 15),
(1, 17),
(1, 20),
(1, 23),
(1, 29),
(2, 2),
(2, 6),
(2, 9),
(2, 12),
(2, 15),
(2, 17),
(2, 21),
(2, 24),
(2, 29),
(3, 1),
(3, 6),
(3, 10),
(3, 12),
(3, 15),
(3, 17),
(3, 22),
(3, 25),
(3, 29),
(4, 1),
(4, 6),
(4, 8),
(4, 13),
(4, 15),
(4, 17),
(4, 20),
(4, 24),
(4, 29),
(5, 1),
(5, 6),
(5, 11),
(5, 12),
(5, 15),
(5, 17),
(5, 22),
(5, 24),
(5, 29),
(6, 1),
(6, 6),
(6, 11),
(6, 12),
(6, 15),
(6, 18),
(6, 22),
(6, 24),
(6, 29),
(7, 1),
(7, 6),
(7, 11),
(7, 12),
(7, 16),
(7, 19),
(7, 21),
(7, 24),
(7, 29),
(8, 1),
(8, 6),
(8, 11),
(8, 14),
(8, 15),
(8, 17),
(8, 22),
(8, 24),
(8, 29),
(9, 1),
(9, 7),
(9, 9),
(9, 12),
(9, 15),
(9, 17),
(9, 22),
(9, 26),
(9, 30),
(10, 1),
(10, 6),
(10, 9),
(10, 12),
(10, 15),
(10, 17),
(10, 22),
(10, 27),
(10, 29),
(11, 1),
(11, 7),
(11, 9),
(11, 12),
(11, 15),
(11, 17),
(11, 22),
(11, 28),
(11, 30),
(12, 4),
(12, 6),
(12, 10),
(12, 12),
(12, 15),
(12, 17),
(12, 22),
(12, 28),
(12, 30),
(13, 1),
(13, 6),
(13, 9),
(13, 12),
(13, 15),
(13, 17),
(13, 22),
(13, 24),
(13, 30);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `expression`
--
ALTER TABLE `expression`
  ADD PRIMARY KEY (`id_Expression`),
  ADD KEY `fk_numGroup_Groupe_idGroup` (`num_Groupe`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id_Groupe`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id_Region`);

--
-- Index pour la table `region_expression`
--
ALTER TABLE `region_expression`
  ADD PRIMARY KEY (`num_Region`,`num_Expression`),
  ADD KEY `FK_numExpression_Expression_idExpression` (`num_Expression`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `expression`
--
ALTER TABLE `expression`
  MODIFY `id_Expression` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id_Groupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
  MODIFY `id_Region` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `expression`
--
ALTER TABLE `expression`
  ADD CONSTRAINT `fk_numGroup_Groupe_idGroup` FOREIGN KEY (`num_Groupe`) REFERENCES `groupe` (`id_Groupe`);

--
-- Contraintes pour la table `region_expression`
--
ALTER TABLE `region_expression`
  ADD CONSTRAINT `FK_numExpression_Expression_idExpression` FOREIGN KEY (`num_Expression`) REFERENCES `expression` (`id_Expression`),
  ADD CONSTRAINT `FK_numRegion_Region_idREgion` FOREIGN KEY (`num_Region`) REFERENCES `region` (`id_Region`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
