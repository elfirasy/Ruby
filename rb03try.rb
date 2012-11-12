class Statistic
	attr_accessor :kota, :columns

	def csv(file)
	  File.open(file) do|f|
	    @columns = f.readline.chomp.split(',')

	    @kota = []
	    until f.eof?
	      row = f.readline.chomp.split(',')
	      row = columns.zip(row).flatten
	      table << Hash[*row]
	    end
	  end
	end

	

end

doc = Statistic.new
columns, kota = doc.csv('data_kota.csv')
puts kota[1]['Dari']
puts kota[1]['Ke']