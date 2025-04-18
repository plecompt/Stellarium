#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------

CREATE DATABASE stellarium;
USE stellarium;

#------------------------------------------------------------
# Table: galaxy
#------------------------------------------------------------

CREATE TABLE galaxy(
        galaxy_id   Int  AUTO_INCREMENT  NOT NULL ,
        galaxy_size Int NOT NULL ,
        galaxy_name Varchar (50) NOT NULL ,
        galaxy_desc Varchar (255) NOT NULL,
        galaxy_age Int NOT NULL
    ,CONSTRAINT galaxy_PK PRIMARY KEY (galaxy_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: user
#------------------------------------------------------------

CREATE TABLE user(
        user_id               Int  AUTO_INCREMENT  NOT NULL ,
        user_login            Varchar (50) NOT NULL UNIQUE /* Doit être unique et valide  */,
        user_password         Varchar (128) NOT NULL /* Doit être valide et hashé  */,
        user_email            Varchar (100) NOT NULL UNIQUE /* Doit être unique et valide */,
        user_active           Boolean NOT NULL DEFAULT TRUE /* Valeur par défaut TRUE, indique si le compte de l'utilisateur est actif */,
        user_role             ENUM('admin', 'member') NOT NULL DEFAULT 'member' /* Assigne le role user par defaut */, 
        user_last_login       Datetime,
        user_date_inscription Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP /* Par default, utilise current_timestamp */
    ,CONSTRAINT user_PK PRIMARY KEY (user_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: star
#------------------------------------------------------------

CREATE TABLE star(
        star_id           Int  AUTO_INCREMENT  NOT NULL ,
        star_desc         Varchar (255) ,
        star_name         Varchar (50) NOT NULL ,
        star_type ENUM('naine_brune', 'naine_rouge', 'naine_jaune', 'naine_blanche', 'géante_rouge', 'géante_bleue','supergéante_rouge', 'supergéante_bleue',
    'hypergéante', 'étoile_à_neutrons', 'pulsar', 'variable', 'binaire', 'ternaire') NOT NULL  ,
        star_gravity      Float NOT NULL CHECK (star_gravity >= 0) /* Doit être supérieur ou égal à 0 */  ,
        star_surface_temp Float NOT NULL CHECK (star_surface_temp >= -273.15) /* Doit être supérieur ou égal à -273.15°C */  ,
        star_diameter     Int NOT NULL CHECK (star_diameter >= 0) /* Doit être supérieur ou égal à 0 */  ,
        star_mass         BigInt NOT NULL CHECK (star_mass >= 0) /* Doit être supérieur ou égal à 0 */  ,
        star_luminosity   Int NOT NULL CHECK (star_luminosity >= 0) /* Doit être supérieur ou égal à 0 */  ,
        star_initial_x    Int NOT NULL ,
        star_initial_y    Int NOT NULL ,
        star_initial_z    Int NOT NULL ,
        galaxy_id         Int NOT NULL ,
        user_id           Int NOT NULL
    ,CONSTRAINT star_PK PRIMARY KEY (star_id)

    ,CONSTRAINT star_galaxy_FK FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
    ,CONSTRAINT star_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: planet
#------------------------------------------------------------

CREATE TABLE planet(
        planet_id                  Int  AUTO_INCREMENT  NOT NULL ,
        planet_desc                Varchar (255) ,
        planet_name                Varchar (50) NOT NULL ,
        planet_type ENUM('tellurique', 'gazeuse', 'glace', 'super-terre', 'sous-neptunien', 'naine', 'lave', 'carbone', 'ocean') NOT NULL ,
        planet_gravity             Float NOT NULL CHECK (planet_gravity >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_surface_temp        Float NOT NULL CHECK (planet_surface_temp >= -273.15) /* Doit être supérieur ou égal à -273.15°C */  ,
        planet_orbital_longitude   Float NOT NULL CHECK (planet_orbital_longitude >= 0 AND planet_orbital_longitude <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        planet_eccentricity        Float NOT NULL CHECK (planet_eccentricity >= 0 AND planet_eccentricity <= 1) /* Doit etre compris entre 0 et 1 */ ,
        planet_apogee              Int NOT NULL CHECK (planet_apogee >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_perigee             Int NOT NULL CHECK (planet_perigee >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_orbital_inclination Int NOT NULL CHECK (planet_orbital_inclination >= 0 AND planet_orbital_inclination <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        planet_average_distance    BigInt NOT NULL CHECK (planet_average_distance >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_orbital_period      Int NOT NULL CHECK (planet_orbital_period >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_inclination_angle   Int NOT NULL CHECK (planet_inclination_angle >= 0 AND planet_inclination_angle <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        planet_rotation_period     Int NOT NULL CHECK (planet_rotation_period >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_mass                BigInt NOT NULL CHECK (planet_mass >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_diameter            Int NOT NULL CHECK (planet_diameter >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_rings               Int NOT NULL CHECK (planet_rings >= 0) /* Doit être supérieur ou égal à 0 */  ,
        planet_initial_x           Int NOT NULL ,
        planet_initial_y           Int NOT NULL ,
        planet_initial_z           Int NOT NULL ,
        star_id                    Int NOT NULL ,
        user_id                    Int NOT NULL
    ,CONSTRAINT planet_PK PRIMARY KEY (planet_id)

    ,CONSTRAINT planet_star_FK FOREIGN KEY (star_id) REFERENCES star(star_id)
    ,CONSTRAINT planet_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)

    ,CONSTRAINT planet_check_perigee_apogee CHECK (planet_perigee <= planet_apogee)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: moon
#------------------------------------------------------------

CREATE TABLE moon(
        moon_id                  Int  AUTO_INCREMENT  NOT NULL ,
        moon_desc                Varchar (255) ,
        moon_name                Varchar (50) NOT NULL ,
        moon_type ENUM('rocheuse', 'glacée', 'mixte', 'primitive', 'régulière', 'irrégulière', 'troyen', 'coorbitale') NOT NULL  ,
        moon_gravity             Float NOT NULL CHECK (moon_gravity >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_surface_temp        Float NOT NULL CHECK (moon_surface_temp >= -273.15) /* Doit être supérieur ou égal à -273.15°C */  ,
        moon_orbital_longitude   Float NOT NULL CHECK (moon_orbital_longitude >= 0 AND moon_orbital_longitude <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        moon_eccentricity        Float NOT NULL CHECK (moon_eccentricity >= 0 AND moon_eccentricity <= 1) /* Doit etre compris entre 0 et 1 */ ,
        moon_apogee              Int NOT NULL CHECK (moon_apogee >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_perigee             Int NOT NULL CHECK (moon_perigee >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_orbital_inclination Int NOT NULL CHECK (moon_orbital_inclination >= 0 AND moon_orbital_inclination <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        moon_average_distance    BigInt NOT NULL CHECK (moon_average_distance >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_orbital_period      Int NOT NULL CHECK (moon_orbital_period >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_inclination_angle   Int NOT NULL CHECK (moon_inclination_angle >= 0 AND moon_inclination_angle <= 360) /* Angle doit être compris entre 0 et 360°*/  ,
        moon_rotation_period     Int NOT NULL CHECK (moon_rotation_period >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_mass                BigInt NOT NULL CHECK (moon_mass >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_diameter            Int NOT NULL CHECK (moon_diameter >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_rings               Int NOT NULL CHECK (moon_rings >= 0) /* Doit être supérieur ou égal à 0 */  ,
        moon_initial_x           Int NOT NULL ,
        moon_initial_y           Int NOT NULL ,
        moon_initial_z           Int NOT NULL ,
        planet_id                Int NOT NULL ,
        user_id                  Int NOT NULL
    ,CONSTRAINT moon_PK PRIMARY KEY (moon_id)

    ,CONSTRAINT moon_planet_FK FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
    ,CONSTRAINT moon_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)

    ,CONSTRAINT moon_check_perigee_apogee CHECK (moon_perigee <= moon_apogee)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: liker_star
#------------------------------------------------------------

CREATE TABLE liker_star(
        star_id         Int NOT NULL ,
        user_id         Int NOT NULL ,
        liker_star_date Datetime NOT NULL
    ,CONSTRAINT liker_star_PK PRIMARY KEY (star_id,user_id)

    ,CONSTRAINT liker_star_star_FK FOREIGN KEY (star_id) REFERENCES star(star_id)
    ,CONSTRAINT liker_star_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: liker_planet
#------------------------------------------------------------

CREATE TABLE liker_planet(
        planet_id         Int NOT NULL ,
        user_id           Int NOT NULL ,
        liker_planet_date Datetime NOT NULL
    ,CONSTRAINT liker_planet_PK PRIMARY KEY (planet_id,user_id)

    ,CONSTRAINT liker_planet_planet_FK FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
    ,CONSTRAINT liker_planet_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: liker_moon
#------------------------------------------------------------

CREATE TABLE liker_moon(
        moon_id         Int NOT NULL ,
        user_id         Int NOT NULL ,
        liker_moon_date Datetime NOT NULL
    ,CONSTRAINT liker_moon_PK PRIMARY KEY (moon_id,user_id)

    ,CONSTRAINT liker_moon_moon_FK FOREIGN KEY (moon_id) REFERENCES moon(moon_id)
    ,CONSTRAINT liker_moon_user0_FK FOREIGN KEY (user_id) REFERENCES user(user_id)
)ENGINE=InnoDB;