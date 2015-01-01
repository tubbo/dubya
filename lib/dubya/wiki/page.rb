module Dubya
  class Wiki
    # Represents a single Wiki page.
    class Page
      attr_accessor :name

      def self.path_to(name)
        File.join Dubya.wiki.path, name
      end

      def self.exists?(name)
        File.exist? path_to(name)
      end

      def self.find(name)
        return unless exists? name
        new(name)
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
      end

      private

      def write
        File.write path, with_new_contents
      end
    end
  end
end
