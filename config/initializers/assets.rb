# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )


Rails.application.config.assets.precompile += %w( page.scss)
Rails.application.config.assets.precompile += %w( pay_processed_payroll_u.scss)
Rails.application.config.assets.precompile += %w( password_new.scss)
Rails.application.config.assets.precompile += %w( registration_edit.scss)
Rails.application.config.assets.precompile += %w( por_surveys.scss)
Rails.application.config.assets.precompile += %w( por_temp_surveys.scss)
Rails.application.config.assets.precompile += %w( portal_survey_covid19s.scss)
Rails.application.config.assets.precompile += %w( por_media.scss)
Rails.application.config.assets.precompile += %w( leave_application_required.scss)
Rails.application.config.assets.precompile += %w( leave_credits.scss)

Rails.application.config.assets.precompile += %w( pay_processed_payroll_u.js)
Rails.application.config.assets.precompile += %w( password_new.js)
Rails.application.config.assets.precompile += %w( registration_edit.js)
