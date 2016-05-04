json.array!(@bands) do |band|
  json.extract! band, :id, :name, :owner_id
  json.url band_url(band, format: :json)
end
