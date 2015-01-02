module Dubya
  class Wiki
    # Represents a single Wiki page.
    class Page
      attr_accessor :name

      def self.path_to(name)
        path = File.join Dubya.wiki.path, "#{name}.wiki"
        path
      end

      def self.exists?(name)
        path = path_to name
        File.exist?(path) || File.symlink?(path)
      end

      def self.find(name)
        #if exists? name
          new name
        #else
        #  Dubya.logger.error "Page '#{name}' not found in '#{path_to(name)}'"
        #  nil
        #end
      end

      def initialize(name)
        @name = name
      end

      def contents
        File.read path
      end

      def path
        self.class.path_to name
      end

      def update(with_new_contents)
        write(with_new_contents) && save
      end

      def save
        Dubya.wiki.commit "Updated '#{name}'"
        Dubya.wiki.compile!
      end

      private

      def write(new_contents)
        File.write path, new_contents
      end
    end
  end
end
