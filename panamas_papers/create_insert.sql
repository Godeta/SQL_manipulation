drop table first_Create;

CREATE TABLE entity (
    id INTEGER,
    name TEXT NOT NULL,
    jurisdiction TEXT,
    jurisdiction_description TEXT,
    company_type TEXT,
    address_id INTEGER,
    incorporation_date DATE,
    inactivation_date DATE,
    status TEXT,
    service_provider TEXT,
    country_codes TEXT,
    countries TEXT,
    source TEXT,
    PRIMARY KEY(id),
    FOREIGN KEY(address_id) REFERENCES address(id)
)

INSERT INTO entity (id, name, jurisdiction, jurisdiction_description, incorporation_date) VALUES (0, 'Une société', 'IMG', 'Le Pays Imaginaire', '2020-01-01');