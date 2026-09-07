CREATE TABLE company (
    id           BIGSERIAL PRIMARY KEY,
    name         VARCHAR(200) NOT NULL,
    inn          CHAR(10),
    city         VARCHAR(100) NOT NULL,
    industry     VARCHAR(50)  NOT NULL,
    site_url     VARCHAR(200),
    founded_year INT,
    created_at   TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE TABLE skill (
    id       BIGSERIAL PRIMARY KEY,
    name     VARCHAR(60) NOT NULL UNIQUE,
    category VARCHAR(40) NOT NULL
);

CREATE TABLE vacancy (
    id              BIGSERIAL PRIMARY KEY,
    company_id      BIGINT       NOT NULL REFERENCES company (id),
    title           VARCHAR(200) NOT NULL,
    description     TEXT,
    salary_from     NUMERIC(12, 2),
    salary_to       NUMERIC(12, 2),
    currency        CHAR(3)      NOT NULL DEFAULT 'RUB',
    grade           VARCHAR(20)  NOT NULL,
    employment_type VARCHAR(20)  NOT NULL,
    city            VARCHAR(100) NOT NULL,
    is_remote       BOOLEAN      NOT NULL DEFAULT FALSE,
    status          VARCHAR(20)  NOT NULL,
    published_at    DATE         NOT NULL,
    closed_at       DATE,
    CONSTRAINT vacancy_grade_chk CHECK (grade IN ('JUNIOR', 'MIDDLE', 'SENIOR', 'LEAD')),
    CONSTRAINT vacancy_status_chk CHECK (status IN ('OPEN', 'ON_HOLD', 'CLOSED')),
    CONSTRAINT vacancy_empl_chk CHECK (employment_type IN ('FULL_TIME', 'PART_TIME', 'CONTRACT')),
    CONSTRAINT vacancy_salary_chk CHECK (salary_to IS NULL OR salary_from IS NULL OR salary_to >= salary_from)
);

CREATE TABLE candidate (
    id              BIGSERIAL PRIMARY KEY,
    full_name       VARCHAR(200) NOT NULL,
    email           VARCHAR(200),
    phone_raw       VARCHAR(50),
    city            VARCHAR(100),
    birth_date      DATE,
    about           TEXT,
    skills_raw      TEXT,
    expected_salary NUMERIC(12, 2),
    source          VARCHAR(30),
    created_at      DATE         NOT NULL
);

CREATE TABLE candidate_skill (
    candidate_id BIGINT NOT NULL REFERENCES candidate (id),
    skill_id     BIGINT NOT NULL REFERENCES skill (id),
    years        INT    NOT NULL,
    PRIMARY KEY (candidate_id, skill_id)
);

CREATE TABLE vacancy_skill (
    vacancy_id  BIGINT  NOT NULL REFERENCES vacancy (id),
    skill_id    BIGINT  NOT NULL REFERENCES skill (id),
    is_required BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (vacancy_id, skill_id)
);

CREATE TABLE application (
    id           BIGSERIAL PRIMARY KEY,
    candidate_id BIGINT      NOT NULL REFERENCES candidate (id),
    vacancy_id   BIGINT      NOT NULL REFERENCES vacancy (id),
    status       VARCHAR(20) NOT NULL,
    cover_letter TEXT,
    created_at   DATE        NOT NULL,
    updated_at   DATE        NOT NULL,
    CONSTRAINT application_status_chk
        CHECK (status IN ('NEW', 'SCREENING', 'INTERVIEW', 'OFFER', 'HIRED', 'REJECTED')),
    CONSTRAINT application_uniq UNIQUE (candidate_id, vacancy_id)
);

CREATE TABLE interview (
    id               BIGSERIAL PRIMARY KEY,
    application_id   BIGINT      NOT NULL REFERENCES application (id),
    stage            VARCHAR(20) NOT NULL,
    scheduled_at     TIMESTAMP   NOT NULL,
    interviewer_name VARCHAR(200) NOT NULL,
    score            INT,
    feedback         TEXT,
    CONSTRAINT interview_stage_chk CHECK (stage IN ('SCREENING', 'TECH', 'SYSTEM_DESIGN', 'FINAL')),
    CONSTRAINT interview_score_chk CHECK (score IS NULL OR score BETWEEN 1 AND 5)
);

CREATE INDEX idx_vacancy_company ON vacancy (company_id);
CREATE INDEX idx_application_candidate ON application (candidate_id);
CREATE INDEX idx_application_vacancy ON application (vacancy_id);
CREATE INDEX idx_interview_application ON interview (application_id);
