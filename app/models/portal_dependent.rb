class PortalDependent < ApplicationRecord
	self.table_name = 'Portal_EmployeeDependents_U'

	validates :Description, :BirthDate, :Relationship, presence: true

	HUMANIZED_ATTRIBUTES = {
		:Description => "Name",	
		:BirthDate => "Birth Date"
	  }
	
	  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	  end
end


