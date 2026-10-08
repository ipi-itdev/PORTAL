# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_04_053011) do

  create_table "GEN_Action_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ActionRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_AuditTrail_C", primary_key: "ID", id: :bigint, force: :cascade do |t|
    t.varchar "RecordRefNo", limit: 50
    t.varchar "TableName", limit: 50
    t.varchar "FieldName", limit: 50
    t.varchar_max "OldValue"
    t.varchar_max "NewValue"
    t.integer "CreatedByID"
    t.datetime "CreateDate", null: false
    t.varchar "Action", limit: 50
    t.varchar "HostName", limit: 50
    t.varchar "MacAddress", limit: 50
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_AutoEmail_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "AutoEmailRefNo"
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "CC", limit: 500
    t.varchar "BCC", limit: 500
    t.varchar "Sender", limit: 500
    t.datetime "Time"
    t.integer "DaysBeforeAfter"
    t.integer "EmailType"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Bank_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 50
    t.varchar "AccountFormat", limit: 50, default: "", null: false
    t.varchar "EmployeeAccountFormat", limit: 50, default: "", null: false
    t.boolean "TransmitalZeroValue", default: false, null: false
    t.varchar "InitialBankName", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "BankRefNo", null: false
    t.varchar "Code", limit: 10
  end

  create_table "GEN_BloodType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "BloodTypeRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_BonusType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "BonusTypeRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_COETemplate_U", primary_key: ["ServerCompanyCodeID", "COETemplateRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "COETemplateRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "GEN_City_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "CityRefNo", null: false
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "GEN_CivilStatus_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "CivilStatusRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_ClientAccount_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ClientAccountRefNo", null: false
    t.varchar "Code", limit: 20
    t.varchar "Description", limit: 1000
    t.varchar "ClientAddress", limit: 1500
    t.varchar "ContactPerson", limit: 500
    t.varchar "ContactNumber", limit: 50
    t.varchar "EmailAddress", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "MRRefNo"
    t.integer "DepartmentRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Company_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "CompanyRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.string "Logo"
    t.varchar "LogoFilename", limit: 150
    t.varchar "LogoImageSize", limit: 50
    t.varchar "LogoFilesize", limit: 50
    t.boolean "isMain", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.decimal "TaxNumber", precision: 38, scale: 0
    t.decimal "SSSNumber", precision: 38, scale: 0
    t.decimal "PhilhealthNumber", precision: 38, scale: 0
    t.decimal "PagibigNumber", precision: 38, scale: 0
  end

  create_table "GEN_Computation_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ComputationRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Department_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DepartmentRefNo", null: false
    t.varchar "Code", limit: 10
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_DisciplinaryAction_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DisciplinaryActionRefNo", null: false
    t.varchar "Description", limit: 50
    t.integer "SuspensionNoOfDays", default: 0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_EmployeeGroup_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeGroupRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_EmployeeStatus_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeStatusRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_EmployeeType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeTypeRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.boolean "ConfidentialTag", default: false, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.decimal "MininumHours", precision: 18, scale: 2
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_EmploymentStatus_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmploymentStatusRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "FixedTax", default: false, null: false
    t.integer "PercentOver", default: 0, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_FOW_M", primary_key: ["ServerCompanyCodeID", "FOWRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "FOWRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
  end

  create_table "GEN_FilingStatus_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "FilingStatusRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Frequency_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "FrequencyRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Gender_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "GenderRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_HolidayType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HolidayTypeRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Holiday_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HolidayRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.integer "HolidayTypeRefNo", null: false
    t.datetime "HolidayDate"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "AreaRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.boolean "IsConstant"
  end

  create_table "GEN_JobFunction_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "JobFunctionRefNo", null: false
    t.varchar "Code", limit: 100
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1"
    t.integer "JobPositionRefNo", null: false
  end

  create_table "GEN_JobPosition_M", primary_key: "JobPositionRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "Code", limit: 100
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsIT", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_LeaveAccrualSetupDtl_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveAccrualSetupDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "LeaveTypeRefNo"
    t.integer "AccrualTypeRefNo"
    t.integer "ReferenceDateRefNo"
    t.varchar "LeaveAccrualSetupHdrRefNo", limit: 50
    t.integer "AccrualDateRefNo"
    t.integer "ConversionRefNo"
    t.boolean "IsPercent"
    t.decimal "ConvPercent", precision: 18, scale: 2
    t.decimal "InitialValue", precision: 18, scale: 4
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_LeaveType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveTypeRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.boolean "WithPay"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_MR_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 5, default: "1-1", null: false
    t.integer "MRRefNo"
    t.integer "EmployeeRefNo"
    t.varchar "Code", limit: 500
  end

  create_table "GEN_MalayanCoverage_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "MalayanCoverageRefNo", null: false
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Menu_F", primary_key: "MenuRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.boolean "PISTag"
    t.boolean "TMSTag"
    t.boolean "PAYTag"
    t.boolean "BIOTag"
    t.boolean "RECTag"
    t.varchar "Description", limit: 100
    t.integer "ParentID"
    t.varchar_max "MenuGroup"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ControlName", limit: 50
    t.integer "SeqNo"
  end

  create_table "GEN_Month_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "MonthRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Nationality_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "NationalityRefNo", null: false
  end

  create_table "GEN_Offense_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "OffenseTitle", limit: 50
    t.varchar_max "Description"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "OffenseRefNo", null: false
  end

  create_table "GEN_RLTreatment_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "RLTreatmentRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_ReasonForChange_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "ReasonForChangeRefNo", null: false
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "GEN_ReasonForSeperation_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ReasonForSeperationRefNo", null: false
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_ReferenceID_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "ReferenceCode", limit: 50, null: false
    t.integer "ReferenceIDRefNo"
    t.bigint "SequenceNo", default: 1, null: false
    t.varchar "Prefix", limit: 50, default: "NO PREFIX", null: false
    t.integer "Digits", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.integer "LastReset"
    t.integer "UIResetTag", default: 0, null: false
    t.boolean "IsReport", default: false, null: false
    t.integer "OrderNameRefNo1", default: 0, null: false
    t.integer "OrderNameRefNo2", default: 0, null: false
    t.integer "OrderNameRefNo3", default: 0, null: false
    t.integer "OrderNameRefNo4", default: 0, null: false
    t.integer "OrderNameRefNo5", default: 0, null: false
    t.integer "OrderNameRefNo6", default: 0, null: false
    t.integer "OrderNameRefNo7", default: 0, null: false
    t.integer "OrderNameRefNo8", default: 0, null: false
    t.integer "OrderNameRefNo9", default: 0, null: false
    t.integer "OrderNameRefNo10", default: 0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_Religion_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "ReligionRefNo", null: false
  end

  create_table "GEN_Roles_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "RolesRefNo", null: false
    t.varchar "Description", limit: 100
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_SPaymentTerms_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SPaymentTermsRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_ServerCompanyCode_M", primary_key: ["ServerCompanyCodeID", "ServerRefNo", "CompanyRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.string "ServerCompanyCodeID", limit: 50, null: false
    t.integer "ServerRefNo", null: false
    t.integer "CompanyRefNo", null: false
    t.integer "ServerCompanyCodeRefNo", null: false
    t.varchar "Code", limit: 5
    t.boolean "isMain", default: false, null: false
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "GEN_Server_M", primary_key: "ServerRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.boolean "isMain", default: false, null: false
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "GEN_SystemSettings_C", id: false, force: :cascade do |t|
    t.integer "DLLVersion"
  end

  create_table "GEN_TaxStatus_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TaxStatusRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.decimal "TaxExemptPerc", precision: 18, scale: 4
    t.integer "NoOfDefendent", default: 0, null: false
    t.decimal "PersonalExemption", precision: 18, scale: 2
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_UserAccount_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "UserAccountRefNo", null: false
    t.integer "EmployeeRefNo"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "UserName", limit: 50
    t.varchar "Password", limit: 50
    t.integer "RolesRefNo", default: 0, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "GEN_UserRoles_U", primary_key: "UserRolesRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.integer "RolesRefNo"
    t.integer "MenuRefNo"
    t.varchar "Description", limit: 100
    t.boolean "AllowView"
    t.boolean "AllowInsert"
    t.boolean "AllowUpdate"
    t.boolean "AllowDelete"
    t.boolean "AllowPrint"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ControlName", limit: 50
  end

  create_table "LAS", id: false, force: :cascade do |t|
    t.float "EmployeeRefNo"
    t.string "Name", limit: 255
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "LastDateofEmployment"
    t.string "Reason", limit: 255
  end

  create_table "MasterList", id: false, force: :cascade do |t|
    t.string "MR", limit: 255
    t.string "Client", limit: 255
    t.string "emp_id", limit: 255
    t.string "Personnel", limit: 255
    t.string "field_of_work", limit: 255
    t.string "Expertise", limit: 255
    t.string "Type", limit: 255
    t.float "client_rate"
    t.float "rate"
    t.datetime "HiringDate"
    t.datetime "StartDate"
    t.datetime "EndDate"
  end

  create_table "Masterlist072018", id: false, force: :cascade do |t|
    t.string "MR", limit: 255
    t.string "Client", limit: 255
    t.string "emp_id", limit: 255
    t.string "Personnel", limit: 255
    t.string "Expertise", limit: 255
    t.string "Type", limit: 255
    t.float "client_rate"
    t.float "rate"
    t.datetime "HiringDate"
    t.datetime "StartDate"
    t.datetime "EndDate"
  end

  create_table "PAR_JobDescription_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar_max "Description"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "PARRefNo"
  end

  create_table "PAR_Terms_U", primary_key: ["ServerCompanyCodeID", "TermsRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "TermsRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PAY_AnnualTax_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "AnnualTaxRefNo", null: false
    t.decimal "TaxRate", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "RangeFrom", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "RangeTo", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "ExcessOf", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.decimal "BaseTax", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_BonusesDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "BonusesDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "BonusesRefNo"
    t.integer "EmployeeRefNo"
    t.decimal "Amount", precision: 18, scale: 4
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_Bonuses_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "BonusesRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "FilingStatusRefNo"
    t.integer "ComputationRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.datetime "ReleaseDate"
    t.integer "EmployeeGroupRefNo"
  end

  create_table "PAY_ECOLAComputation_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ECOLAComputationRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_ECOLARate_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.decimal "ECOLAAmount", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "ECOLARateRefNo", null: false
  end

  create_table "PAY_EmployeePayItemHistory_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeePayItemRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.integer "PaymentTermsRefNo", null: false
    t.decimal "PayItemAmount", precision: 18, scale: 4, null: false
    t.boolean "IncludePayrollTag", default: true, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "ProcessedPayrollRefNo"
    t.datetime "PayPeriodDate"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.boolean "IsDeduction"
    t.integer "PayItemTypeRefNo"
  end

  create_table "PAY_EmployeePayItem_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeePayItemRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.integer "LeaveConversionRefNo", default: 0, null: false
    t.integer "ThirteenthMonthRefNo", null: false
    t.integer "SpecialPayrollRefNo", default: 0, null: false
    t.integer "PaymentTermsRefNo", null: false
    t.decimal "PayItemAmount", precision: 18, scale: 4, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "HoldPaymentTag", default: false, null: false
    t.integer "FilingStatusRefNo"
    t.integer "LeaveAdjustmentRefNo"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.varchar "PayItem", limit: 500
    t.boolean "IsDeduction"
    t.boolean "IsFixed"
    t.boolean "IsTaxable"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "PayItemTypeRefNo"
  end

  create_table "PAY_FinalPay_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.decimal "BasicRate", precision: 18, scale: 2, null: false
    t.varchar "PayBasis", limit: 5, null: false
    t.decimal "BasicPay", precision: 18, scale: 2, null: false
    t.decimal "BasicNetPay", precision: 18, scale: 2, null: false
    t.decimal "GrossPay", precision: 18, scale: 2, null: false
    t.decimal "TotalDeductions", precision: 18, scale: 2, null: false
    t.decimal "GrossNetPay", precision: 18, scale: 2, null: false
    t.decimal "TaxableIncome", precision: 18, scale: 2, null: false
    t.decimal "WithHoldingTax", precision: 18, scale: 2, null: false
    t.decimal "NetPay", precision: 18, scale: 2, null: false
    t.decimal "SSS", precision: 18, scale: 2, null: false
    t.decimal "Pagibig", precision: 18, scale: 2, null: false
    t.decimal "PhilHealth", precision: 18, scale: 2, null: false
    t.decimal "E_SEA", precision: 18, scale: 2, null: false
    t.decimal "E_EcolaRate", precision: 18, scale: 2, null: false
    t.decimal "E_FixedEarning", precision: 18, scale: 2, null: false
    t.decimal "E_FixedNTEarning", precision: 18, scale: 2, null: false
    t.decimal "E_OtherEarning", precision: 18, scale: 2, null: false
    t.decimal "E_OtherNTEarning", precision: 18, scale: 2, null: false
    t.decimal "D_FixedDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_FixedNTDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_OtherDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_OtherNTDeduction", precision: 18, scale: 2, null: false
    t.decimal "TotalOT", precision: 18, scale: 2, null: false
    t.decimal "TotalRD", precision: 18, scale: 2, null: false
    t.decimal "TotalHOL", precision: 18, scale: 2, null: false
    t.decimal "SSSLoan", precision: 18, scale: 2, null: false
    t.decimal "PAGIBIGLoan", precision: 18, scale: 2, null: false
    t.decimal "OTHLoan", precision: 18, scale: 2, null: false
    t.decimal "ThirteenthMonthPay", precision: 18, scale: 2, null: false
    t.integer "Year", null: false
    t.integer "EmployeeRefNo", null: false
    t.boolean "IsActive", default: true, null: false
    t.datetime "DateTimeCreated", default: -> { "getdate()" }, null: false
    t.datetime "DateTimeModified", default: -> { "getdate()" }, null: false
    t.decimal "LWP", precision: 18, scale: 2
    t.decimal "ND", precision: 18, scale: 2
    t.decimal "AH", precision: 18, scale: 2
    t.decimal "LH", precision: 18, scale: 2
    t.decimal "UT", precision: 18, scale: 2
    t.integer "FilingStatusRefNo", default: 1, null: false
    t.decimal "TaxRefund", precision: 18, scale: 2, default: 0.0, null: false
    t.integer "Month"
    t.datetime "FinalPayrollDate"
  end

  create_table "PAY_HDMFExportDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HDMFExportDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.decimal "EmpAmt", precision: 18, scale: 4
    t.decimal "EmpyrAmt", precision: 18, scale: 4
    t.integer "HDMFExportRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_HDMFExport_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HDMFExportRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "CompanyRefNo"
    t.integer "MonthRefNo"
    t.integer "Year"
    t.varchar "ORNo", limit: 100
    t.datetime "DatePaid"
    t.integer "FilingStatusRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_HDMFLoanExportDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HDMFLoanExportDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.decimal "EmpAmt", precision: 18, scale: 4
    t.integer "EmployeeRefNo"
    t.integer "HDMFLoanExportRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_HDMFLoanExport_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "HDMFLoanExportRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "FilingStatusRefNo"
    t.integer "MonthRefNo"
    t.integer "Year"
    t.datetime "DatePaid"
    t.varchar "SBRNo", limit: 50
    t.decimal "SBRAmount", precision: 18, scale: 4
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LeaveConversionDTL_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveConversionDTLRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeePayItemRefNo"
    t.integer "EmployeeRefNo"
    t.decimal "LeaveAvailable", precision: 18, scale: 4
    t.integer "LeaveConversionRefNo"
    t.decimal "LeaveConvert", precision: 18, scale: 4
    t.decimal "LeaveCredits", precision: 18, scale: 4
    t.decimal "LeaveTaken", precision: 18, scale: 4
    t.integer "LeaveTypeRefNo"
    t.decimal "Amount", precision: 18, scale: 4
    t.decimal "DailyRate", precision: 18, scale: 4
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LeaveConversion_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveConversionRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "LeaveTypeRefNo"
    t.integer "MonthRefNo"
    t.integer "PayItemRefNo"
    t.integer "PayrollScheduleRefNo"
    t.integer "Year"
    t.integer "FilingStatusRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LoanApplication_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LoanApplicationRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.integer "LoanTypeRefNo", null: false
    t.varchar "LoanApplicationNo", limit: 15, null: false
    t.decimal "PrincipalLoanAmount", precision: 18, scale: 4, null: false
    t.decimal "LoanTotalAmount", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LoanBalance", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LoanDeduction", precision: 18, scale: 4, default: 0.0, null: false
    t.datetime "IssueDate", null: false
    t.datetime "StartDate", null: false
    t.boolean "HoldPaymentTag", default: false, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "FilingStatusRefNo"
    t.integer "PaymentTermsRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LoanCode_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LoanCodeRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LoanLedger_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.integer "ProcessedPayrollRefNo", null: false
    t.integer "LoanApplicationRefNo", null: false
    t.integer "FilingStatusRefNo", null: false
    t.decimal "LoanBalance", precision: 18, scale: 4, null: false
    t.decimal "LoanDeduction", precision: 18, scale: 4, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_LoanType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LoanTypeRefNo", null: false
    t.integer "LoanCodeRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PHICMonthlyDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PHICMonthlyDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.varchar "RefNo", limit: 100
    t.decimal "MonthLyRate", precision: 18, scale: 4
    t.decimal "PSAmt", precision: 18, scale: 4
    t.decimal "ESAmt", precision: 18, scale: 4
    t.integer "PHICMonthlyRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PHICMonthly_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PHICMonthlyRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "CompanyRefno"
    t.integer "MonthRefNo"
    t.integer "Year"
    t.datetime "DatePaid"
    t.integer "FilingStatusRefNo"
    t.varchar "MonthReferenceNo", limit: 50
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PagIbig_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PagIbigRefNo", null: false
    t.decimal "CompensationFrom", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "CompensationTo", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PercentOver", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployerShare", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployeeShare", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayBasis_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayBasisRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayItemCategory_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayItemCategoryRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayItemType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayItemTypeRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.boolean "IsTaxable"
    t.boolean "IsStatutory"
    t.boolean "IncludeTo13MonthPay"
    t.boolean "IsDeminimis"
    t.decimal "DeminimisCeilingPerAnnum", precision: 18, scale: 2
  end

  create_table "PAY_PayItem_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayItemRefNo", null: false
    t.integer "PayItemCategoryRefNo", null: false
    t.varchar "Description", limit: 50, null: false
    t.boolean "TaxableTag", default: false, null: false
    t.boolean "YearEndTag", default: false, null: false
    t.boolean "FixedTag", default: false, null: false
    t.boolean "Annualized", default: false, null: false
    t.varchar "AccountCode", limit: 20
    t.varchar "W2Code", limit: 20
    t.varchar "AlphalistDesc", limit: 100
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.boolean "SpecialPayrollTag", default: false, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PaymentTerms_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PaymentTermsRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayrollParameterDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayrollParameterDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "PayrollParameterRefNo"
    t.integer "PaymentTermsRefNo"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "PayrollDate"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayrollParameter_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayrollParameterRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayrollParameters_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayrollParametersRefNo", null: false
    t.integer "WTaxPaymentTerms", null: false
    t.integer "SSSPaymentTerms", null: false
    t.integer "PhilHealthPaymentTerms", null: false
    t.integer "PagIbigPaymentTerms", null: false
    t.integer "SSSPayrollReference", null: false
    t.integer "PhilHealthPayrollReference", null: false
    t.integer "PagIbigPayrollReference", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.integer "PayrollParameterRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PayrollRate_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayrollRateRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.decimal "TotalDays", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalMonths", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.decimal "TotalDaysPerMonth", precision: 38, scale: 20
  end

  create_table "PAY_PayrollReference_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PayrollReferenceRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_PhilHealth_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PhilHealthRefNo", null: false
    t.decimal "CompensationFrom", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "CompensationTo", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PercentOver", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployerShare", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployeeShare", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_ProcessedPayroll_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ProcessedPayrollRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.decimal "BasicRate", precision: 18, scale: 2
    t.varchar "PayBasis", limit: 5
    t.decimal "BasicPay", precision: 18, scale: 2, null: false
    t.decimal "BasicNetPay", precision: 18, scale: 2, null: false
    t.decimal "GrossPay", precision: 18, scale: 2, null: false
    t.decimal "TotalDeductions", precision: 18, scale: 2, null: false
    t.decimal "GrossNetPay", precision: 18, scale: 2
    t.decimal "TaxableIncome", precision: 18, scale: 2, null: false
    t.decimal "WithHoldingTax", precision: 18, scale: 2, null: false
    t.decimal "NetPay", precision: 18, scale: 2, null: false
    t.decimal "SSS_EE", precision: 18, scale: 2, null: false
    t.decimal "SSS_ER", precision: 18, scale: 2
    t.decimal "SSS_TC", precision: 18, scale: 2
    t.decimal "Pagibig_EE", precision: 18, scale: 2, null: false
    t.decimal "Pagibig_ER", precision: 18, scale: 2
    t.decimal "Pagibig_TC", precision: 18, scale: 2
    t.decimal "PhilHealth_EE", precision: 18, scale: 2, null: false
    t.decimal "PhilHealth_ER", precision: 18, scale: 2
    t.decimal "PhilHealth_TC", precision: 18, scale: 2
    t.decimal "E_SEA", precision: 18, scale: 2, null: false
    t.decimal "E_EcolaRate", precision: 18, scale: 2, null: false
    t.decimal "E_FixedEarning", precision: 18, scale: 2, null: false
    t.decimal "E_FixedNTEarning", precision: 18, scale: 2, null: false
    t.decimal "E_Total_FixedEarning", precision: 18, scale: 2, null: false
    t.decimal "E_OtherEarning", precision: 18, scale: 2, null: false
    t.decimal "E_OtherNTEarning", precision: 18, scale: 2, null: false
    t.decimal "E_Total_OtherEarning", precision: 18, scale: 2, null: false
    t.decimal "D_FixedDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_FixedNTDeduction", precision: 18, scale: 2
    t.decimal "D_Total_FixedDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_OtherDeduction", precision: 18, scale: 2, null: false
    t.decimal "D_OtherNTDeduction", precision: 18, scale: 2
    t.decimal "D_Total_OtherDeduction", precision: 18, scale: 2, null: false
    t.decimal "RH", precision: 18, scale: 2, null: false
    t.decimal "GP", precision: 18, scale: 2, null: false
    t.decimal "LH", precision: 18, scale: 2, null: false
    t.decimal "UT", precision: 18, scale: 2, null: false
    t.decimal "LWP", precision: 18, scale: 2, null: false
    t.decimal "LWOP", precision: 18, scale: 2, null: false
    t.decimal "AH", precision: 18, scale: 2, null: false
    t.decimal "OT", precision: 18, scale: 2, null: false
    t.decimal "ND", precision: 18, scale: 2, null: false
    t.decimal "NDOT", precision: 18, scale: 2, null: false
    t.decimal "RDOT", precision: 18, scale: 2, null: false
    t.decimal "RDOTEX8", precision: 18, scale: 2, null: false
    t.decimal "RDOTND", precision: 18, scale: 2
    t.decimal "RDOTEX8ND", precision: 18, scale: 2, null: false
    t.decimal "LHOT", precision: 18, scale: 2, null: false
    t.decimal "LHOTEX8", precision: 18, scale: 2, null: false
    t.decimal "LHOTND", precision: 18, scale: 2
    t.decimal "LHOTEX8ND", precision: 18, scale: 2, null: false
    t.decimal "RDLHOT", precision: 18, scale: 2, null: false
    t.decimal "RDLHOTEX8", precision: 18, scale: 2, null: false
    t.decimal "RDLHOTND", precision: 18, scale: 2
    t.decimal "RDLHOTEX8ND", precision: 18, scale: 2, null: false
    t.decimal "SHOT", precision: 18, scale: 2, null: false
    t.decimal "SHOTEX8", precision: 18, scale: 2, null: false
    t.decimal "SHOTND", precision: 18, scale: 2
    t.decimal "SHOTEX8ND", precision: 18, scale: 2, null: false
    t.decimal "RDSHOT", precision: 18, scale: 2, null: false
    t.decimal "RDSHOTEX8", precision: 18, scale: 2, null: false
    t.decimal "RDSHOTND", precision: 18, scale: 2
    t.decimal "RDSHOTEX8ND", precision: 18, scale: 2, null: false
    t.decimal "DHOT", precision: 18, scale: 2
    t.decimal "DHOTEX8", precision: 18, scale: 2
    t.decimal "DHOTEX8ND", precision: 18, scale: 2
    t.decimal "DHOTND", precision: 18, scale: 2
    t.decimal "RDDHOT", precision: 18, scale: 2
    t.decimal "RDDHOTEX8", precision: 18, scale: 2
    t.decimal "RDDHOTND", precision: 18, scale: 2
    t.decimal "RDDHOTEX8ND", precision: 18, scale: 2
    t.decimal "TotalOT", precision: 18, scale: 2
    t.decimal "TotalRD", precision: 18, scale: 2
    t.decimal "TotalHOL", precision: 18, scale: 2
    t.decimal "SSSLoan", precision: 18, scale: 2
    t.decimal "PAGIBIGLoan", precision: 18, scale: 2
    t.decimal "OTHLoan", precision: 18, scale: 2
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.integer "ThirteenthMonthRefNo", null: false
    t.boolean "HoldTag", null: false
    t.boolean "PostedTag", null: false
    t.boolean "IsFinalPay"
    t.boolean "IsSepcialPayroll", default: false
    t.datetime "SpecialPayrollDate"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "FinalPayRefNo", default: 0, null: false
    t.boolean "IsMinimumWage", default: false, null: false
    t.datetime "confirmeddate"
  end

  create_table "PAY_ProcessedPayroll_C_BK", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ProcessedPayrollRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.decimal "BasicRate", precision: 18, scale: 4
    t.varchar "PayBasis", limit: 5
    t.decimal "BasicPay", precision: 18, scale: 4, null: false
    t.decimal "BasicNetPay", precision: 18, scale: 4, null: false
    t.decimal "GrossPay", precision: 18, scale: 4, null: false
    t.decimal "TotalDeductions", precision: 18, scale: 4, null: false
    t.decimal "GrossNetPay", precision: 18, scale: 4
    t.decimal "TaxableIncome", precision: 18, scale: 4, null: false
    t.decimal "WithHoldingTax", precision: 18, scale: 4, null: false
    t.decimal "NetPay", precision: 18, scale: 4, null: false
    t.decimal "SSS_EE", precision: 18, scale: 4, null: false
    t.decimal "SSS_ER", precision: 18, scale: 4
    t.decimal "SSS_TC", precision: 18, scale: 4
    t.decimal "Pagibig_EE", precision: 18, scale: 4, null: false
    t.decimal "Pagibig_ER", precision: 18, scale: 4
    t.decimal "Pagibig_TC", precision: 18, scale: 4
    t.decimal "PhilHealth_EE", precision: 18, scale: 4, null: false
    t.decimal "PhilHealth_ER", precision: 18, scale: 4
    t.decimal "PhilHealth_TC", precision: 18, scale: 4
    t.decimal "E_SEA", precision: 18, scale: 4, null: false
    t.decimal "E_EcolaRate", precision: 18, scale: 4, null: false
    t.decimal "E_FixedEarning", precision: 18, scale: 4, null: false
    t.decimal "E_FixedNTEarning", precision: 18, scale: 4, null: false
    t.decimal "E_Total_FixedEarning", precision: 18, scale: 4, null: false
    t.decimal "E_OtherEarning", precision: 18, scale: 4, null: false
    t.decimal "E_OtherNTEarning", precision: 18, scale: 4, null: false
    t.decimal "E_Total_OtherEarning", precision: 18, scale: 4, null: false
    t.decimal "D_FixedDeduction", precision: 18, scale: 4, null: false
    t.decimal "D_FixedNTDeduction", precision: 18, scale: 4
    t.decimal "D_Total_FixedDeduction", precision: 18, scale: 4, null: false
    t.decimal "D_OtherDeduction", precision: 18, scale: 4, null: false
    t.decimal "D_OtherNTDeduction", precision: 18, scale: 4
    t.decimal "D_Total_OtherDeduction", precision: 18, scale: 4, null: false
    t.decimal "RH", precision: 18, scale: 4, null: false
    t.decimal "GP", precision: 18, scale: 4, null: false
    t.decimal "LH", precision: 18, scale: 4, null: false
    t.decimal "UT", precision: 18, scale: 4, null: false
    t.decimal "LWP", precision: 18, scale: 4, null: false
    t.decimal "LWOP", precision: 18, scale: 4, null: false
    t.decimal "AH", precision: 18, scale: 4, null: false
    t.decimal "OT", precision: 18, scale: 4, null: false
    t.decimal "ND", precision: 18, scale: 4, null: false
    t.decimal "NDOT", precision: 18, scale: 4, null: false
    t.decimal "RDOT", precision: 18, scale: 4, null: false
    t.decimal "RDOTEX8", precision: 18, scale: 4, null: false
    t.decimal "RDOTND", precision: 18, scale: 4
    t.decimal "RDOTEX8ND", precision: 18, scale: 4, null: false
    t.decimal "LHOT", precision: 18, scale: 4, null: false
    t.decimal "LHOTEX8", precision: 18, scale: 4, null: false
    t.decimal "LHOTND", precision: 18, scale: 4
    t.decimal "LHOTEX8ND", precision: 18, scale: 4, null: false
    t.decimal "RDLHOT", precision: 18, scale: 4, null: false
    t.decimal "RDLHOTEX8", precision: 18, scale: 4, null: false
    t.decimal "RDLHOTND", precision: 18, scale: 4
    t.decimal "RDLHOTEX8ND", precision: 18, scale: 4, null: false
    t.decimal "SHOT", precision: 18, scale: 4, null: false
    t.decimal "SHOTEX8", precision: 18, scale: 4, null: false
    t.decimal "SHOTND", precision: 18, scale: 4
    t.decimal "SHOTEX8ND", precision: 18, scale: 4, null: false
    t.decimal "RDSHOT", precision: 18, scale: 4, null: false
    t.decimal "RDSHOTEX8", precision: 18, scale: 4, null: false
    t.decimal "RDSHOTND", precision: 18, scale: 4
    t.decimal "RDSHOTEX8ND", precision: 18, scale: 4, null: false
    t.decimal "DHOT", precision: 18, scale: 4
    t.decimal "DHOTEX8", precision: 18, scale: 4
    t.decimal "DHOTEX8ND", precision: 18, scale: 4
    t.decimal "DHOTND", precision: 18, scale: 4
    t.decimal "RDDHOT", precision: 18, scale: 4
    t.decimal "RDDHOTEX8", precision: 18, scale: 4
    t.decimal "RDDHOTND", precision: 18, scale: 4
    t.decimal "RDDHOTEX8ND", precision: 18, scale: 4
    t.decimal "TotalOT", precision: 18, scale: 4
    t.decimal "TotalRD", precision: 18, scale: 4
    t.decimal "TotalHOL", precision: 18, scale: 4
    t.decimal "SSSLoan", precision: 18, scale: 4
    t.decimal "PAGIBIGLoan", precision: 18, scale: 4
    t.decimal "OTHLoan", precision: 18, scale: 4
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.integer "ThirteenthMonthRefNo", null: false
    t.boolean "HoldTag", null: false
    t.boolean "PostedTag", null: false
    t.boolean "IsFinalPay"
    t.boolean "IsSepcialPayroll"
    t.datetime "SpecialPayrollDate"
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
  end

  create_table "PAY_ProcessedPayroll_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TimeSummaryRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.integer "MonthRefNo"
    t.integer "PayrollParameterRefNo"
    t.integer "PaymentTermsRefNo"
    t.datetime "PayrollDate"
    t.integer "FilingStatusRefNo"
    t.integer "YEAR"
    t.integer "ProcessedPayrollRefNo"
    t.integer "PostedYear"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_SSSLoanDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SSSLoanDtlRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.varchar "SSSNo", limit: 100
    t.decimal "LoanAmt", precision: 18, scale: 4
    t.decimal "PenaltyAmt", precision: 18, scale: 4
    t.decimal "PaidAmt", precision: 18, scale: 4
    t.datetime "DateGranted"
    t.varchar "Remarks", limit: 500
    t.integer "SSSLoanRefNo"
    t.integer "LoanLedgerRefno"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_SSSLoan_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SSSLoanRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "CompanyRefNo"
    t.integer "MonthRefNo"
    t.integer "Year"
    t.varchar "SBRNo", limit: 100
    t.datetime "DatePaid"
    t.varchar "AuthorisedRepresentative", limit: 100
    t.integer "FilingStatusRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_SSSNETDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SSSNETDtlRefNo", null: false
    t.integer "SSSNETRefNo"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.varchar "SSSNo", limit: 100
    t.decimal "TotalSSS", precision: 18, scale: 2
    t.decimal "SSSEC", precision: 18, scale: 2
    t.decimal "MCPremium", precision: 18, scale: 2
    t.datetime "DateHired"
    t.integer "StatusRefNo"
    t.integer "MonthApplicable"
    t.decimal "EE", precision: 18, scale: 2
    t.decimal "ER", precision: 18, scale: 2
    t.decimal "EREE", precision: 18, scale: 2
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_SSSNET_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SSSNETRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "CompanyRefNo"
    t.integer "MonthRefNo"
    t.integer "Year"
    t.integer "FilingStatusRefNo"
    t.integer "ApplicableMonthRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_SSSStatus_M", primary_key: ["ServerCompanyCodeID", "SSSStatusRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "SSSStatusRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PAY_SSS_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "SSSRefNo", null: false
    t.decimal "CompensationFrom", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "CompensationTo", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PercentOver", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployerShare", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "ECEmployer", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "EmployeeShare", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_TaxAnnualizeAlphalist_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TaxAnnualizeAlphalistRefNo", null: false
    t.varchar "EmployeeRefno", limit: 50, null: false
    t.varchar "RegionNo", limit: 50, null: false
    t.decimal "PrevGrossCmpnstnIncome", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevBasicSMW", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevHolidayPay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevOvertimePay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevHazardPay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevNightSD", precision: 18, scale: 2, default: 0.0, null: false
    t.datetime "PresInclusiveDateFrom"
    t.datetime "PresInclusiveDateTo"
    t.decimal "PresGrossCmpnstnIncome", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresBasicSMWPerDay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresBasicSMWPerMon", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresBasicSMWPerYr", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresFactrUsed", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresHolidayPay", precision: 18, scale: 2, default: 0.0
    t.decimal "PresOvertimePay", precision: 18, scale: 2, default: 0.0
    t.decimal "PresNightSD", precision: 18, scale: 2, default: 0.0
    t.decimal "PresHazardPay", precision: 18, scale: 2, default: 0.0
    t.decimal "TotalGrossIncome", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalTardiAbsences", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalSSS", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalPhilhealth", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalPagIbig", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalSSSPHILPAGIBIG", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalDeductions", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxThirteenthMonthPay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxOtherBenefits", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxTotalThirteenthOtherBenefits", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxDeMinimisBenefits", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxSalariesOthFrmCompenstn", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresNTaxTotalNonTaxExemptCmpnstnIncome", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxBasicSalary", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxThirteenthMonthPay", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxOtherBenefits", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxTotalThirteenthOthrBenefits", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxSalariesOthFrmCompenstn", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxTotalTaxExemptCmpnstnIncome", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevNTaxThirteenthMonthPay", precision: 18, scale: 2, null: false
    t.decimal "PrevNTaxOtherBenefits", precision: 18, scale: 2, null: false
    t.decimal "PrevNTaxTotalThirteenthOtherBenefits", precision: 18, scale: 2, null: false
    t.decimal "PrevNTaxDeMinimisBenefits", precision: 18, scale: 2, null: false
    t.decimal "PrevNTaxSalariesOthFrmCompenstn", precision: 18, scale: 2, null: false
    t.decimal "PrevNTaxTotalNonTaxExemptCmpnstnIncome", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxBasicSalary", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxThirteenthMonthPay", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxOtherBenefits", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxTotalThirteenthOthrBenefits", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxSalariesOthFrmCompenstn", precision: 18, scale: 2, null: false
    t.decimal "PrevTaxTotalTaxExemptCmpnstnIncome", precision: 18, scale: 2, null: false
    t.decimal "PresPrevTotalTaxable", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "ExeCode", limit: 50, null: false
    t.decimal "ExeAmount", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PremPaidOnHealth", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "NetTaxableCompensation", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TaxDueJanDec", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PresTaxWheldJanNov", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PrevTaxWheldJanNov", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "YrEndAmountWhldPaidDec", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "YrEndOverWhldTaxRfndEmployee", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "AmntTaxWhldAdjstd", precision: 18, scale: 2, default: 0.0, null: false
    t.integer "SubstitutedFiling", limit: 1, default: 0, null: false
    t.decimal "OverThirty", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_TaxAnnualize_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.integer "Year", null: false
    t.decimal "GrossIncome", precision: 18, scale: 2, null: false
    t.decimal "TaxableIncome", precision: 18, scale: 2, null: false
    t.decimal "WithHoldingTax", precision: 18, scale: 2, null: false
    t.decimal "PrevEmpTaxIncome", precision: 18, scale: 2, null: false
    t.decimal "PrevEmpWithHoldingTax", precision: 18, scale: 2, null: false
    t.decimal "NetTaxableIncome", precision: 18, scale: 2, null: false
    t.decimal "TEarning", precision: 18, scale: 2, null: false
    t.decimal "NTaxEarning", precision: 18, scale: 2, null: false
    t.decimal "TaxOtherEarnings", precision: 18, scale: 2, null: false
    t.decimal "NTaxOtherEarnings", precision: 18, scale: 2, null: false
    t.decimal "T13MonthPay", precision: 18, scale: 2, null: false
    t.decimal "NT13MonthPay", precision: 18, scale: 2, null: false
    t.decimal "DeMinimisBenefits", precision: 18, scale: 2, null: false
    t.decimal "Statutories", precision: 18, scale: 2, null: false
    t.decimal "BasicSalary", precision: 18, scale: 2, null: false
    t.decimal "OvertimePay", precision: 18, scale: 2, null: false
    t.decimal "Exemption", precision: 18, scale: 2, null: false
    t.decimal "TaxDue", precision: 18, scale: 2, null: false
    t.boolean "IsActive", default: true, null: false
    t.datetime "DateTimeCreated", default: -> { "getdate()" }, null: false
    t.datetime "DateTimeModified", default: -> { "getdate()" }, null: false
    t.integer "FinalPayRefNo", default: 0, null: false
    t.decimal "BenifitsOver", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "Deduction", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "Tardiness", precision: 18, scale: 2, default: 0.0, null: false
    t.integer "TaxAnnulizationRefNo", default: 0, null: false
    t.boolean "IsPosted", default: false, null: false
  end

  create_table "PAY_TaxAnnualize_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TaxAnnulizationRefNo"
    t.integer "PayrollParameterRefNo"
    t.integer "Year"
    t.integer "Month"
    t.integer "FilingStatusRefNo"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: false, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_ThirteenthMonth_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ThirteenthMonthRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.integer "Year", null: false
    t.decimal "AnnualGrossPay", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "ThirteenthMonthPay", precision: 18, scale: 4, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "PostedTag", default: false, null: false
    t.integer "FinalPayRefNo", default: 0, null: false
  end

  create_table "PAY_ThirteenthMonth_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "ThirteenthMonthRefNo", null: false
    t.integer "Year"
    t.integer "PayrollParameterRefNo"
    t.datetime "ReleasedDate"
    t.integer "FilingStatusRefNo"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "Month"
  end

  create_table "PAY_WithHoldingTax_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "WithHoldingTaxRefNo", null: false
    t.integer "FrequencyRefNo", null: false
    t.integer "TaxStatusRefNo", null: false
    t.decimal "ExemptionFrom", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "ExemptionTo", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PercentOver", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "BaseTax", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PAY_YTD_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.integer "Year", null: false
    t.decimal "BasicRate", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "BasicPay", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "BasicNetPay", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "GrossPay", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "AbsentHours", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "TotalDeductions", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "GrossNetPay", precision: 18, scale: 4, default: 0.0
    t.decimal "TaxableIncome", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "WithHoldingTax", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "NetPay", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "SSS_EE", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "Pagibig_EE", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "PhilHealth_EE", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_SEA", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_EcolaRate", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_FixedEarning", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_FixedNTEarning", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_OtherEarning", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "E_OtherNTEarning", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "D_FixedDeduction", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "D_FixedNTDeduction", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "D_OtherDeduction", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "D_OtherNTDeduction", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "TotalOT", precision: 18, scale: 4, default: 0.0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_Attrition_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.datetime "EffectivityDate"
    t.varchar "Remarks", limit: 2000
  end

  create_table "PIS_COERequest_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.datetime "RequestedDate", null: false
    t.datetime "IssuedDate"
    t.integer "COETemplateRefNo"
    t.varchar "Remarks", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "Series", limit: 100
    t.datetime "PrintedDate"
    t.varchar "ServerCompanyCodeID", limit: 5, default: "1-1"
    t.integer "FilingStatusRefNo", default: 1
  end

  create_table "PIS_CompanyProfile_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "CompanyProfileRefNo", null: false
    t.integer "CompanyRefNo"
    t.varchar "Address1", limit: 500
    t.varchar "LocationCodeID", limit: 50, null: false
    t.varchar "PhoneNumber1", limit: 20
    t.varchar "PhoneNumber2", limit: 20
    t.varchar "FaxNumber1", limit: 20, null: false
    t.varchar "FaxNumber2", limit: 20
    t.varchar "ContactPerson1", limit: 65
    t.varchar "ContactPersonPosition1", limit: 150
    t.varchar "ContactPerson2", limit: 65
    t.varchar "ContactPersonPosition2", limit: 150
    t.varchar "TaxNumber", limit: 15
    t.varchar "SSSNumber", limit: 15
    t.varchar "PhilhealthNumber", limit: 15
    t.varchar "PagibigNumber", limit: 15
    t.integer "BusinessTypeRefNo"
    t.integer "OrganizationTypeRefNo"
    t.integer "IndustryRefNo"
    t.integer "PayPeriodRefNo"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "SSSBranchCode", limit: 3
    t.varchar "SSSLocatorCode", limit: 3
  end

  create_table "PIS_Course_U", primary_key: ["ServerCompanyCodeID", "CourseRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "CourseRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_EmpPerformance_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.datetime "DateFrom"
    t.datetime "DateTo"
    t.decimal "Rating", precision: 18, scale: 4, null: false
    t.varchar "Interpretation", limit: 1000
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", null: false
  end

  create_table "PIS_EmployeeAccountability_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 500
    t.datetime "DateIssued", null: false
    t.datetime "DateReturned"
    t.varchar "Remarks", limit: 500, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
  end

  create_table "PIS_EmployeeChangeRequest", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo"
    t.datetime "SubmittedDate"
    t.integer "ReasonForChangeRefNo"
    t.varchar "OtherReason", limit: 500
    t.varchar_max "Remarks"
    t.datetime "EffectivityDate"
    t.integer "ContractTemplateRefNo"
    t.integer "ContractTypeRefNo"
    t.integer "InitialDuration"
    t.varchar "EmployeeNumber", limit: 50
    t.integer "EmployeeGroupRefNoOld"
    t.integer "DepartmentRefNoOld"
    t.integer "EmployeeTypeRefNoOld"
    t.integer "EmployeeStatusRefNoOld"
    t.integer "EmploymentStatusRefNoOld"
    t.integer "ClientAccountRefNoOld"
    t.varchar "JobPositionOld", limit: 500
    t.datetime "StartDateOld"
    t.datetime "EndDateOld"
    t.datetime "DateProbationaryOld"
    t.datetime "DateRegularizedOld"
    t.decimal "BasicRateOld", precision: 18, scale: 2
    t.decimal "ClientRateOld", precision: 18, scale: 4
    t.integer "PayrollRateRefNoOld"
    t.integer "PayrollParameterRefNoOld"
    t.integer "PayFrequencyRefNoOld"
    t.integer "PayBasisRefNoOld"
    t.integer "TaxStatusRefNoOld"
    t.integer "EcolaRateRefNoOld"
    t.integer "EcolaComputationRefNoOld"
    t.datetime "LastDateofEmploymentOld"
    t.integer "ReasonForSeperationRefNoOld"
    t.varchar "ReasonForSeparationOld", limit: 500
    t.boolean "HolPayOld"
    t.boolean "W13thMonthOld"
    t.boolean "SSSGSISTagOld"
    t.boolean "PAGIBIGTagOld"
    t.boolean "PHICTagOld"
    t.decimal "SILOld", precision: 18, scale: 2
    t.integer "EmployeeGroupRefNo"
    t.integer "DepartmentRefNo"
    t.integer "EmployeeTypeRefNo"
    t.integer "EmployeeStatusRefNo"
    t.integer "EmploymentStatusRefNo"
    t.integer "ClientAccountRefNo"
    t.varchar "JobPosition", limit: 500
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "DateProbationary"
    t.datetime "DateRegularized"
    t.decimal "BasicRate", precision: 18, scale: 2
    t.decimal "ClientRate", precision: 18, scale: 4
    t.integer "PayrollRateRefNo"
    t.integer "PayrollParameterRefNo"
    t.integer "PayFrequencyRefNo"
    t.integer "PayBasisRefNo"
    t.integer "TaxStatusRefNo"
    t.integer "EcolaRateRefNo"
    t.integer "EcolaComputationRefNo"
    t.datetime "LastDateofEmployment"
    t.integer "ReasonForSeperationRefNo"
    t.varchar "ReasonForSeparation", limit: 500
    t.boolean "W13thMonth"
    t.boolean "HolPay"
    t.boolean "SSSGSISTag"
    t.boolean "PAGIBIGTag"
    t.boolean "PHICTag"
    t.decimal "SIL", precision: 18, scale: 2
    t.integer "ApprovalLevel", default: 1, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }
    t.datetime "ModifiedDate", default: -> { "getdate()" }
    t.boolean "IsActive", default: true
    t.integer "FilingStatusRefNo", default: 1
    t.decimal "HMOAmount", precision: 18, scale: 2
    t.decimal "HMOAmountOld", precision: 18, scale: 2
  end

  create_table "PIS_EmployeeChangeRequest_Benefits", primary_key: "ServerCompanyCodeID", id: :varchar, limit: 50, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeChangeRequestRefNo"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.integer "EmployeePayItemRefNo"
    t.integer "PaymentTermsRefNo"
    t.decimal "PayItemAmount", precision: 18, scale: 4
    t.varchar "PayItem", limit: 500
    t.boolean "IsFixed"
    t.boolean "IsTaxable"
    t.boolean "IsBonuses"
    t.boolean "IsOtherExpense"
    t.integer "PayBasisRefNo"
  end

  create_table "PIS_EmployeeChangeRequest_JD", primary_key: ["ServerCompanyCodeID", "EmployeeChangeRequestRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "EmployeeChangeRequestRefNo", null: false
    t.varchar_max "Description"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_EmployeeContractInfo_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.datetime "StartDate", null: false
    t.datetime "EndDate", null: false
    t.integer "ClientAccountRefNo", null: false
    t.decimal "ClientGrossRate", precision: 18, scale: 2, null: false
    t.decimal "BasicSalary", precision: 18, scale: 2, null: false
    t.decimal "SalaryIncrease", precision: 18, scale: 2, default: 0.0, null: false
    t.integer "PayBasisRefNo", null: false
    t.integer "PayrollRateRefNo", null: false
    t.boolean "SSSTag", default: true, null: false
    t.boolean "PAGIBIGTag", default: true, null: false
    t.boolean "PHICTag", default: true, null: false
    t.boolean "w13thMonth", default: true, null: false
    t.boolean "HolidayPay", default: false, null: false
    t.boolean "HMOTag", default: false, null: false
    t.boolean "IncentiveLeaveTag", default: false, null: false
    t.integer "EcolaRateRefNo", null: false
    t.varchar_max "JobDescription"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "FilingStatusRefNo", default: 1, null: false
    t.integer "WorkScheduleRefNo"
    t.integer "ContractTypeRefNo"
    t.boolean "OvertimeTag", default: true, null: false
    t.boolean "LateTag", default: true, null: false
    t.boolean "UndertimeTag", default: true, null: false
    t.boolean "TaxTag", default: true, null: false
    t.integer "PayFrequencyRefNo", null: false
    t.integer "EmployeeTypeRefNo", null: false
    t.integer "JobPositionRefNo", null: false
    t.integer "EmploymentStatusRefNo", null: false
    t.integer "ApprovalLevel", default: 1, null: false
  end

  create_table "PIS_EmployeeCount", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "Year"
    t.integer "Count"
    t.integer "COECount"
    t.integer "VerificationCount"
  end

  create_table "PIS_EmployeeDependents_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.datetime "BirthDate"
    t.boolean "IsPWD"
    t.integer "Age"
  end

  create_table "PIS_EmployeeJobDescription_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.integer "EmploymentInfoRefNo", null: false
    t.varchar_max "Description"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_EmployeeMovementRequest", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeMovementRequestRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.integer "EmployeeMovementRequestTypeRefNo", null: false
    t.varchar_max "Value", null: false
    t.varchar_max "Remarks", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.datetime "EffectivityDate", null: false
    t.integer "FilingStatusRefNo", default: 1, null: false
  end

  create_table "PIS_EmployeeOffense_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.integer "OffenseRefNo", null: false
    t.integer "DisciplinaryActionRefNo", null: false
    t.datetime "OffenseCommitedDate"
    t.datetime "FromInclusiveDate"
    t.datetime "ToInclusiveDate"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.varchar "Remarks", limit: 500
    t.integer "EmployeeOffenseRefNo", null: false
  end

  create_table "PIS_EmployeeOtherBenefits_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", null: false
    t.decimal "Amount", precision: 18, scale: 2
    t.integer "TermsRefNo"
    t.boolean "IsCost"
    t.boolean "IsNotChargable"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.integer "EmployeeRefNo"
    t.decimal "ChargeAmount", precision: 18, scale: 2
    t.integer "EmployeePayItemRefNo"
  end

  create_table "PIS_EmployeePreEmploymentReq_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.boolean "Diploma", null: false
    t.boolean "TOR", null: false
    t.boolean "TC", null: false
    t.boolean "NSOBC", null: false
    t.boolean "NSOMC", null: false
    t.boolean "NSODBC", null: false
    t.boolean "SSSID", null: false
    t.boolean "TINID", null: false
    t.boolean "PHICID", null: false
    t.boolean "PAGIBIGID", null: false
    t.boolean "BIR", null: false
    t.boolean "NBI", null: false
    t.boolean "POLICE", null: false
    t.boolean "BRGY", null: false
    t.boolean "MEDICAL", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
  end

  create_table "PIS_EmployeeStepIncrement_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeStepIncrementRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.varchar "Description", limit: 50
    t.decimal "Amount", precision: 18, scale: 2
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.datetime "EffectivityDate", default: -> { "getdate()" }, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "PIS_EmployeeTraining_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", null: false
    t.integer "EmployeeRefNo", null: false
    t.varchar "ProgramName", limit: 500
    t.datetime "TransactDate"
    t.varchar "Facilitator", limit: 200
    t.integer "JobBandRefNo"
  end

  create_table "PIS_Employee_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.varchar "EmployeeNumber", limit: 50
    t.varchar "BiometricID", limit: 50
    t.varchar "LastName", limit: 50, null: false
    t.varchar "FirstName", limit: 50, null: false
    t.varchar "MiddleName", limit: 100
    t.varchar "NickName", limit: 50
    t.integer "GenderRefNo"
    t.datetime "Birthdate"
    t.varchar "BirthPlace", limit: 50
    t.integer "NationalityRefNo"
    t.integer "ReligionRefNo"
    t.varchar "PersonalEmailAddress", limit: 50
    t.varchar "WorkEmailAddress", limit: 50
    t.varchar "Height", limit: 50
    t.varchar "Weight", limit: 50
    t.integer "BloodtypeRefNo"
    t.varchar "TelephoneNumber", limit: 60
    t.varchar "MobileNumber", limit: 60
    t.varchar "CurrentAddress", limit: 500
    t.varchar "ProvinceAddress", limit: 200
    t.varchar "ProvinceTelephoneNumber", limit: 15
    t.integer "CivilStatusRefNo"
    t.varchar "PhilHealthNumber", limit: 15
    t.varchar "SSSNumber", limit: 15
    t.varchar "TinNumber", limit: 15
    t.varchar "PagibigNumber", limit: 15
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "EmergencyName1", limit: 150
    t.varchar "EmergencyAddress1", limit: 500
    t.varchar "EmergencyContactNo1", limit: 100
    t.varchar "EmergencyRelationship1", limit: 100
    t.varchar "EmergencyName2", limit: 150
    t.varchar "EmergencyAddress2", limit: 500
    t.varchar "EmergencyContactNo2", limit: 100
    t.varchar "EmergencyRelationship2", limit: 100
    t.varchar "Suffix", limit: 50
    t.varchar "MaidenName", limit: 100
    t.integer "Age"
    t.integer "CityRefNo"
    t.varchar_max "Allergies"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.varchar "SocialMedia", limit: 100
    t.integer "CronusRefNo"
    t.integer "MalayanCoverageRefNo"
    t.varchar "MaxicarePolicyNo", limit: 50
    t.varchar "MaxicareCardNo", limit: 50
    t.boolean "IsNewNumber", default: true, null: false
    t.varchar "UCPBCardNo", limit: 100
    t.varchar "UCPBPolicyNo", limit: 100
    t.varchar "MobileNumber2", limit: 50
    t.integer "CostCenter"
    t.varchar "YearGraduated", limit: 50
    t.varchar "ImagePath", limit: 500
    t.varchar "School", limit: 500
    t.varchar "Course", limit: 500
    t.varchar "Description", limit: 156
    t.boolean "IsInactive", default: false, null: false
    t.varchar "FullName", limit: 104
  end

  create_table "PIS_EmploymentInfo_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.varchar "EmployeeNumber", limit: 50, null: false
    t.varchar "BiometricID", limit: 50
    t.integer "WorkScheduleRefNo", default: 0
    t.integer "PayrollRateRefNo"
    t.integer "PayFrequencyRefNo"
    t.integer "PayBasisRefNo"
    t.integer "TaxStatusRefNo"
    t.boolean "W13thMonth"
    t.integer "EcolaRateRefNo"
    t.boolean "TaxTag"
    t.boolean "SSSGSISTag"
    t.boolean "PAGIBIGTag"
    t.boolean "PHICTag"
    t.integer "BankRefNo"
    t.datetime "EffectivityDate"
    t.integer "EcolaComputationRefNo"
    t.integer "PayrollParameterRefNo"
    t.decimal "BasicRate", precision: 18, scale: 2
    t.decimal "ClientRate", precision: 18, scale: 4, default: 0.0
    t.decimal "HDMFAddCont", precision: 18, scale: 4
    t.integer "EmployeeGroupRefNo"
    t.integer "ClientAccountRefNo", default: 0
    t.datetime "DateHired"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "DateProbationary"
    t.datetime "DateRegularized"
    t.datetime "LastDateofEmployment"
    t.varchar "JobPosition", limit: 500
    t.integer "EmployeeTypeRefNo"
    t.integer "EmployeeStatusRefNo"
    t.integer "EmploymentStatusRefNo"
    t.boolean "FinalPay"
    t.varchar "ReasonForSeparation", limit: 500
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.boolean "IsActive", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "EmploymentInfoRefNo", null: false
    t.integer "ReasonForSeperationRefNo"
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.varchar "WorkSchedule", limit: 200
    t.integer "DepartmentRefNo"
    t.boolean "PagibigPercent"
    t.varchar "Skills", limit: 2000
    t.decimal "SIL", precision: 18, scale: 2
    t.decimal "HMOAmount", precision: 18, scale: 2
    t.integer "FOWRefNo"
    t.varchar "AccountNo", limit: 100, default: "0"
    t.decimal "TotalNoofDays", precision: 18, scale: 2
    t.decimal "HoursPerDay", precision: 18, scale: 2
    t.decimal "Duration", precision: 18, scale: 2
    t.decimal "HMODC", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "GR", precision: 18, scale: 2
    t.decimal "DC", precision: 18, scale: 2
    t.decimal "GM", precision: 18, scale: 2
    t.decimal "GMP", precision: 18, scale: 2
    t.varchar "ClientAddress", limit: 1000
    t.integer "CostCenterRefNo", default: 0, null: false
    t.datetime "ContractualDate"
    t.decimal "OTAssumption", precision: 18, scale: 2
    t.boolean "IsImplemented", default: false, null: false
    t.varchar_max "JobDescription"
    t.boolean "SEPTag", default: false
    t.boolean "HOLTag", default: false
    t.integer "JobPositionRefNo"
    t.integer "JobBandRefNo"
    t.index ["EmployeeRefNo", "ID"], name: "EmployeeRefNo", unique: true
  end

  create_table "PIS_JobBand_U", primary_key: ["ServerCompanyCodeID", "JobBandRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "JobBandRefNo", null: false
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_KPI_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "KPIDescription", limit: 500
    t.integer "KPIType"
    t.decimal "KPITarget", precision: 18, scale: 2
    t.decimal "KPIOutput", precision: 18, scale: 2
    t.decimal "KPIAccomplish", precision: 18, scale: 2
    t.varchar "Remarks", limit: 1000
    t.decimal "KPIRating", precision: 18, scale: 2
    t.decimal "KPIWeight", precision: 18, scale: 2
    t.decimal "KPIScore", precision: 18, scale: 2
    t.integer "KPIYear"
    t.integer "EmployeeRefNo"
  end

  create_table "PIS_PAR", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo"
    t.datetime "SubmittedDate"
    t.integer "ReasonForChangeRefNo"
    t.varchar "OtherReason", limit: 500
    t.varchar "Remarks", limit: 1000
    t.datetime "EffectivityDate"
    t.integer "ContractTemplateRefNo"
    t.integer "PayrollRateRefNo"
    t.integer "PayBasisRefNo"
    t.integer "EcolaRateRefNo"
    t.integer "EcolaComputationRefNo"
    t.decimal "BasicRate", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "ClientRate", precision: 18, scale: 4, default: 0.0, null: false
    t.integer "ClientAccountRefNo"
    t.datetime "DateHired"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "DateProbationary"
    t.datetime "DateRegularized"
    t.varchar "JobPosition", limit: 500
    t.integer "EmployeeTypeRefNo"
    t.integer "EmploymentStatusRefNo"
    t.integer "DepartmentRefNo"
    t.decimal "SIL", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "HMOAmount", precision: 18, scale: 2, default: 0.0, null: false
    t.boolean "SeparationPay", default: false, null: false
    t.boolean "SSS", default: false, null: false
    t.boolean "PAGIBIG", default: false, null: false
    t.boolean "PHIC", default: false, null: false
    t.boolean "T13thMonth", default: false, null: false
    t.boolean "HolidayPay", default: false, null: false
    t.integer "FOWRefNo"
    t.decimal "HMODC", precision: 18, scale: 2, default: 0.0, null: false
    t.varchar "ClientAddress", limit: 1000
    t.decimal "OTAssumption", precision: 18, scale: 2
    t.integer "EmploymentInfoRefNo"
    t.varchar_max "JobDescription"
    t.varchar_max "Justification"
    t.datetime "ContractualDate"
    t.varchar "Supervisor", limit: 104
    t.decimal "AllowanceAndOthers", precision: 18, scale: 2
    t.integer "PreviousPayrollRateRefNo"
    t.integer "PreviousPayBasisRefNo"
    t.integer "PreviousEcolaRateRefNo"
    t.integer "PreviousEcolaComputationRefNo"
    t.decimal "PreviousBasicRate", precision: 18, scale: 2, null: false
    t.decimal "PreviousClientRate", precision: 18, scale: 4, null: false
    t.integer "PreviousClientAccountRefNo"
    t.varchar "PreviousClientAddress", limit: 1000
    t.datetime "PreviousDateHired"
    t.datetime "PreviousStartDate"
    t.datetime "PreviousEndDate"
    t.datetime "PreviousDateProbationary"
    t.datetime "PreviousDateRegularized"
    t.varchar "PreviousJobPosition", limit: 500
    t.integer "PreviousEmployeeTypeRefNo"
    t.integer "PreviousEmploymentStatusRefNo"
    t.integer "PreviousDepartmentRefNo"
    t.decimal "PreviousSIL", precision: 18, scale: 2, null: false
    t.decimal "PreviousHMOAmount", precision: 18, scale: 2, null: false
    t.decimal "PreviousHMODC", precision: 18, scale: 2, null: false
    t.decimal "PreviousOTAssumption", precision: 18, scale: 2
    t.boolean "PreviousSeparationPay", null: false
    t.boolean "PreviousSSS", null: false
    t.boolean "PreviousPAGIBIG", null: false
    t.boolean "PreviousPHIC", null: false
    t.boolean "PreviousT13thMonth", null: false
    t.boolean "PreviousHolidayPay", null: false
    t.integer "PreviousFOWRefNo"
    t.varchar_max "PreviousJobDescription"
    t.varchar_max "PrevAllowancesAndOthers"
    t.varchar_max "PrevSupervisor"
    t.boolean "IsEmplemented", default: false, null: false
    t.datetime "PrintedDate"
    t.integer "PrintedBy"
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", default: true, null: false
    t.integer "FilingStatusRefNo", default: 1, null: false
    t.integer "ApprovalLevel", default: 0
  end

  create_table "PIS_PAR_Benefits", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "PARRefNo", null: false
    t.varchar "Description", limit: 500
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", default: true, null: false
    t.decimal "Amount", precision: 18, scale: 2
    t.decimal "ChargeAmount", precision: 18, scale: 2
    t.integer "TermsRefNo"
    t.boolean "IsCost"
    t.boolean "IsNotChargable"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.integer "EmployeeOtherBenefitsRefNo"
  end

  create_table "PIS_School_U", primary_key: ["ServerCompanyCodeID", "SchoolRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "SchoolRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PIS_VerificationRequest_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.datetime "RequestedDate", null: false
    t.datetime "IssuedDate"
    t.integer "VerificationTemplateRefNo"
    t.varchar "Remarks", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate"
    t.boolean "IsActive", null: false
    t.varchar "Series", limit: 100
    t.datetime "PrintedDate"
    t.varchar "ServerCompanyCodeID", limit: 5
    t.integer "FilingStatusRefNo", default: 1
  end

  create_table "PIS_VerificationTemplate_U", primary_key: ["ServerCompanyCodeID", "VerificationTemplateRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "VerificationTemplateRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "PayslipJsonData", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar_max "Json"
    t.date "PayrollDate"
  end

  create_table "SPSList", id: false, force: :cascade do |t|
    t.string "empnumber", limit: 255
    t.string "MR", limit: 255
    t.string "NameofClients", limit: 255
    t.string "Name", limit: 255
    t.string "Position", limit: 255
    t.float "BasicSalary"
    t.float "BillingRate"
    t.datetime "HiringDate"
    t.datetime "RegDate"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.string "EmploymentStatus", limit: 255
    t.string "F13", limit: 255
  end

  create_table "SYS_AuditTrail_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.boolean "IsActive", null: false
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate"
    t.datetime "ModifiedDate"
    t.varchar "Menu", limit: 500
    t.integer "RefNo"
    t.varchar "ColumnName", limit: 1000
    t.varchar_max "OldValue"
    t.varchar_max "NewValue"
    t.varchar "Action", limit: 50
    t.varchar "HostName", limit: 500
    t.varchar "MacAddress", limit: 500
    t.integer "UserRefNo"
  end

  create_table "SYS_ContractTemplate_F", primary_key: ["ServerCompanyCodeID", "ContractTemplateRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "ContractTemplateRefNo", null: false
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsExternal"
    t.varchar "Remarks", limit: 100
  end

  create_table "SYS_Emails_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "EmailTo", limit: 500
    t.varchar "EmailCC", limit: 500
    t.varchar "EmailSubject", limit: 1000
    t.varchar_max "EmailBody"
    t.boolean "IsSent"
  end

  create_table "SYS_Notification_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "NotificationType"
    t.varchar "Description", limit: 500
    t.integer "UserRefNo"
    t.boolean "IsSeen"
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "SYS_Session_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "SessionID", limit: 500, null: false
    t.varchar "IPAddress", limit: 50, null: false
    t.integer "UserRolesRefNo", null: false
    t.integer "UserRefNo", null: false
  end

  create_table "SYS_Signatory_U", id: false, force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.integer "EmployeeRefNo"
    t.integer "MenuRefNo"
    t.varchar "Remarks", limit: 500
    t.integer "SignatoryRefNo", null: false
    t.varchar "ServerCompanyCodeID", limit: 50
    t.string "SignImage"
  end

  create_table "SYS_System_U", primary_key: ["ServerCompanyCodeID", "SystemRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "SystemRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "SYS_UserPrivileges_Detail", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.boolean "IsActive", null: false
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate"
    t.datetime "ModifiedDate"
    t.integer "UserPrivilegesRefno"
    t.integer "MenuRefNo"
    t.boolean "AllowInsert"
    t.boolean "AllowUpdate"
    t.boolean "AllowDelete"
    t.boolean "AllowView"
    t.boolean "AllowPrint"
    t.boolean "AllowApprove"
  end

  create_table "SYS_UserPrivileges_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "Description", limit: 200
    t.boolean "IsActive", null: false
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate"
    t.datetime "ModifiedDate"
  end

  create_table "SYS_WebMenu_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "MenuRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 100
    t.boolean "IsActive", null: false
    t.integer "FormType"
    t.integer "SeqNo"
    t.integer "MenuParentRefNo"
    t.varchar "ImageFile", limit: 100
    t.varchar "ActionName", limit: 500
    t.varchar "ControllerName", limit: 500
    t.boolean "HasNew"
    t.varchar "MenuTitle", limit: 100
    t.integer "CreatedBy"
    t.datetime "CreatedDate"
    t.integer "ModifiedBy"
    t.datetime "ModifiedDate"
    t.varchar "DetailActionName", limit: 100
    t.varchar "DetailControllerName", limit: 100
    t.boolean "HasDelete"
    t.integer "SystemRefNo"
    t.varchar "SubDescription", limit: 500
    t.boolean "wListPopUp", default: false
    t.varchar "PopUpDetailViewController", limit: 100
    t.varchar "PopUpDetailViewAction", limit: 100
  end

  create_table "SYS_WebUser", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.boolean "IsActive", null: false
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate"
    t.datetime "ModifiedDate"
    t.varchar "Username", limit: 100
    t.varbinary "Password", limit: 2000
    t.varchar "Email", limit: 100
    t.integer "UserPrivilegesRefNo"
    t.integer "MRRefNo"
    t.boolean "IsAdmin"
    t.integer "EmployeeRefNo"
  end

  create_table "TMS_AccrualType_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "AccrualTypeRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_AnniversaryType_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "AnniversaryTypeRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_ApprovalLevel", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "UserPrivilegesRefNo", null: false
    t.integer "Sequence", default: 1, null: false
    t.boolean "IsExternal", default: true
  end

  create_table "TMS_DTRApplicationDtl_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DTRApplicationRefNo"
    t.varchar "DTRApplicationReferenceNo", limit: 100
    t.integer "EmployeeRefNo"
    t.datetime "WorkDate"
    t.datetime "TimeIn"
    t.datetime "TimeOut"
    t.datetime "BioTimeIn"
    t.datetime "BioTimeOut"
    t.decimal "Hours", precision: 18, scale: 6
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.varchar "DayStatus", limit: 50
    t.decimal "RH", precision: 18, scale: 2
    t.decimal "GP", precision: 18, scale: 2
    t.decimal "LH", precision: 18, scale: 2
    t.decimal "UT", precision: 18, scale: 2
    t.decimal "AH", precision: 18, scale: 2
    t.decimal "LWP", precision: 18, scale: 2
    t.decimal "LWOP", precision: 18, scale: 2
    t.decimal "OT", precision: 18, scale: 2
    t.decimal "ND", precision: 18, scale: 2
    t.decimal "OTND", precision: 18, scale: 2
    t.decimal "RD", precision: 18, scale: 2
    t.decimal "HH", precision: 18, scale: 2
  end

  create_table "TMS_DTRApplicationHdr_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DTRApplicationRefNo"
    t.varchar "DTRApplicationReferenceNo", limit: 100
    t.integer "EmployeeRefNo"
    t.integer "FilingStatusRefNo"
    t.decimal "TotalHours", precision: 18, scale: 6
    t.decimal "Days", precision: 18, scale: 6
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_DTRApplication_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "MonthRefNo"
    t.integer "PayrollParameterRefNo"
    t.integer "PaymentTermsRefNo"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "PayrollDate"
    t.integer "FilingStatusRefNo"
    t.integer "Year"
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "DTRApplicationRefNo", null: false
  end

  create_table "TMS_DayName_F", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DayNameRefNo", null: false
    t.varchar "Code", limit: 5
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_DayType_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "DayTypeRefNo", null: false
    t.varchar "Code", limit: 5, null: false
    t.varchar "Description", limit: 50, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "IsEnable", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_EmployeeAttendanceLog_U", id: false, force: :cascade do |t|
    t.integer "ID"
    t.integer "BiometricID"
    t.varchar "EmployeeNumber", limit: 50
    t.datetime "DateTime"
    t.date "Date"
    t.integer "Minute"
  end

  create_table "TMS_EmployeeLeaveCredits_M", primary_key: ["ServerCompanyCodeID", "EmployeeLeaveCreditsRefNo"], force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.integer "EmployeeLeaveCreditsRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "EmployeeRefNo"
    t.varchar "Code", limit: 50
  end

  create_table "TMS_EmployeeLeaveHistory_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "LeaveTypeRefNo"
    t.decimal "Credits", precision: 18, scale: 4
    t.integer "EmployeeReFno"
    t.integer "LeaveApplicationRefNo"
    t.integer "FilingStatusRefNo"
    t.integer "LeaveConversionRefNo"
    t.datetime "DateAccrue"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_EmployeeLeaveMaster_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeLeaveMasterRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.varchar "EmployeeNumber", limit: 50, null: false
    t.datetime "LeaveEnrollDate", null: false
    t.decimal "MonetizedAmount", precision: 18, scale: 0
    t.boolean "MonetizedTag", default: false, null: false
    t.boolean "ProcessedTag", default: false, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.datetime "LeaveAvailabilityDate"
    t.integer "LeaveTypeRefNo"
    t.integer "EmployeeLeaveCreditsRefNo"
    t.decimal "CeilingValue", precision: 18, scale: 2
    t.integer "LeaveAccrualRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_LeaveAccrualSetupHdr_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveAccrualSetupHdrRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "AccessLevelRefNo"
    t.integer "FilingStatusRefNo"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_LeaveAccrualSetupVal_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "LeaveAccrualSetupValRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "LeaveAccrualSetupRefNo"
    t.integer "LeaveAccrualSetupHdr"
    t.integer "FromYears"
    t.integer "ToYears"
    t.decimal "AccrualValue", precision: 18, scale: 2
    t.decimal "Value", precision: 18, scale: 2
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.decimal "ClearLoan", precision: 18, scale: 2
    t.decimal "PFLoan", precision: 18, scale: 2
  end

  create_table "TMS_LeaveApplication_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.varchar "LeaveApplicationReferenceNo", limit: 50
    t.integer "EmployeeRefNo", null: false
    t.datetime "WorkDate"
    t.integer "LeaveTypeRefNo"
    t.integer "Hours"
    t.decimal "Credits", precision: 18, scale: 6
    t.varchar_max "Reason"
    t.boolean "HeaderTag"
    t.integer "FilingStatusRefNo"
    t.varchar "CreatedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.varchar "ModifiedBy", limit: 50
    t.datetime "ModifiedDate", null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "LeaveApplicationRefNo"
  end

  create_table "TMS_OBApplication_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "OBApplicationRefNo", null: false
    t.varchar "OBApplicationReferenceNo", limit: 50
    t.varchar "EmployeeNumber", limit: 50
    t.integer "EmployeeRefNo", null: false
    t.integer "ClientAccountRefNo"
    t.integer "ProjectRefNo"
    t.datetime "WorkDate"
    t.varchar "Reason", limit: 500
    t.boolean "HeaderTag"
    t.decimal "NoOfHours", precision: 18, scale: 2
    t.decimal "Days", precision: 18, scale: 2
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.integer "BreakHours"
    t.integer "ApprovalStatusRefNo"
    t.varchar "DisapprovalRemarks", limit: 500
    t.varchar "ApprovedBy", limit: 50
    t.boolean "RegularOBTag", default: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsWebPosted"
    t.datetime "PayPeriodDate"
    t.integer "PayPeriodRefNo", default: 0, null: false
    t.datetime "ApprovedDate"
    t.varchar "CheckedBy", limit: 50
    t.datetime "CheckedDate"
    t.boolean "EmailTag", default: false, null: false
    t.boolean "PostedTag", default: false, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "ProcessedTag", default: false, null: false
    t.boolean "IsFollowingDay", default: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_OvertimeApplication_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "OvertimeApplicationRefNo", null: false
    t.varchar "OvertimeApplicationReferenceNo", limit: 50
    t.integer "EmployeeRefNo", null: false
    t.varchar_max "Reason"
    t.boolean "HeaderTag"
    t.decimal "NoOfHours", precision: 18, scale: 2
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.integer "FilingStatusRefNo"
    t.varchar "DisapprovalRemarks", limit: 500
    t.varchar "ApprovedBy", limit: 50
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.decimal "Days", precision: 18, scale: 2
    t.datetime "WorkDate"
    t.datetime "ApprovedDate"
    t.varchar "CheckedBy", limit: 50
    t.datetime "CheckedDate"
    t.boolean "IsClientAuthorized"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "TMS_RateMatrix_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "RateMatrixRefNo", null: false
    t.integer "PayBasisRefNo"
    t.varchar "SystemCode", limit: 100
    t.varchar "Code", limit: 100
    t.varchar "Description", limit: 500
    t.decimal "OTRate", precision: 18, scale: 3, default: 0.0
    t.boolean "LegalHolidayTag", default: false, null: false
    t.boolean "DoubleHolidayTag", default: false, null: false
    t.boolean "SpecialHolidayTag", default: false, null: false
    t.boolean "RestDayTag", default: false, null: false
    t.boolean "First8HoursTag", default: false, null: false
    t.boolean "Excess8HoursTag", default: false, null: false
    t.boolean "SundayPremiumTag", default: false, null: false
    t.boolean "NightDifferentialTag", default: false, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_SettingType_U", primary_key: "SettingTypeRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.varchar "Code", limit: 50
    t.varchar_max "Description"
    t.varchar "CreatedBy", limit: 50, null: false
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
  end

  create_table "TMS_SettingsDetails_U", primary_key: "SettingsDetailsRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.integer "SettingsRefNo", null: false
    t.integer "ClientAccountRefNo", null: false
    t.varchar_max "Value"
    t.varchar "CreatedBy", limit: 50, null: false
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_Settings_U", primary_key: "SettingsRefNo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "ID", null: false
    t.integer "SettingTypeRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar_max "Description"
    t.varchar_max "Value"
    t.varchar "CreatedBy", limit: 50, null: false
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.varchar "Comment"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_TimeSummaryHdr_C", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TimeSummaryRefNo", null: false
    t.integer "EmployeeRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.decimal "TotalDays", precision: 18, scale: 6
    t.boolean "IsSpecialPayroll"
    t.integer "FilingStatusRefNo"
    t.boolean "HoldPayroll"
    t.datetime "SpecialPayrollDate"
    t.boolean "AsOtherEarning"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
    t.integer "DTRApplicationRefNo"
    t.boolean "IsActive", default: true, null: false
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "ProcessedTag", default: false, null: false
    t.decimal "RH", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "GP", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "GPNo", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LH", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LHNo", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "UT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LWP", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LWOP", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "AH", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "AHNo", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "OT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "NDOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "LHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDLHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDLHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDLHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDLHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "SHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "SHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "SHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "SHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDSHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDSHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDSHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDSHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "DHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "DHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "DHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "DHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDDHOT", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDDHOTND", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDDHOTEX8", precision: 18, scale: 4, default: 0.0, null: false
    t.decimal "RDDHOTEX8ND", precision: 18, scale: 4, default: 0.0, null: false
    t.boolean "DeductStatutory"
    t.boolean "IsDailyRate"
  end

  create_table "TMS_TimeSummary_U", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "TimeSummaryRefNo", null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.integer "MonthRefNo"
    t.integer "PayrollParameterRefNo"
    t.integer "PaymentTermsRefNo"
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "PayrollDate"
    t.integer "FilingStatusRefNo"
    t.integer "YEAR"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_WorkScheduleDtl_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "WorkScheduleDtlRefNo", null: false
    t.varchar "Code", limit: 50
    t.varchar "Description", limit: 50
    t.datetime "AMStart", null: false
    t.datetime "AMBreakStart", null: false
    t.datetime "AMBreakEnd", null: false
    t.datetime "AMEnd", null: false
    t.datetime "PMStart", null: false
    t.datetime "PMBreakStart", null: false
    t.datetime "PMBreakEnd", null: false
    t.datetime "PMEnd", null: false
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "FlexiTag", default: false, null: false
    t.datetime "FlexiFrom"
    t.datetime "FlexiTo"
    t.integer "WorkScheduleRefNo", null: false
    t.integer "DayNo", null: false
    t.boolean "DayOffTag", default: false, null: false
    t.boolean "DayPaid", default: false
    t.integer "ShiftRefNo", null: false
    t.integer "SchedTypeRefNo", null: false
    t.decimal "WholeDayHours", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "HalfDayAMHours", precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "HalfDayPMHours", precision: 18, scale: 2, default: 0.0, null: false
    t.datetime "TimeIn"
    t.datetime "TimeOut"
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "TMS_WorkSchedule_M", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "WorkScheduleRefNo", null: false
    t.varchar "Description", limit: 500
    t.integer "NoOfDays", default: 0, null: false
    t.integer "GracePeriod", default: 0, null: false
    t.varchar "CreatedBy", limit: 50
    t.varchar "ModifiedBy", limit: 50
    t.datetime "CreatedDate", default: -> { "getdate()" }, null: false
    t.datetime "ModifiedDate", default: -> { "getdate()" }, null: false
    t.boolean "IsActive", default: true, null: false
    t.boolean "LeaveStandard", default: false, null: false
    t.decimal "HoursPerDay", precision: 18, scale: 2, default: 8.0, null: false
    t.boolean "IsBreakIncluded", default: false, null: false
    t.varchar "ServerCompanyCodeID", limit: 50, default: "1-1", null: false
  end

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "post"
    t.string "color"
    t.string "image_uid"
  end

  create_table "categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contactpages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employeebk", primary_key: "ID", id: :integer, force: :cascade do |t|
    t.integer "EmployeeRefNo", null: false
    t.varchar "EmployeeNumber", limit: 50
    t.varchar "BiometricID", limit: 50
    t.varchar "LastName", limit: 50, null: false
    t.varchar "FirstName", limit: 50, null: false
    t.varchar "MiddleName", limit: 50, null: false
    t.varchar "NickName", limit: 50
    t.integer "GenderRefNo"
    t.datetime "Birthdate"
    t.varchar "BirthPlace", limit: 50
    t.integer "NationalityRefNo"
    t.integer "ReligionRefNo"
    t.varchar "PersonalEmailAddress", limit: 50
    t.varchar "WorkEmailAddress", limit: 50
    t.varchar "Height", limit: 50
    t.varchar "Weight", limit: 50
    t.integer "BloodtypeRefNo"
    t.varchar "TelephoneNumber", limit: 60
    t.varchar "MobileNumber", limit: 60
    t.varchar "CurrentAddress", limit: 500
    t.varchar "ProvinceAddress", limit: 200
    t.varchar "ProvinceTelephoneNumber", limit: 15
    t.integer "CivilStatusRefNo"
    t.varchar "PhilHealthNumber", limit: 15
    t.varchar "SSSNumber", limit: 15
    t.varchar "TinNumber", limit: 15
    t.varchar "PagibigNumber", limit: 15
    t.integer "CreatedBy"
    t.integer "ModifiedBy"
    t.datetime "CreatedDate", null: false
    t.datetime "ModifiedDate", null: false
    t.boolean "IsActive", null: false
    t.varchar "EmergencyName1", limit: 150
    t.varchar "EmergencyAddress1", limit: 500
    t.varchar "EmergencyContactNo1", limit: 100
    t.varchar "EmergencyRelationship1", limit: 100
    t.varchar "EmergencyName2", limit: 150
    t.varchar "EmergencyAddress2", limit: 500
    t.varchar "EmergencyContactNo2", limit: 100
    t.varchar "EmergencyRelationship2", limit: 100
    t.varchar "Suffix", limit: 50
    t.varchar "Description", limit: 153, null: false
    t.varchar "MaidenName", limit: 100
    t.integer "Age"
    t.integer "CityRefNo"
    t.varchar_max "Allergies"
    t.varchar "ServerCompanyCodeID", limit: 50, null: false
    t.varchar "SocialMedia", limit: 100
    t.integer "CronusRefNo"
    t.integer "MalayanCoverageRefNo"
    t.varchar "MaxicarePolicyNo", limit: 50
    t.varchar "MaxicareCardNo", limit: 50
    t.boolean "IsNewNumber"
  end

  create_table "knowledgebases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "article"
    t.string "author"
    t.string "category"
  end

  create_table "knowledges", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "createdby"
    t.integer "category"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
    t.boolean "viewpdf"
    t.string "attachment"
  end

  create_table "payslipsettings", force: :cascade do |t|
    t.string "description"
    t.string "value"
    t.string "path"
    t.boolean "show"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.string "skills"
    t.text "remarks"
    t.integer "employeerefno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resumes", force: :cascade do |t|
    t.string "name"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sysdiagrams", primary_key: "diagram_id", id: :integer, force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.integer "principal_id", null: false
    t.integer "version"
    t.binary "definition"
    t.index ["principal_id", "name"], name: "UK_principal_name", unique: true
  end

  create_table "testxes", force: :cascade do |t|
    t.integer "anumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userheros", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "EmployeeRefNo"
    t.string "EmployeeNumber"
    t.string "image_uid"
    t.string "image_name"
    t.string "image"
    t.boolean "IsAdmin"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
