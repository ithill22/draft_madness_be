class ArticleSerializer
  include JSONAPI::Serializer
  attributes :headline, :url, :date
end