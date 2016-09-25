class User < ActiveRecord::Base

  has_many :avatars, -> { order([:sort_order => :asc,:created_at => :asc])}

  has_many :user_industries
  has_many :industries, through: :user_industries

end
