CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
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
    borrower TEXT NOT NULL,
    date_borrowed DATE NOT NULL,
    date_returned DATE DEFAULT NULL
);
CREATE TYPE status AS ENUM ('available', 'loaned', 'missing');
ALTER TABLE loans ADD CONSTRAINT loans_ref_tool_id FOREIGN KEY (tool_id) REFERENCES tools (id) ON DELETE NO ACTION;
