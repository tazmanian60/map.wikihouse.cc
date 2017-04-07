if ENV["S3_ACCESS_KEY_ID"] && !Rails.env.test?
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_credentials] = {
    access_key_id: ENV.fetch("S3_ACCESS_KEY_ID"),
    secret_access_key: ENV.fetch("S3_SECRET_ACCESS_KEY"),
  }
  Paperclip::Attachment.default_options[:bucket] = ENV.fetch("S3_BUCKET")
  Paperclip::Attachment.default_options[:s3_region] = ENV.fetch("S3_REGION")
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end
