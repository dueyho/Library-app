require 'rspec'
require 'book'
require 'author'
require 'book_author'
require 'pg'

DB = PG.connect({:dbname => 'test_library'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM book_author *;")
  end
end
