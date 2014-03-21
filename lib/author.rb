class Author
  attr_reader :name, :id
  def initialize(name, id=nil)
    @name = name
  end

  def save
    author = DB.exec("INSERT INTO authors (name) VALUES ('#{name}') RETURNING id;")
    @id = author.first['id'].to_i
  end

  def self.create(name, id=nil)
    new_author = Author.new(name)
    new_author.save
    new_author
  end

  def self.search(input)
    array = []
    authors = DB.exec("SELECT * FROM authors WHERE name = '#{input}';")
    authors.each do |author|
      name = author['name']
      array << Author.new(name)
    end
    array
  end

  def self.all
    authors = DB.exec("SELECT * FROM authors;")
    authors_array = []
    authors.each do |author|
      name = author['name']
      authors_array << Author.new(name)
    end
    authors_array
  end

  def ==(another_author)
    self.name == another_author.name
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end
end
