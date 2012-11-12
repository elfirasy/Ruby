#Week 1

class Statistic
	attr_accessor :kota_asal, :kota_tujuan, :from_counter, :to_counter, :list_kota_by_limit

	def initialize(file)
		@kota_asal = []
		@kota_tujuan = []
		@from_counter = []
		@to_counter = []
		@list_kota_by_limit = []
		add_daftar(file)
	end

	def add_daftar (file)
		# read file
		File.foreach("./" + file ) { |line| add_rute(line) }

		# menghilangkan newline pada array
		@kota_tujuan.map{ |x| x.strip! }
		@kota_asal.map{ |x| x.strip! }

		# hitung jumlah kunjungan dari dan ke setiap kota
		counter_kota_asal
		counter_kota_tujuan

		# sorting daftar kota berdasarkan jumlah kunjungan dari dan ke
		sort_kota
	end

	def add_rute (line)
		# split line
		from = line.split(",").first
		add_kota_asal(from)

		# split line-
		to = line.split(",").last
		add_kota_tujuan(to)
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

doc = Statistic.new('data_kota.csv')
puts "Daftar Kota Asal: "
puts doc.kota_asal

puts "\nDaftar Kota Tujuan: "
puts doc.kota_tujuan

puts "\nDaftar Kota Yang Dikunjungi Lebih Dari 1 kali: "
doc.list_kota_by_counter(2)
puts doc.list_kota_by_limit
