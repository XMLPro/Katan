class GameResource < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource_type
end
