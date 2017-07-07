Griddler.configure do |config|
  config.email_service = :mailgun
end

# Add Mailgun stripped-text to normalized params
module GriddlerMailgunAdapterExtensions
  def normalize_params
    normalized_params = super
    normalized_params[:stripped_text] = params['stripped-text']
    normalized_params
  end
end

# Prepend custom extensions
Griddler::Mailgun::Adapter.class_eval do
  prepend GriddlerMailgunAdapterExtensions
end

# Assign Mailgun stripped-text to attribute
module GriddlerEmailExtensions
  def initialize(params)
    super
    @stripped_text = params[:stripped_text]
  end
end

# Add attribute for Mailgun stripped-text and prepend custom extensions
Griddler::Email.class_eval do
  attr_reader :stripped_text
  prepend GriddlerEmailExtensions
end
