-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Version du serveur : 10.11.18-MariaDB-0+deb12u1
-- Version de PHP : 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `icingaweb2`
--

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_group`
--

CREATE TABLE `icingaweb_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` int(10) UNSIGNED DEFAULT NULL,
  `ctime` timestamp NULL DEFAULT NULL,
  `mtime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_group_membership`
--

CREATE TABLE `icingaweb_group_membership` (
  `group_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ctime` timestamp NULL DEFAULT NULL,
  `mtime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_rememberme`
--

CREATE TABLE `icingaweb_rememberme` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passphrase` varchar(256) NOT NULL,
  `random_iv` varchar(32) NOT NULL,
  `http_user_agent` text NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `ctime` timestamp NULL DEFAULT NULL,
  `mtime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_schema`
--

CREATE TABLE `icingaweb_schema` (
  `id` int(10) UNSIGNED NOT NULL,
  `version` varchar(64) NOT NULL,
  `timestamp` bigint(20) UNSIGNED NOT NULL,
  `success` enum('n','y') DEFAULT NULL,
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `icingaweb_schema`
--

INSERT INTO `icingaweb_schema` (`id`, `version`, `timestamp`, `success`, `reason`) VALUES
(1, '2.12.0', 1788395617000, 'y', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_user`
--

CREATE TABLE `icingaweb_user` (
  `name` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `password_hash` varbinary(255) NOT NULL,
  `ctime` timestamp NULL DEFAULT NULL,
  `mtime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `icingaweb_user_preference`
--

CREATE TABLE `icingaweb_user_preference` (
  `username` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) NOT NULL,
  `ctime` timestamp NULL DEFAULT NULL,
  `mtime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `icingaweb_group`
--
ALTER TABLE `icingaweb_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_name` (`name`),
  ADD KEY `fk_icingaweb_group_parent_id` (`parent`);

--
-- Index pour la table `icingaweb_group_membership`
--
ALTER TABLE `icingaweb_group_membership`
  ADD PRIMARY KEY (`group_id`,`username`);

--
-- Index pour la table `icingaweb_rememberme`
--
ALTER TABLE `icingaweb_rememberme`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `icingaweb_schema`
--
ALTER TABLE `icingaweb_schema`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_icingaweb_schema_version` (`version`);

--
-- Index pour la table `icingaweb_user`
--
ALTER TABLE `icingaweb_user`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `icingaweb_user_preference`
--
ALTER TABLE `icingaweb_user_preference`
  ADD PRIMARY KEY (`username`,`section`,`name`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `icingaweb_group`
--
ALTER TABLE `icingaweb_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `icingaweb_rememberme`
--
ALTER TABLE `icingaweb_rememberme`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `icingaweb_schema`
--
ALTER TABLE `icingaweb_schema`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `icingaweb_group`
--
ALTER TABLE `icingaweb_group`
  ADD CONSTRAINT `fk_icingaweb_group_parent_id` FOREIGN KEY (`parent`) REFERENCES `icingaweb_group` (`id`);

--
-- Contraintes pour la table `icingaweb_group_membership`
--
ALTER TABLE `icingaweb_group_membership`
  ADD CONSTRAINT `fk_icingaweb_group_membership_icingaweb_group` FOREIGN KEY (`group_id`) REFERENCES `icingaweb_group` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
