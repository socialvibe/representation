class ActiveRecord::Base
  self.include_root_in_json = false
end

class User < ActiveRecord::Base
  has_one :address
  has_many :titles

  def calculated_age
    age * 2
  end
end

class Address < ActiveRecord::Base
  belongs_to :user
end

class Title < ActiveRecord::Base
  belongs_to :user
end

def destroy_models
  Object.send(:remove_const, :User)
  Object.send(:remove_const, :Address)
end
