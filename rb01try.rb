class Statistic
	attr_accessor :data_kota, :result, :kota_asal, :kota_tujuan, :from_counter, :to_counter, :list_kota_by_limit

	def initialize
		@data_kota = []
		@result = []
		@kota_asal = []
		@kota_tujuan = []
		@from_counter = []
		@to_counter = []
		@list_kota_by_limit = []
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

		# menghilangkan newline pada array
		@kota_tujuan.map{ |x| x.strip! }
		@kota_asal.map{ |x| x.strip! }

		# hitung jumlah kunjungan dari dan ke setiap kota
		counter_kota_asal
		counter_kota_tujuan

		# sorting daftar kota berdasarkan jumlah kunjungan dari dan ke
		sort_kota
	end

	def add_rute
		# proses semua rute kota
		ruteX = []
		ruteY = []
		@data_kota.each do |x|
			ruteX << x
			ruteY << x

			add_kota_asal(x['Dari'])
			add_kota_tujuan(x['Ke'])
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

	def add_kota_asal (kota)
		# cek kota apakah sudah ada dalam list atau belum
		k = unique_kota_asal(kota) || add_unique_kota_asal(kota)
		@from_counter << k
	end

	def unique_kota_asal (kota)
		# get index from kota
		@kota_asal.index(kota)
	end

	def add_unique_kota_asal (kota)
		# add kota to FROM list
		@kota_asal << kota
		kota_asal.size - 1
	end

	def add_kota_tujuan (kota)
		# cek kota apakah sudah ada dalam list atau belum
		k = unique_kota_tujuan(kota) || add_unique_kota_tujuan(kota)
		@to_counter << k
	end

	def unique_kota_tujuan (kota)
		# get index of kota
		@kota_tujuan.index(kota)
	end

	def add_unique_kota_tujuan (kota)
		# add index of kota to TO list
		@kota_tujuan << kota
		kota_tujuan.size - 1
	end

	def counter_kota_asal
		i = 0
		while i < @kota_asal.size
			@kota_asal.at(i) << " " + @from_counter.count( i ).to_s
			i += 1
		end
	end

	def counter_kota_tujuan
		i = 0
		while i < @kota_tujuan.size
			@kota_tujuan.at(i) << " " + @to_counter.count( i ).to_s
			i += 1
		end
	end

	def sort_kota
		# sorting kota asal berdasarkan jumlah terbanyak
		@kota_asal.sort! do|a,b|
		  b.split(' ').reverse.join(' ') <=> a.split(' ').reverse.join(' ')
		end

		#sorting kota tujuan berdasarkan jumlah terbanyak
		@kota_tujuan.sort! do|a,b|
		  b.split(' ').reverse.join(' ') <=> a.split(' ').reverse.join(' ')
		end
	end

	def list_kota_by_counter(number)
		@kota = @kota_tujuan + @kota_asal
		@kota.each do |v|
			a = v.split(' ').reverse
			if a.at(0).to_i > number
				@list_kota_by_limit << v
			end
		end
		# sorting berdasarkan jumlah
		@list_kota_by_limit.sort! do|a,b|
		  b.split(' ').reverse.join(' ') <=> a.split(' ').reverse.join(' ')
		end
	end
	
end

doc = Statistic.new
doc.csv('empty_shipping.csv')

puts "Daftar Kota Asal: "
puts doc.kota_asal

puts "\nDaftar Kota Tujuan: "
puts doc.kota_tujuan

puts "\nDaftar Kota Yang Dikunjungi Lebih Dari 300 kali: "
doc.list_kota_by_counter(300)
puts doc.list_kota_by_limit

puts "\nDaftar Rute dari dan menuju ke dua kota: "
puts doc.result
