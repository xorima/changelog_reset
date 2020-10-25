# frozen_string_literal: true

require 'spec_helper'

describe ChangelogReset::Vcs, :vcr do
  # Check Vcs creates an OctoKit client
  before(:each) do
    @client = ChangelogReset::Vcs.new({
                                        token: ENV['GITHUB_TOKEN'] || 'temp_token',
                                        repository: {
                                          'full_name' => 'Xorima/xor_test_cookbook', 'default_branch' => 'master'
                                        }
                                      })
  end

  it 'creates an octkit client' do
    expect(@client).to be_kind_of(ChangelogReset::Vcs)
  end

  it 'Updates the changelog as expected' do
    update = @client.unreleased_entry
    expect(update).to eq 'Set Changelog to ## Unreleased'
  end
end
