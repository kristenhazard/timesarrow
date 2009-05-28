# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timesarrow_session',
  :secret      => '56a077911d79d24af879aa07a9c750f92b0edcb9f16af00f7e4f82237b1bbc8563cb9c3365de6a6d4d341eb1bb82263788136f241464bc22e86375729276f6e8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
