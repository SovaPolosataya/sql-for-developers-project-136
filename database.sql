CREATE TABLE lessons (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50) NOT NULL,
	body text,
	video VARCHAR(255),
	position BIGINT,
	created_at DATE NOT NULL,
	update_at DATE,
	course_id BIGINT REFERENCES courses(id) NOT NULL,
	is_deleted tinyint
);

CREATE TABLE courses (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        description text,
        created_at DATE NOT NULL,
        update_at DATE,
	module_id BIGINT REFERENCES modules(id) NOT NULL,
	is_deleted tinyint
);

CREATE TABLE modules (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        description text,
        created_at DATE NOT NULL,
        update_at DATE,
	program_id BIGINT REFERENCES programs(id) NOT NULL,
	is_deleted tinyint
);

CREATE TABLE programs (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        price integer,
	type VARCHAR(50),
        created_at DATE NOT NULL,
        update_at DATE,
	is_deleted tinyint
);
