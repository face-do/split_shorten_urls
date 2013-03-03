json.array!(@urls) do |url|
  json.extract! url, :access_token
  json.url url_url(url, format: :json)
end