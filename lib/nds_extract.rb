require 'directors_database'

def flatten_a_o_a(aoa)
  results = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      results << aoa[i][k]
      k += 1
    end
    i += 1
  end
  results
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end

def movies_with_director_key(name, movies_collection)
  i = 0 
  results = []
  while i < movies_collection.length do
    movies_collection[i][:director_name] = name
    i+= 1
  end
  return movies_collection
end


def gross_per_studio(collection)
  i = 0 
  new_hash = {}
  while i < collection.length do
    m = 0
    studio = collection[i][:studio]
    if new_hash[studio] != nil
      new_hash[studio] += collection[i][:worldwide_gross]
    else
      new_hash[studio] = collection[i][:worldwide_gross]
    end
    i += 1
  end
  return new_hash
end

def movies_with_directors_set(source)
  i = 0  
  new_array = []
  while i < source.length do
    new_array.push(movies_with_director_key(source[i][:name], source[i][:movies]))
    i += 1 
  end
  return new_array
end

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
