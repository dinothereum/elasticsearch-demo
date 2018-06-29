require 'elasticsearch/model'

class Article < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
      indexes :text, analyzer: 'english'
    end
  end
# search theo 2 truong title vaf text nen khai bao ca 2 truong tren indexes sau do khai bao fields: ['title^10', 'text']
  def self.search query
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title', 'text']
          }
        },
        highlight: {
          pre_tags: ['<mark>'],
          post_tags: ['</mark>'],
          fields: {
            title: {},
            text: {}
          }
        }
      }
    )
  end

  def self.normal_search query
    Article.where("title LIKE (?) OR text LIKE (?)", "%#{query}%", "%#{query}%")
  end
end

# Delete the previous articles index in Elasticsearch
Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

# Create the new index with the new mapping
Article.__elasticsearch__.client.indices.create \
  index: Article.index_name,
  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Article.import
