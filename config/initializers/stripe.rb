if Rails.env.development?
  Rails.configuration.stripe = {
    :data_key => ENV['STRIPE_API_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
elsif Rails.env.production?
  Rails.configuration.stripe = {
    :data_key => ENV['STRIPE_TEST_API_KEY'],
    :secret_key => ENV['STRIPE_TEST_SECRET_KEY']
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]