class PortalContactDetail < ApplicationRecord
	self.table_name = 'PORTAL_ContactDetails_C'

	self.primary_key = "ID"

	HUMANIZED_ATTRIBUTES = {
		:EmergencyName1 => "Primary Emergency Contact Name",
		:EmergencyAddress1 => "Primary Emergency Contact Address",
		:EmergencyEmail1 => "Primary Emergency Contact Email",
		:EmergencyContactNo1 => "Primary Emergency Contact No.", 
		:EmergencySecondaryContact1 => "Primary Emergency Secondary Contact No", 		
		:EmergencyRelationship1 => "Primary Emergency Relationship",
		:EmergencyName2 => "Secondary Emergency Contact Name",
		:EmergencyAddress2 => "Secondary Emergency Contact Address",
		:EmergencyEmail2 => "Secondary Emergency Contact Email",
		:EmergencyContactNo2 => "Secondary Emergency Contact No.", 
		:EmergencySecondaryContact2 => "Secondary Emergency Secondary Contact No", 		
		:EmergencyRelationship2 => "Secondary Emergency Relationship",	                          
		:PersonalEmailAddress => "Primary Email",  
		:PresentAddress => "Present Address", 
		:PermanentAddress => "Permanent Address",
		:MobileNumber => "Primary Mobile No.", 
		:MobileNumber2 => "Secondary Mobile No.",  
		:TelephoneNumber => "Landline No.", 		
		:WorkEmailAddress => "Secondary Email"
	  }
	
	  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	  end

	validates :EmergencyName1, :EmergencyAddress1, :EmergencyContactNo1, :EmergencyRelationship1, :EmergencyName2, :EmergencyAddress2, :EmergencyContactNo2, :EmergencyRelationship2,	                          
	:PersonalEmailAddress, :MobileNumber, :PermanentAddress, presence: true

	validates :EmergencyContactNo1, :EmergencyContactNo2, :MobileNumber, :MobileNumber2,
		format: { with: /\A\d{4}-?\d{3}-?\d{4}\z/ }, allow_blank: true		
		
	validates :EmergencyEmail1, :EmergencyEmail2, :PersonalEmailAddress, :WorkEmailAddress,
		format: { with: /.+\@.+\..+/ }, allow_blank: true

	validate :checkContact, on: :update

	def permanentbrgyrefno
		read_attribute(:PermanentBrgyRefNo)
	end

	def presentbrgyrefno
		read_attribute(:PresentBrgyRefNo)
	end

	def permanentmunicipalityrefno
		read_attribute(:PermanentMunicipalityRefNo)
	end

	def presentmunicipalityrefno
		read_attribute(:PresentMunicipalityRefNo)
	end

	def permanentprovincerefno
		read_attribute(:PermanentProvinceRefNo)
	end

	def presentprovincerefno
		read_attribute(:PresentProvinceRefNo)
	end

	def permanentregionrefno
		read_attribute(:PermanentRegionRefNo)
	end

	def presentregionrefno
		read_attribute(:PresentRegionRefNo)
	end

	def permanentaddress
		read_attribute(:PermanentAddress)
	end

	def presentaddress
		read_attribute(:PresentAddress)
	end

	def issame
		read_attribute(:IsSame)
	end

	def emergencyname1
		read_attribute(:EmergencyName1)
	end

	def emergencyname2
		read_attribute(:EmergencyName2)
	end

	def emergencycontactno1
		read_attribute(:EmergencyContactNo1)
	end

	def emergencycontactno2
		read_attribute(:EmergencyContactNo2)
	end

	def emergencysecondarycontactno1
		read_attribute(:EmergencySecondaryContact1)
	end

	def emergencysecondarycontactno2
		read_attribute(:EmergencySecondaryContact2)
	end

	def checkContact
		if emergencyname1.squish.downcase == emergencyname2.squish.downcase
			errors[:base] << "Emergency contact name can't be the same"
		end

		if emergencysecondarycontactno1.blank? == false && emergencyname1.gsub('(','').gsub(')','').gsub('-','') == emergencysecondarycontactno1.gsub('(','').gsub(')','').gsub('-','') 
			errors[:base] << "Emergency contact number can't be the same"
		end

		if emergencysecondarycontactno2.blank? == false && emergencyname2.gsub('(','').gsub(')','').gsub('-','') == emergencysecondarycontactno2.gsub('(','').gsub(')','').gsub('-','') 
			errors[:base] << "Emergency contact number can't be the same"
		end
		
		if emergencycontactno1.gsub('(','').gsub(')','').gsub('-','') == emergencycontactno2.gsub('(','').gsub(')','').gsub('-','') 
			errors[:base] << "Emergency contact number can't be the same"
		end

		if permanentaddress.blank? == true || (issame == false && presentaddress.blank? == true)
			errors[:base] << "Address can't be blank"
		end

		if permanentregionrefno == 0 || (issame == false && presentregionrefno == 0)
			errors[:base] << "Region can't be blank"
		end

		if permanentprovincerefno == 0 || (issame == false && presentprovincerefno == 0)
			errors[:base] << "Province can't be blank"
		end

		if permanentmunicipalityrefno == 0 || (issame == false && presentmunicipalityrefno == 0)
			errors[:base] << "Municipality can't be blank"
		end

		if permanentbrgyrefno == 0 || (issame == false && presentbrgyrefno == 0)
			errors[:base] << "Barangay can't be blank"
		end
	end
end 


