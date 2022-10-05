module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
  
      # def as_indexed_json(options = {})
      #   self.as_json(
      #     options.merge(
      #       only: [Body],
      #       include: { chat: { only: [:Number] } }
      #     )
      #   )
      # end
      # mapping dynamic: :strict do
      #    indexes :Body, type: :text
      #    indexes :chat do
      #     indexes :Number, type: :keyword
      #   end
      # end

  
      def self.search(query)
        self.__elasticsearch__.search(query)
      end
    end
  end