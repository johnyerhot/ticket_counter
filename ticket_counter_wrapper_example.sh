#!/bin/sh
# Fill in the details for your Engineyard SSO and Zendesk accounts
SSO_ACCOUNT_FULL_NAME="Tim Littlemore"
SSO_EMAIL=""
SSO_PASSWORD=""

# Find this when logged out of Zendesk, but logged in to SSO, and go to zendesk.ey.com
ZENDESK_LOGIN_URL="http://zendesk.engineyard.com/users/XXXX/login"

# Set the path to where you copied the repo
cd /path/to/ticket_counter && \
bundle exec ruby ticket_counter.rb
