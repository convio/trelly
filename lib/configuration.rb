require 'trello'
require 'rally_rest_api'
require 'yaml'

include Trello
include Trello::Authorization

def defaults
  {
      :rally =>
          {
              :version => "1.36",
      },
      :delete_on_tag_removal => false,
      :valid_tags => %w"#defect #story #project #task",
  }
end

@config = defaults.merge(YAML.load_file('../config.yml'))

#configure Trello
Trello::Authorization.const_set(:AuthPolicy, OAuthPolicy)
OAuthPolicy.consumer_credential = OAuthCredential.new(@config[:trello][:public_key], @config[:trello][:secret_key])
OAuthPolicy.token = OAuthCredential.new(@config[:trello][:token], nil)

#configure Rally
@rally = RallyRestAPI.new(:username => @config[:rally][:username], :password => @config[:rally][:password], :version => @config[:rally][:version])
@rally_workspace = @rally.user.subscription.workspaces.select {|w| w.name == @config[:rally][:workspace]}.first