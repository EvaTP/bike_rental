-- code à insérer dans le sql Editor de vercel (sql pour posgres)

-- table users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    password TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (email, password, created_at, updated_at) VALUES
    ('ada@lovelace.fr', 'passwordada', '2025-04-05', now()),
    ('agnes@varda.fr', 'passwordagnes', '2025-04-06', now()),
    ('jean@dupond.fr', 'passwordjean', now(), NULL);
    -- (updated_at : NULL car pas obligatoire)
    -- je peux changer l'ordre des colonnes du moment qu'elles correspondent bien :
        -- INSERT INTO users (password, email, created_at, updated_at) VALUES
        -- ('passwordada', 'ada@lovelace.fr' '2025-04-05', now()),
    

-- table bicycles
CREATE TABLE bicycles (
    id SERIAL PRIMARY KEY,
    name TEXT,
    model TEXT,
    size TEXT,
    rental_price FLOAT
);

INSERT INTO bicycles(name, model, size, rental_price) VALUES
    ('supervelo', 'route', 'moyen', 30.50),
    ('maxivelo', 'vtt', 'grand', 55.50),
    ('voltvelo', 'électrique', 'petit', 80.50),
    ('megavelo', 'hybride', 'grand', 100.80),
    ('crashvelo', 'bmx', 'moyen', 60.00);

-- table rentals
CREATE TABLE rentals (
    id SERIAL PRIMARY KEY,
    user_id INT,
    bicycle_id INT,
    rental_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    duration FLOAT,
    total_rental_price FLOAT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (bicycle_id) REFERENCES bicycles(id)
    );

INSERT INTO rentals (user_id, bicycle_id, rental_date, duration, total_rental_price, created_at, updated_at) VALUES
    (1, 3, '2025-04-05', 10, 70.50, '2025-04-05', now()),
    (3, 4, '2024-06-15', 7.5, 155.50, '2024-06-15', now()),
    (2, 5, '2025-01-12', 8, 202.50, '2025-01-12', now());


-- modification rajout FK à posteriori
ALTER TABLE rentals
ADD CONSTRAINT "FK_rentals_bicycle_id"
FOREIGN KEY (bicycle_id)
REFERENCES bicycles(id);
-- FK... je précise le type de contrainte

ALTER TABLE
"rentals"
ADD CONSTRAINT "FK_rentals_user_id"
FOREIGN KEY (user_id)
REFERENCES users(id);

-- jointure entre deux tables
SELECT *
FROM rentals
JOIN users
ON users.id = rentals.user_id;

-- jointure entre trois tables
-- La requête sélectionnera toutes les colonnes (*) des trois tables (rentals, users, et bicycles) pour chaque location, en reliant les enregistrements correspondants en fonction des FK user_id et bicycle_id.
SELECT *
FROM rentals
JOIN users
ON users.id = rentals.user_id
JOIN bicycles
ON bicycles.id = rentals.bicycle_id;


-- ici je génère une nouvelle table en combinant 3 tables
-- pour obtenir l'email de l'utilisateur et le modèle du vélo pour chaque location
SELECT users.email, bicycles.model
FROM rentals
JOIN users ON users.id = rentals.user_id
JOIN bicycles ON bicycles.id = rentals.bicycle_id;



   