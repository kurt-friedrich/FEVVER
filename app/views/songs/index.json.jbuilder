json.array!(@songs) do |song|
  json.extract! song, :id, :name, :key, :lyrics, :note, :band_id
  json.url song_url(song, format: :json)
end
