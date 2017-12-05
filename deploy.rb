require 'aws-sdk'
require 'json'

CREDENTIALS_FILE = 'credentials.json'.freeze
CLOUDFORMATION_TEMPLATE_FILE = 'stack.template'.freeze

def get_credentials_from_file
  JSON.parse(File.read(CREDENTIALS_FILE))
end

def get_template_from_file
  File.read(CLOUDFORMATION_TEMPLATE_FILE)
end

@credentials = get_credentials_from_file

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(@credentials['akid'], @credentials['secret'])
})

client = Aws::CloudFormation::Client.new

resp = client.create_stack({
  stack_name: 'SentimentsStack',
  template_body: get_template_from_file,
})

puts resp.stack_id
