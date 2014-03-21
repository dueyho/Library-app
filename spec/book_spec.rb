require 'spec_helper'

describe Book do
  it 'is initialized with a book title and author' do
    test_book = Book.new('The River', 'Joe Blanco')
    test_book.should be_an_instance_of Book
  end
  it 'displays the title' do
    test_book = Book.new('The River', 'Joe Blanco')
    test_book.title.should eq 'The River'
  end
  it 'displays the author' do
    test_book = Book.new('The River', 'Joe Blanco')
    test_book.author.should eq 'Joe Blanco'
  end

  describe 'save' do
    it 'saves the book to the database' do
      test_book = Book.new('The River', 'Joe Blanco')
      test_book.save
      test_book.id.should be_an_instance_of Fixnum
    end
  end

  describe '.create' do
    it 'creates, which makes a new instances and saves, a new instance of book' do
      test_book = Book.create('The River', 'Joe Blanco')
      test_book.id.should be_an_instance_of Fixnum
    end
  end

  describe '.all' do
    it 'contains all of the books in the array' do
      test_book = Book.create('The River', 'Joe Blanco')
      Book.all.should eq [test_book]
    end
  end

  describe '==(another_book)' do
    it 'overrides the default == method in ruby to equate books with the same title and author' do
    test_book1 = Book.new('The River', 'Joe Blanco')
    test_book2 = Book.create('The River', 'Joe Blanco')
    test_book1.should eq test_book2
    end
  end

  describe 'update_title' do
    it 'updates the title of a book' do
      test_book = Book.create('The River', 'Joe Blanco')
      test_book.update_title('The River', 'The Ocean')
      test_book.title.should eq 'The Ocean'
    end
  end
  describe 'update_author' do
    it 'updates the author of a book' do
      test_book = Book.create('The River', 'Joe Blanco')
      test_book.update_author('Joe Blanco', 'Sally Field')
      test_book.author.should eq 'Sally Field'
    end
  end
  describe 'delete' do
    it 'deletes an entry/instance of book from the library database' do
      test_book1 = Book.create('The River', 'Joe Blanco')
      test_book2 = Book.create('The Lake', 'JoJo')
      test_book1.delete
      Book.all.should eq [test_book2]
    end
  end

  describe '.search' do
    it 'returns the book object when the title is searched for' do
      test_book1 = Book.create('The River', 'Joe Blanco')
      test_book2 = Book.create('The Lake', 'Stuart Campbell')
      test_book3 = Book.create('The Sea', 'Joe Blanco')
      Book.search('The River').should eq [test_book1]
    end
    it 'returns the book object when the author is searched for' do
      test_book1 = Book.create('The River', 'Joe Blanco')
      test_book2 = Book.create('The Lake', 'Stuart Campbell')
      test_book3 = Book.create('The Sea', 'Joe Blanco')
      Book.search('Joe Blanco').should eq [test_book1, test_book3]
    end
  end
end













