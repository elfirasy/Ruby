require './rb01try.rb'
require 'test/unit'

class DocumentText < Test::Unit::TestCase

	def test_that_word_is_count_right
		test = 'A bunch of word'
		doc = Document.new('Test', 'nobody', test)
		assert_equal 4, doc.words_count, 'Word count is correct'
	end
end