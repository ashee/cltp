# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cltp_session',
  :secret      => 'c245c66163f27b9c5a75c83c247a68426e7fb5c158e4c5cec17f86f6369cd32f63ebeca8817723d99738ff087204de87c6d073c9f682333ecb86809fa4f03323'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
