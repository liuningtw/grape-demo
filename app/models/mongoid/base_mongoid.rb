module Mongoid
  module BaseModel
    extend ActiveSupport::Concern

    included do
      scope :recent, -> { desc(:create_at) }
    end

    module ClassMethods
      def _search_(k, v)
        if k && v
          where({ k => /.*#{v}.*/i })
        else
          all
        end
      end

      alias_method :like, :_search_
    end
  end
end