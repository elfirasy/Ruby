class Statistic
	attr_accessor :data_kota, :result

	def initialize
		@data_kota = []
		@result = []
	end

	def csv(file)
		File.open(file) do|f|
			columns = f.readline.chomp.split(',')

			until f.eof?
				row = f.readline.chomp.split(',')
				row = columns.zip(row).flatten
				@data_kota << Hash[*row]
			end
		end

		# add kota
		add_rute
	end

	def add_rute
		# proses semua rute kota
		ruteX = []
		ruteY = []
		@data_kota.each do |x|
			ruteX << x
			ruteY << x
		end

		# melihat rute kunjungan dari dan ke dua kota
		ruteX.each do |x|
			ruteY.each do |y|
				if x['Dari'] == y['Ke'] and x['Ke'] == y['Dari']
					route = x['Ke'] + "-" + x['Dari']
					if @result.index(route) == nil
						@result <<  x['Dari'] + "-" + x['Ke']
					end
				end
			end
		end
	end
end

doc = Statistic.new
doc.csv('data_kota.csv')

puts "Daftar Rute dari dan menuju ke dua kota: "
puts doc.result
