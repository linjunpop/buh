module Buh
  class SwitchBranch
    class << self
      def run(args)
        @branch_name = args.first

        validate_branch

        rollback(changed_migrations.sort.first) unless changed_migrations.empty?

        switch_branch
      end

      private

      def validate_branch
        raise 'Please provide a branch name.' if @branch_name.nil?

        repo = Rugged::Repository.new('.')
        if Rugged::Branch.lookup(repo, @branch_name).nil?
          raise "Cannot Find the branch: #{@branch_name}"
        end
      end

      def changed_migrations
        [].tap do |changed_migrations|
          migration_file_pattern = /db\/migrate\/.*/

          `git diff --name-status #{@branch_name}`.split("\n").each do |status_with_filename|
            status, filename = status_with_filename.split(/\s+/)

            next if status == 'D'
            if filename =~ migration_file_pattern
              changed_migrations << filename.match(/db\/migrate\/(\d*)/)[1]
            end
          end
        end
      end

      def rollback(version)
        `bundle exec rake db:migrate:down VERSION=#{version}`
        `git checkout db/schema.rb`
      end

      def switch_branch
        `git checkout #{@branch_name}`
      end
    end
  end
end
