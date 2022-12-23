class PortalHomeposterDetail < ApplicationRecord
	self.table_name = 'PORTAL_HomePoster_Details_U'
	mount_uploader :Image, ImageUploader
	validates :Image, :Description, presence: true


	validate :CheckSeqNumber, on: :create
	validate :CheckSeqNumber_OnEdit, on: :update


	def rec_id
		read_attribute(:id)
	end

	def seqnum
		read_attribute(:SeqNumber)
	end

	def homeposterrefno
		read_attribute(:HomePosterRefno)
	end

	def get_id
		read_attribute(:get_id)
	end


	def CheckSeqNumber_OnEdit
		check_exists_id = ActiveRecord::Base.connection.exec_query("select * from PORTAL_HomePoster_Details_U phpdu where id != #{rec_id} and SeqNumber = #{seqnum} and HomePosterRefno = #{homeposterrefno}").count
		if check_exists_id > 0
			errors[:base] << "Sequence Number Already Exists - Seq.# #{seqnum} "
		end 
	end

	def CheckSeqNumber
		if PortalHomeposterDetail.where(HomePosterRefno: homeposterrefno, SeqNumber: seqnum, ).exists? == true
			errors[:base] << "Sequence Number Already Exists "
		end  
	end



end
