require 'aws-sdk'
require 'json'

CREDENTIALS_FILE = 'credentials.json'.freeze

def get_credentials_from_file
  JSON.parse(File.read(CREDENTIALS_FILE))
end

@credentials = get_credentials_from_file

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(@credentials['akid'], @credentials['secret'])
})
