module Dooc
		def initialize (title,author,content)
			@title = title
			@author = author
			@content = content
		end

		def words
			@content.split
		end

		def words_count
			words.size
		end

		def each_word
			word_array = words
			index = 0
			while index < words.size
				yield( word_array[index] )
				index += 1
			end
		end

		def each_word_pair
			word_array = words
			index = 0
			while index < (word_array.size-1)
				yield word_array[index], word_array[index+1]
				index += 1
			end
		end

end

class Document
	include Enumerable
	attr_accessor :title, :author, :content
	include Dooc
end

if __FILE__ == $0

	doc = Document.new('Eloquent Ruby', 'Russ Olsen', 'Basic Consept for Ruby programmer')
	puts doc.title
	puts doc.author
	puts doc.content

	now = Time.now
	puts one_minute_from_now = now + 60

	d = Document.new( 'Truth', 'Gump', 'Life is like a box of ...' )
	d.each_word {|word| puts word}

	doc = Document.new('Donuts', '?', 'I love donuts mmmm donuts' )
	doc.each_word_pair{ |first, second| puts "#{first} #{second}" }

	enum = Enumerator.new( doc, :each_character )
	pp enum.sort

end 
