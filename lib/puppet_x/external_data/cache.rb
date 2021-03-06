module Puppet_X # rubocop:disable Style/ClassAndModuleCamelCase,Style/ClassAndModuleChildren
  module ExternalData # rubocop:disable Style/ClassAndModuleChildren
    # Cache base class, inherited by other caches
    class Cache
      def get(forager, certname)
        _get(forager, certname)
      end

      def delete(forager, certname)
        # Mark the cache as dirty so that the commit method can be called
        dirty!
        _delete(forager, certname)
        nil
      end

      def update(forager, certname, data)
        # Mark the cache as dirty so that the commit method can be called
        dirty!
        _update(forager, certname, data)
        data
      end

      # The dirty methods mark if the cache has been changed so that it can
      # know if it needs to be committed or not
      def dirty!
        @dirty = true
      end

      def clean!
        @dirty = false
      end

      def dirty?
        @dirty || false
      end

      # Cache plugins much implement the below methods that start with an
      # underscore
      def _get(_forager, _certname)
        raise '_get method not implemented'
      end

      def _delete(_forager, _certname)
        raise '_delete method not implemented'
      end

      def _update(_forager, _certname, _data)
        raise '_update method not implemented'
      end

      # Some cache backends might want a commit called at the end as opposed to
      # each time it's updated. Remeber that if we have six foragers a cache
      # for a given node might be updated six times in a single run. For caches
      # where this would be slow they can define a "commit" method which will
      # be called at the end of all updates if there were changes
      #
      # If the plugin doesn't implement _commit it just won't do anything
      def commit
        if defined? _commit
          if dirty?
            _commit
          end
        end
        nil
      end
    end
  end
end
