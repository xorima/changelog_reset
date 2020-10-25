# frozen_string_literal: true

require 'octokit'

module ChangelogReset
  # Used to handle calls to VCS
  class Vcs
    def initialize(token:, repository:, changelog_name: 'CHANGELOG.md')
      @client = Octokit::Client.new(access_token: token)
      @repository = repository
      @repository_name = repository['full_name']
      @changelog_name = changelog_name
      @default_branch = repository['default_branch']
      @changelog_entry = "## Unreleased\n\n"
    end

    def unreleased_entry
      file = get_file_contents(@changelog_name)
      file['content'] = add_unreleased_entry(file['content'])
      update_file_contents(@changelog_name, 'Set Changelog to ## Unreleased', file['sha'], file['content'])
    end

    private

    def add_unreleased_entry(changelog)
      heading_string = "## Unreleased\n\n"
      heading_location = changelog.index('##')
      if heading_location.nil?
        heading_location = -1
        heading_string = "\n#{heading_string}"
      end
      changelog.insert(heading_location, heading_string)
    end

    def get_file_contents(file_path)
      file_content = @client.contents(@repository_name, path: file_path, ref: @default_branch)
      content = Base64.decode64(file_content[:content])
      response = {}
      response['content'] = content
      response['sha'] = file_content[:sha]
      response
    end

    def update_file_contents(file_path, commit_message, file_sha, file_content)
      begin
        @client.update_contents(@repository_name, file_path,
                                commit_message, file_sha, file_content, branch: @default_branch)
      rescue StandardError => e
        puts(e)
        return e
      end
      commit_message
    end
  end
end
