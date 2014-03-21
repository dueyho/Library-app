class Book
  attr_reader :title, :author, :id
  def initialize(title, author, id=nil)
    @title = title
    @author = author
  end

  def save
    book = DB.exec("INSERT INTO books (title, author) VALUES ('#{title}', '#{author}')RETURNING id;")
    @id = book.first['id'].to_i
  end

  def self.create(title, author, id=nil)
    new_book = Book.new(title, author)
    new_book.save
    new_book
  end

  def self.search(input)
    array = []
    books = DB.exec("SELECT * FROM books WHERE title LIKE '#{input}' OR author LIKE '#{input}';")
    books.each do |book|
      title = book['title']
      author = book['author']
      array << Book.new(title,author)
    end
    array
  end

  def self.all
    books = DB.exec("SELECT * FROM books;")
    books_array = []
    books.each do |book|
      title = book['title']
      author = book['author']
      books_array << Book.new(title, author)
    end
    books_array
  end

  def ==(another_book)
    self.title == another_book.title && self.author == another_book.author
  end

  def update_title(old_title, new_title)
    book = DB.exec("UPDATE books SET title = '#{new_title}' WHERE title = '#{old_title}' RETURNING title;")
    @title = book.first['title']
  end

  def update_author(old_author, new_author)
    book = DB.exec("UPDATE books SET author = '#{new_author}' WHERE author = '#{old_author}' RETURNING author;")
    @author = book.first['author']
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end
end
