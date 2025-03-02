CREATE TABLE courses (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        description text,
        created_at DATE NOT NULL,
        updated_at DATE,
	deleted_at BOOLEAN
);

CREATE TABLE lessons (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50) NOT NULL,
	content text,
	video_url VARCHAR(500),
	position BIGINT,
	created_at DATE NOT NULL,
	updated_at DATE,
	course_id BIGINT REFERENCES courses(id) NOT NULL,
	deleted_at BOOLEAN
);

CREATE TABLE modules (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        description text,
        created_at DATE NOT NULL,
        updated_at DATE,
	deleted_at BOOLEAN
);

CREATE TABLE programs (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        price integer,
	program_type VARCHAR(50),
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE program_moduls (
	program_id BIGINT REFERENCES programs(id) NOT NULL,
	module_id BIGINT REFERENCES modules(id) NOT NULL
);

CREATE TABLE course_moduls (
        course_id BIGINT REFERENCES courses(id) NOT NULL,
        module_id BIGINT REFERENCES modules(id) NOT NULL
);

CREATE TABLE teaching_groups (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        slug VARCHAR(50) NOT NULL,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE users (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(255),
	password VARCHAR(500),
	teachig_groupe_id BIGINT REFERENCES teaching_groups(id) NOT NULL,
        created_at DATE NOT NULL,
        updated_at DATE,
	role VARCHAR(50),
	deleted_at BOOLEAN
);


CREATE TYPE subscription AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	user_id BIGINT REFERENCES users(id) NOT NULL,
	program_id BIGINT REFERENCES programs(id) NOT NULL,
	status subscription,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TYPE pay AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TABLE payments (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        enrollment_id BIGINT REFERENCES enrollments(id) NOT NULL,
	amount integer,
        status pay,
	payid_at DATE,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TYPE completion AS ENUM ('active', 'completed', 'pending', 'cancelled');
CREATE TABLE program_completions (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id BIGINT REFERENCES users(id) NOT NULL,
	program_id BIGINT REFERENCES programs(id) NOT NULL,
        status completion,
        started_at DATE,
	completed_at DATE,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE certificates (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id BIGINT REFERENCES users(id) NOT NULL,
        program_id BIGINT REFERENCES programs(id) NOT NULL,
	url VARCHAR(500),
	issued_at DATE,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE quizzes (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
        name VARCHAR(100),
	content text,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE exercises (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
        name VARCHAR(100),
        url VARCHAR(255),
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TABLE discussions (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
	user_id BIGINT REFERENCES users(id) NOT NULL,
        text text,
        created_at DATE NOT NULL,
        updated_at DATE
);

CREATE TYPE status AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blog (
        id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id BIGINT REFERENCES users(id) NOT NULL,
        name VARCHAR(255),
        content text,
	status status,
        created_at DATE NOT NULL,
        updated_at DATE
);
