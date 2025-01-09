create database SolarSystem;
use SolarSystem;

create table Planets (
    planet_id int auto_increment primary key,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    distance_from_sun FLOAT NOT NULL, -- in AU (Astronomical Units)
    diameter FLOAT, -- in kilometers
    mass FLOAT      -- in kilograms
);

create table Moons (
    moon_id INT auto_increment primary key,
    name VARCHAR(50) NOT NULL,
    planet_id INT NOT NULL,
    diameter FLOAT, -- in kilometers
    orbital_period FLOAT, -- in days
    foreign key  (planet_id) references Planets(planet_id) on delete cascade
);

create table Stars (
    star_id INT auto_increment primary key,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    mass FLOAT, -- in kilograms
    temperature FLOAT -- in Kelvin
);

 create table Asteroids (
    asteroid_id INT auto_increment primary key ,
    name VARCHAR(100) NOT NULL,
    diameter FLOAT, -- in kilometers
    distance_from_sun FLOAT, -- in AU (Astronomical Units)
    mass FLOAT, -- in kilograms
    discovered_date DATE -- when the asteroid was discovered
);

 create table SpaceMissions (
    mission_id INT auto_increment primary key ,
    name VARCHAR(100) NOT NULL,
    mission_type VARCHAR(50), -- For example: Flyby, Orbiter, Lander, etc.
    launch_date DATE, -- when the mission was launched
    destination VARCHAR(50), -- Planet, Moon, or Asteroid
    status VARCHAR(20), -- Mission status (e.g., Active, Completed, Failed)
    spacecraft_name VARCHAR(100) -- The name of the spacecraft used
);

select * from planets;
INSERT INTO Planets (name, type, distance_from_sun, diameter, mass)
VALUES 
    ('Mercury', 'Terrestrial', 0.39, 4879, 3.30e23),
    ('Venus', 'Terrestrial', 0.72, 12104, 4.87e24),
    ('Earth', 'Terrestrial', 1.00, 12742, 5.97e24),
    ('Mars', 'Terrestrial', 1.52, 6779, 6.42e23),
    ('Jupiter', 'Gas Giant', 5.20, 139820, 1.90e27),
    ('Saturn', 'Gas Giant', 9.58, 116460, 5.68e26),
    ('Uranus', 'Ice Giant', 19.22, 50724, 8.68e25),
    ('Neptune', 'Ice Giant', 30.05, 49244, 1.02e26);

select * from moons;
INSERT INTO Moons (name, planet_id, diameter, orbital_period)
VALUES 
    ('Moon', 3, 3474, 27.3), -- Earth's Moon
    ('Phobos', 4, 22.4, 0.32), -- Mars' Moon
    ('Deimos', 4, 12.4, 1.26), -- Mars' Moon
    ('Europa', 5, 3121.6, 3.55), -- Jupiter's Moon
    ('Ganymede', 5, 5268, 7.15), -- Jupiter's Moon
    ('Titan', 6, 5150, 15.95); -- Saturn's Moon

select * from stars;
INSERT INTO Stars (name, type, mass, temperature)
VALUES 
    ('Sun', 'Yellow Dwarf', 1.989e30, 5778);

select * from asteroids;
INSERT INTO Asteroids (name, diameter, distance_from_sun, mass, discovered_date)
VALUES 
    ('Ceres', 940, 2.77, 9.39e20, '1801-01-01'),
    ('Vesta', 525, 2.36, 2.59e20, '1807-03-29'),
    ('Pallas', 512, 2.77, 2.11e20, '1802-03-28'),
    ('Juno', 250, 2.67, 1.29e20, '1804-09-01'),
    ('Eros', 33.0, 1.46, 6.69e18, '1898-08-13');

select * from spacemissions;
INSERT INTO SpaceMissions (name, mission_type, launch_date, destination, status, spacecraft_name)
VALUES 
    ('Mars Odyssey', 'Orbiter', '2001-04-07', 'Mars', 'Completed', 'Mars Odyssey'),
    ('New Horizons', 'Flyby', '2006-01-19', 'Pluto', 'Completed', 'New Horizons'),
    ('Juno', 'Orbiter', '2011-08-05', 'Jupiter', 'Active', 'Juno'),
    ('Voyager 1', 'Flyby', '1977-09-05', 'Interstellar Space', 'Active', 'Voyager 1'),
    ('Rosetta', 'Lander', '2004-03-02', 'Comet 67P', 'Completed', 'Rosetta');
    
SELECT name, diameter, distance_from_sun
FROM planets
ORDER BY distance_from_sun;

SELECT m.name FROM moons m
JOIN planets p ON m.planet_id = p.planet_id
WHERE p.name = 'Earth';

SELECT name FROM planets WHERE gravity > 10;

SELECT p.name AS planet_name, COUNT(m.moon_id) AS moon_count
FROM planets p
LEFT JOIN moons m ON p.planet_id = m.planet_id
GROUP BY p.planet_id
ORDER BY moon_count DESC
LIMIT 1;

SELECT name, orbital_period, discovery_date
FROM planets
WHERE orbital_period > 1
AND discovery_date > '2000-01-01';