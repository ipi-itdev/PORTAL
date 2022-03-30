class TmsdetailremoveController < ApplicationController
  def index
    if params[:tms_type] == 'ob'
      get_tms_rec = PortalObApplicationDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_ob_application_details_path and return

    elsif params[:tms_type] == 'ot'
      get_tms_rec = PortalOtApplicationDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_ot_application_details_path and return

    elsif params[:tms_type] == 'leave'
      get_tms_rec = PortalLeaveApplicationDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_leave_application_details_path and return

    elsif params[:tms_type] == 'tre'
      get_tms_rec = PortalTreApplicationDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all
  
      redirect_to portal_tre_application_details_path and return

    elsif params[:tms_type] == 'changerequest'
      get_tms_rec = PortalChangeRequestDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_change_request_details_path and return

    elsif params[:tms_type] == 'dtrupload'
      get_tms_rec = PortalDtrUploadDetail.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_dtr_upload_details_path and return

    elsif params[:tms_type] == 'dependent'
      get_tms_rec = PortalDependent.where(ID: params[:detail_refno].to_i)
      get_tms_rec.destroy_all

      redirect_to portal_dependents_path and return
    end
  end
end
  