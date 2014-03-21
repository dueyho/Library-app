class Book_Author
  attr_reader :book_id, :author_id, :id
  def initialize(book_id, author_id, id=nil)
    @book_id = book_id
    @author_id = author_id
  end

  def save
    book_author = DB.exec("INSERT INTO book_author (book_id, author_id) VALUES (#{@book_id}, #{@author_id}) RETURNING id;")
    @id = book_author.first['id'].to_i
  end

  def self.books_by_author(input_author_id)
    found_books =[]
    pgs = DB.exec("SELECT * FROM book_author WHERE author_id = #{input_author_id};")
    pgs.each do |pg|
      results = DB.exec("SELECT * FROM books WHERE id = #{pg['book_id']};")
      results.each do |result|
        title = result['title']
        author = result['author']
        found_books << Book.new(title,author)
      end
    end
    found_books
  end

  def self.authors_by_book(input_book_id)
    found_authors =[]
    pgs = DB.exec("SELECT * FROM book_author WHERE book_id = #{input_book_id};")
    pgs.each do |pg|
      results = DB.exec("SELECT * FROM authors WHERE id = #{pg['author_id']};")
      results.each do |result|
        name = result['name']
        found_authors << Author.new(name)
      end
    end
    found_authors
  end
end


