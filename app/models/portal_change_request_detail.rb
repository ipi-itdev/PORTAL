class PortalChangeRequestDetail < ApplicationRecord
	self.table_name = 'PORTAL_EmployeeProfileChangeRequestDetails_C'

	mount_uploader :AttachmentFile, AttachmentUploader

	validate :CheckRequest, on: :create
	validate :CheckRequestEdit, on: :update

	def changerequesttyperefno
		read_attribute(:ChangeRequestTypeRefNo)
	end

	def attachmentfile
		read_attribute(:AttachmentFile)
	end

	def requirementrefno
		read_attribute(:RequirementRefNo)
	end

	def ischeck
		read_attribute(:IsCheck)
	end

	def currentaddress
		read_attribute(:CurrentAddress)
	end

	def permanentaddress
		read_attribute(:PermanentAddress)
	end

	def telephonenumber
		read_attribute(:TelephoneNumber)
	end

	def mobilenumber
		read_attribute(:MobileNumber)
	end

	def personalemailaddress
		read_attribute(:PersonalEmailAddress)
	end

	def emergencyname
		read_attribute(:EmergencyName)
	end

	def emergencyaddress
		read_attribute(:EmergencyAddress)
	end

	def emergencycontactnumber
		read_attribute(:EmergencyContactNumber)
	end

	def emergencyrelationship
		read_attribute(:EmergencyRelationship)
	end

	def tin
		read_attribute(:TIN)
	end

	def sss
		read_attribute(:SSS)
	end

	def pagibig
		read_attribute(:Pagibig)
	end

	def philhealth
		read_attribute(:Philhealth)
	end

	def depname
		read_attribute(:DepName)
	end

	def depbirthdate
		read_attribute(:DepBirthDate)
	end

	def deprelationship
		read_attribute(:DepRelationship)
	end

	def school
		read_attribute(:School)
	end

	def course
		read_attribute(:Course)
	end

	def yeargraduated
		read_attribute(:YearGraduated)
	end

	def CheckRequest	
		if permanentaddress.blank? == true && changerequesttyperefno == 1
			errors[:base] << 'Permanent address is required'

		elsif currentaddress.blank? == true && changerequesttyperefno == 1
			errors[:base] << 'Current address is required'

		elsif mobilenumber.blank? == true && changerequesttyperefno == 2
			errors[:base] << 'Mobile number is required'

		elsif personalemailaddress.blank? == true && changerequesttyperefno == 3
			errors[:base] << 'Personal email address is required'

		#elsif changerequesttyperefno ==3
		#	validates :PersonalEmailAddress, email: true

		elsif (emergencyaddress.blank? == true || emergencyrelationship.blank? == true || emergencyname.blank? == true || emergencycontactnumber.blank? == true) && changerequesttyperefno == 4
			errors[:base] << 'Please fill up all field'

		elsif tin.blank? == true && sss.blank? == true && philhealth.blank? == true && pagibig.blank? == true && changerequesttyperefno == 5
			errors[:base] << 'Please fill up atleast one field'

		elsif (deprelationship.blank? == true || depname.blank? == true || depbirthdate.blank? == true) && changerequesttyperefno == 6
			errors[:base] << 'Please fill up all field'

		elsif (school.blank? == true || yeargraduated.blank? == true || course.blank? == true) && changerequesttyperefno == 7
			errors[:base] << 'Please fill up all field'

		elsif requirementrefno == 0 && changerequesttyperefno == 8
			errors[:base] << 'Requirement type is required'
	
		elsif attachmentfile.blank? == true && changerequesttyperefno == 8
			errors[:base] << 'Attachment is required'
		end
	end

	def CheckRequestEdit	
		if permanentaddress.blank? == true && changerequesttyperefno == 1
			errors[:base] << 'Permanent address is required'

		elsif currentaddress.blank? == true && changerequesttyperefno == 1
			errors[:base] << 'Current address is required'

		elsif mobilenumber.blank? == true && changerequesttyperefno == 2
			errors[:base] << 'Mobile number is required'

		elsif personalemailaddress.blank? == true && changerequesttyperefno == 3
			errors[:base] << 'Personal email address is required'

		elsif personalemailaddress.blank? == true && changerequesttyperefno == 3
			errors[:base] << 'Personal email address is required'

		elsif emergencyaddress.blank? == true && emergencyrelationship.blank? == true && emergencyname.blank? == true && emergencycontactnumber.blank? == true && changerequesttyperefno == 4
			errors[:base] << 'Please fill up all field'

		elsif deprelationship.blank? == true && depname.blank? == true && depbirthdate.blank? == true && changerequesttyperefno == 6
			errors[:base] << 'Please fill up all field'

		elsif school.blank? == true && yeargraduated.blank? == true && course.blank? == true && changerequesttyperefno == 7
			errors[:base] << 'Please fill up all field'

		elsif requirementrefno == 0 && changerequesttyperefno == 8
			errors[:base] << 'Requirement type is required'
	
		elsif attachmentfile.blank? == true && changerequesttyperefno == 8
			errors[:base] << 'Attachment is required'
		end
	end
end