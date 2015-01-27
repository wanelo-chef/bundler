class Chef
  class Resource
    # Resource for the bundle_install Chef provider
    #
    # bundle 'my-app' do
    #   gemfile '/path/to/Gemfile'
    #   environment 'PATH' => '/ruby:$PATH'
    #   without %w(development test random stuff)
    #   path '/my/app/.bundle'
    #   action :install
    # end
    #
    class Bundle < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :bundle
        @provider = Chef::Provider::Bundle
        @action = :install
        @allowed_actions = [:install, :nothing]
      end

      def name(arg = nil)
        set_or_return(:name, arg, kind_of: String)
      end

      def user(arg = nil)
        set_or_return(:user, arg, kind_of: String, required: true)
      end

      def group(arg = nil)
        set_or_return(:group, arg, kind_of: String, required: true)
      end

      def gemfile(arg = nil)
        set_or_return(:gemfile, arg, kind_of: String, required: true)
      end

      def environment(arg = nil)
        set_or_return(:environment, arg, kind_of: Hash, default: {})
      end

      def without(arg = nil)
        set_or_return(:without, arg, kind_of: Array, default: %w(development test))
      end

      def path(arg = nil)
        set_or_return(:path, arg, kind_of: String, required: true)
      end

      def environment_for_platform
        value_for_platform_family(
          'smartos' => {
            'LDFLAGS' => "-R/opt/local -L/opt/local/lib"
          },
          'default' => {}
        ).merge(environment)
      end
    end
  end
end
