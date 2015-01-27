class Chef
  class Provider
    # Provider for the bundle_install Chef provider
    #
    # bundle '/install/path' do
    # end
    #
    class Bundle < Chef::Provider::LWRPBase
      def load_current_resource
        @current_resource ||= new_resource.class.new(new_resource.name)
      end

      def action_install
        execute "bundle install #{new_resource.name}" do
          command "bundle install --deployment " \
                  "--without #{new_resource.without.join(' ')} " \
                  "--path #{new_resource.path} " \
                  "--gemfile #{new_resource.gemfile}"
          user new_resource.user
          group new_resource.group
          environment new_resource.environment_for_platform
        end
      end
    end
  end
end
