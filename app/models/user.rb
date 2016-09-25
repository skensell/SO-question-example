class User < ActiveRecord::Base

  has_many :avatars, -> { order([:sort_order => :asc,:created_at => :asc])}

end
