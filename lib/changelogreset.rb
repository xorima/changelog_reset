# frozen_string_literal: true

require 'sinatra'

require_relative 'changelogreset/vcs'
require_relative 'changelogreset/hmac'

get '/' do
  'Alive'
end

post '/handler' do
  return halt 500, "Signatures didn't match!" unless validate_request(request)

  payload = JSON.parse(params[:payload])
  case request.env['HTTP_X_GITHUB_EVENT']
  when 'release'
    return "Unhandled action: #{payload['action']}" unless payload['action'] == 'released'

    vcs = ChangelogReset::Vcs.new(token: ENV['GITHUB_TOKEN'], repository: payload['repository'])
    response = vcs.unreleased_entry
    return halt 500, 'Error updating file, see server logs for details' if response == 'Error'
    return response
  end
end

def validate_request(request)
  true unless ENV['SECRET_TOKEN']
  request.body.rewind
  payload_body = request.body.read
  verify_signature(payload_body)
end
