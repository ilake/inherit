# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_life_session',
  :secret      => '9b14c98bedc7185ca9bb26ce3c05bf7bf1e8ab80dbc2a5370a969b219e3492e9497e5e865c71a102f9d95311637f6cc2e5e61d035d4bf62b94f3f46432f97b22'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
