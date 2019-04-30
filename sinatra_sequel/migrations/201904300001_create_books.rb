Sequel.migration do
  up do
    run 'CREATE TABLE books (id SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL);'
  end

  down do
    run 'DROP TABLE books;'
  end
end
