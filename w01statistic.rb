#Week 1

class Statistic
	attr_accessor :kota_asal, :kota_tujuan

	def initialize(file)
		@kota_asal =[]
		@kota_tujuan = []
		File.foreach("./" + file) { |line| rute_kota(line) }
	end

	def rute_kota (line)
		#
	end
end

if __FILE__ == $0
	doc = Statistic.new('empty_shipping.csv')

end