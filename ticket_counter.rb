require 'rubygems'
require 'bundler/setup'
require 'mechanize'

# Set these ENV vars in the wrapper script; /usr/local/bin/ticket_counter
SSO_ACCOUNT_FULL_NAME = ENV['SSO_ACCOUNT_FULL_NAME']
SSO_EMAIL = ENV['SSO_EMAIL']
SSO_PASSWORD = ENV['SSO_PASSWORD']
SSO_URL = "https://login.engineyard.com/login"
ZENDESK_LOGIN_URL = ENV['ZENDESK_LOGIN_URL'] 
ZENDESK_URL = "https://support.cloud.engineyard.com"
OPEN_TICKETS_URL = ZENDESK_URL + "/rules/23807303"
PENDING_TICKETS_URL = ZENDESK_URL + "/rules/26118557"

a = Mechanize.new

# We'll need to log in over SSO first
sso_login_page = a.get(SSO_URL)
login_form = sso_login_page.form_with(:id => 'login-form')
login_form.field_with(:id => 'email').value = SSO_EMAIL
login_form.field_with(:id => 'password').value = SSO_PASSWORD
page = a.submit(login_form, login_form.buttons.first)
if page.search('//h1').first.text !~ /.*#{SSO_ACCOUNT_FULL_NAME}.*/
  puts "Unable to log in to SSO as #{SSO_ACCOUNT_FULL_NAME}"
  puts page.search('//h1').first.text
  exit
end

# Then we need to access the correct ZD account
zd_home_page = a.get(ZENDESK_LOGIN_URL)
#if zd_home_page.search('div #notice').text !~ /.*#{SSO_ACCOUNT_FULL_NAME}.*/
#  puts zd_home_page.search('div #notice').text
#  puts "Unable to access ZD account for #{SSO_ACCOUNT_FULL_NAME}"
#  exit
#end

# Grab the number of open tickets
page = a.get(OPEN_TICKETS_URL)
puts "Open tickets: #{page.title.scan(/[0-9]*/).join.to_i}"

# Grab the number of pending tickets
page = a.get(PENDING_TICKETS_URL)
puts "Pending tickets: #{page.title.scan(/[0-9]*/).join.to_i}"

