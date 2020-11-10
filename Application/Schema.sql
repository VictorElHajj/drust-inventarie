CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TYPE status AS ENUM ('available', 'loaned', 'missing');
CREATE TABLE tools (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    category TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    status status NOT NULL
);
CREATE TABLE loans (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    tool_id UUID NOT NULL,
    date_borrowed DATE NOT NULL,
    date_returned DATE DEFAULT NULL,
    borrower_id UUID NOT NULL
);
CREATE TABLE borrowers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    cid TEXT NOT NULL UNIQUE
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
ALTER TABLE loans ADD CONSTRAINT loans_ref_tool_id FOREIGN KEY (tool_id) REFERENCES tools (id) ON DELETE NO ACTION;
ALTER TABLE loans ADD CONSTRAINT loans_ref_borrower_id FOREIGN KEY (borrower_id) REFERENCES borrowers (id) ON DELETE CASCADE;
