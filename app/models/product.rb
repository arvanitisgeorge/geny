class Product < ApplicationRecord
  validates :title, :summary, :description, :initial_value, :final_value, presence: true

end
