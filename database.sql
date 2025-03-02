\CREATE TABLE lessons (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50) NOT NULL,
	body text,
	video VARCHAR(500),
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

CREATE TABLE users (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(255),
	password VARCHAR(500),
	teachig_groupe_id BIGINT REFERENCES teaching_groupes(id) NOT NULL,
        created_at DATE NOT NULL,
        update_at DATE,
	role VARCHAR(50),
        is_deleted tinyint
);

CREATE TABLE teaching_groups (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        slug VARCHAR(50) NOT NULL,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TYPE subscription AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	user_id BIGINT REFERENCES users(id) NOT NULL,
	program_id BIGINT REFERENCES programs(id) NOT NULL,
	subscription_status subscription,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TYPE pay AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TABLE payments (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        enrollment_id BIGINT REFERENCES enrollments(id) NOT NULL,
        payment_status pay,
	payment_date DATE,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TYPE completion AS ENUM ('active', 'completed', 'pending', 'cancelled');
CREATE TABLE program_completions (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id BIGINT REFERENCES users(id) NOT NULL,
	program_id BIGINT REFERENCES programs(id) NOT NULL,
        completion_status completion,
        start_date DATE,
	finish_date DATE,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TABLE certificates (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id BIGINT REFERENCES users(id) NOT NULL,
        program_id BIGINT REFERENCES programs(id) NOT NULL,
	certificate_url VARCHAR(500),
	release_date DATE,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TABLE quizzes (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
        name VARCHAR(100),
	body NVARCHAR,
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);

CREATE TABLE exercises (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
        name VARCHAR(100),
        url VARCHAR(255),
        created_at DATE NOT NULL,
        update_at DATE,
        is_deleted tinyint
);
