require 'test/unit'
require 'rubygems'
require 'active_record'
require 'simplified_permalink'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

def setup_db
  silence_stream(STDOUT) do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :posts do |t|
        t.string :title
        t.string :permalink
        t.string :slug
      end
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class String

  def parameterize
    downcase.gsub(/[^a-z0-9]+/i, '-')
  end

  def normalize
  end

end

class Post < ActiveRecord::Base
  permalink :title
  permalink :title, :slug
end

class SimplifiedPermalinkTest < Test::Unit::TestCase

  def setup
    setup_db
  end

  def teardown
    teardown_db
  end

  def test_should_generate_permalink
    post = Post.create :title => "Chunky Bacon"
    assert_equal "chunky-bacon", post.permalink
  end

  def test_should_generate_permalink_on_slug
    post = Post.create :title => "Chunky Bacon"
    assert_equal "chunky-bacon", post.slug
  end

  def test_should_allow_to_define_custom_permalink
    post = Post.create :title => "Chunky Bacon", :permalink => "chunky-bacon-with-cheese"
    assert_equal "chunky-bacon-with-cheese", post.permalink
  end

end