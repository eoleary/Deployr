class GhUser < ActiveRecord::Base
  has_many :repositories, :foreign_key => :owner_id
  has_many :commits, :foreign_key => :author_id
end
