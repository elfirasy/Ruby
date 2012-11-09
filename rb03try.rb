class Hitung
	attr_accessor :first, :second, :third, :fourth, :result

	def initialize ( a, b, c, d)
		@first = a
		@second = b
		@third = c
		@fourth = d
	end

	def Hresult
		@result = @first + @second * ( @third - @fourth)
	end

	def Xresult
		@result = @first.+(@second.*(@third.-(@fourth)))
	end

end

if __FILE__ == $0

	hit = Hitung.new(2,4,6,3)
	puts hit.Hresult
	puts hit.Xresult

	a = true
	puts a
	puts !a
end