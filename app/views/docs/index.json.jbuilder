json.array!(@docs) do |doc|
  json.extract! doc, :id, :title, :topic, :license, :description, :filepicker_url
  json.url doc_url(doc, format: :json)
end
