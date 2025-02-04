CREATE USER app_user WITH PASSWORD 'app_password';

GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;

-- Tabela personagem não pode ser escrita diretamente (usar triggers)
REVOKE INSERT, UPDATE, DELETE ON personagem FROM app_user;
REVOKE INSERT, UPDATE, DELETE ON tecnica FROM app_user;
REVOKE INSERT, UPDATE, DELETE ON item FROM app_user;