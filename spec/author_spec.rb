require 'spec_helper'

describe 'Author' do
  it 'initializes an author with a name' do
    test_author = Author.new('John Doe')
    test_author.should be_an_instance_of Author
  end
  it 'displays the name' do
    test_author = Author.new('Joe Blanco')
    test_author.name.should eq 'Joe Blanco'
  end

  describe 'save' do
    it 'saves the author to the database' do
      test_author = Author.new('Joe Blanco')
      test_author.save
      test_author.id.should be_an_instance_of Fixnum
    end
  end

  describe '.create' do
    it 'creates, which makes a new instances and saves, a new instance of author' do
      test_author = Author.create('Joe Blanco')
      test_author.id.should be_an_instance_of Fixnum
    end
  end

  describe '.all' do
    it 'contains all of the authors in the array' do
      test_author = Author.create('Joe Blanco')
      Author.all.should eq [test_author]
    end
  end

  describe '==(another_author)' do
    it 'overrides the default == method in ruby to equate authors with the same title and author' do
    test_author1 = Author.new('Joe Blanco')
    test_author2 = Author.create('Joe Blanco')
    test_author1.should eq test_author2
    end
  end

  describe 'delete' do
    it 'deletes an entry/instance of author from the library database' do
      test_author1 = Author.create('Joe Blanco')
      test_author2 = Author.create('JoJo')
      test_author1.delete
      Author.all.should eq [test_author2]
    end
  end

  describe '.search' do
    it 'returns the author object when the name is searched for' do
      test_author1 = Author.create('Joe Blanco')
      test_author2 = Author.create('Stuart Campbell')
      test_author3 = Author.create('Joe Blanco')
      Author.search('Stuart Campbell').should eq [test_author2]
    end
    it 'returns the author object when the author is searched for' do
      test_author1 = Author.create('Joe Blanco')
      test_author2 = Author.create('Stuart Campbell')
      test_author3 = Author.create('Joe Blanco')
      Author.search('Joe Blanco').should eq [test_author1, test_author3]
    end
  end
end
