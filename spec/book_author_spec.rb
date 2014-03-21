require 'spec_helper'

describe 'Book_Author' do
  it 'is initialized with a book ID and an author ID' do
    test_book_author = Book_Author.new(1,1)
    test_book_author.should be_an_instance_of Book_Author
  end

  describe 'save' do
    it 'saves the book and author instance to the book-to-author join table' do
      test_book_author = Book_Author.new(1,2)
      test_book_author.save
      test_book_author.id.should be_an_instance_of Fixnum
    end
  end

  describe 'books_by_author' do
    it 'returns all the books written by a given author' do
      test_book1 = Book.create('The River','Joe')
      test_book2 = Book.create('The Coffin','Bill')
      test_book3 = Book.create('DEATH','Bill')
      test_author1 = Author.create('Joe')
      test_author2 = Author.create('Bill')
      test_book_author1 = Book_Author.new(test_book1.id, test_author1.id)
      test_book_author1.save
      test_book_author2 = Book_Author.new(test_book2.id, test_author2.id)
      test_book_author2.save
      test_book_author3 = Book_Author.new(test_book3.id, test_author2.id)
      test_book_author3.save
      Book_Author.books_by_author(test_author2.id).should eq [test_book2, test_book3]
    end
  end

  describe 'authors_by_book' do
    it 'returns all the authors for a given book' do
      test_book1 = Book.create('The River','Joe')
      test_book2 = Book.create('The Coffin','Bill')
      test_book3 = Book.create('DEATH','Bill')
      test_author1 = Author.create('Joe')
      test_author2 = Author.create('Bill')
      test_book_author1 = Book_Author.new(test_book1.id, test_author1.id)
      test_book_author1.save
      test_book_author2 = Book_Author.new(test_book2.id, test_author2.id)
      test_book_author2.save
      test_book_author3 = Book_Author.new(test_book3.id, test_author2.id)
      test_book_author3.save
      Book_Author.authors_by_book(test_book2.id).should eq [test_author2]
    end
  end
end
