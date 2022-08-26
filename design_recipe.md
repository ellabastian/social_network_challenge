1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns:

user account, email address, username, posts, user account, post title, post content, post views

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	  Properties
account	  email_address, username
post	    title, content, views

Name of the first table (always plural): accounts

Column names: email_address, username

Name of the second table (always plural): posts

Column names: title, content, views

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: accounts
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int


4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [account] have many [posts]? (Yes/No) yes
Can one [post] have many [accounts]? (Yes/No) no
You'll then be able to say that:

[accounts] have many [posts]
And on the other side, [posts] belong to [accounts]
In that case, the foreign key is in the table [posts]
Replace the relevant bits in this example with your own:

If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

4. Write the SQL.
-- EXAMPLE
-- file: social_network_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
  views int,
-- The foreign key name is always {other_table_singular}_id
  account_id int,
  constraint fk_account foreign key(account_id)
    references accounts(id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql

6. Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: accounts

# Model class 1
# (in lib/account.rb)
class Account
end

# Table name: posts

# Model class 2
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end

7. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: accounts

# Model class 1
# (in lib/account.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

# Table name: posts

# Model class 2
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

8. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments

  def all
    # Executes the SQL query:
    # SELECT * FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  def create(account)
    # Executes the SQL query:
    # INSERT INTO accounts(email_address, username, post_id) VALUES($1, $2, $3);

    # Returns nothing.
  end

    def delete(id)
      # Executes the SQL query:
      # DELETE FROM accounts WHERE id = $1;

      # Returns nothing.

    end

  # def update(student)
  # end
end


# Table name: posts

# Repository class
# (in lib/post_repository.rb)

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

  # def update(student)
  # end
end



9. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

expect(accounts.length).to eq 2

expect(accounts[0].id).to eq 1
expect(accounts[0].email_address).to eq 'davidjackson@google.com'
expect(accounts[0].username).to eq 'davidjackson'

expect(accounts[1].id).to eq 2
expect(accounts[1].name).to eq 'emmawatson@google.com'
expect(accounts[1].cohort_name).to eq ''emmawatson1'

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  1
account.email_address = 'davidjackson@google.com'
account.cohorusernamet_name = 'davidjackson'

# 3
# Create a new account

repo = AccountRepository.new

account = Account.new
account.email_address = 'ella@google.com'
account.username = 'ellab'

repo.create(account) => nil

account = repo.all

last_account = account.last
last_account.email_address = 'ella@google.com'
last_account.username = 'ellab'

# 3
# Create a new account

repo = AccountRepository.new

repo.delete(1)

accounts = repo.all
accounts.length = 1
accounts.first.id = 2


# Add more examples for each method
Encode this example as a test.

10. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end

11. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.