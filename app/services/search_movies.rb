class SearchMovies

	#passe le string en param
	def initialize(movie)
	    @movie = movie
	end

	def perform
		log_in_to_database
		look_for_movies
	end

	def log_in_to_database
		appkey = ENV['TMDB_API_KEY']
		Tmdb::Api.key(appkey)
		Tmdb::Api.language("fr")

		#url = URI("https://api.themoviedb.org/3/configuration?api_key="+appkey)
		#http = Net::HTTP.new(url.host, url.port)
		#http.use_ssl = true
		#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	end

	def look_for_movies
		#Tmdb::Movie.find(@movie)
		@search = Tmdb::Search.new
		#@search.resource('movie') # determines type of resource
		@search.query(@movie) # the query to search against


		#faire un hash avec name, date, real, image
		

		@results = @search.fetch
        @results = [] if @results == nil
        @results.size.times do |x|
		
			 unless Tmdb::Movie.crew(@results[x]["id"]) == []
				@results[x]["director"] = Tmdb::Movie.crew(@results[x]["id"])[0]["name"]
			 end
		
		end
		return @results

		#Tmdb::Movie.images(22855)
		#@movie['posters']



		#request = Net::HTTP::Get.new(url)
		#request.body = "{}"

		#response = http.request(request)
		#puts response.read_body

	end

end