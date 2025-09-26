class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  self.attributes_for_inspect = :all
end
