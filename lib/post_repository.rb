class PostRepository
    # Selecting all records
    # No arguments

    def all
        # Executes the SQL query:
        # SELECT * FROM posts;

        # Returns an array of Account objects.
    end

    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
        # Executes the SQL query:
        # SELECT * FROM posts WHERE id = $1;

        # Returns a single Student object.
    end

    def create(account)
        # Executes the SQL query:
        # INSERT INTO posts(title, content, views, account_id) VALUES($1, $2, $3, $4);

        # Returns nothing.
    end

    def delete(id)
      # Executes the SQL query:
      # DELETE FROM posts WHERE id = $1;

      # Returns nothing.

    end
end