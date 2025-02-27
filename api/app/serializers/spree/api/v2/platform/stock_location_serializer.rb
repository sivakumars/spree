module Spree
  module Api
    module V2
      module Platform
        class StockLocationSerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :name

          has_many :shipments
          has_many :stock_items
        end
      end
    end
  end
end
