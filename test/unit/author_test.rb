require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  
  should have_many(:items).through(:item_authors)
  should have_many(:item_authors)
  should validate_presence_of(:name)
  
  def should_save_author
    author = Author.new(:name => "Alice Walker")
    author.save!
    assert Author.count.eql? 1
  end
end
