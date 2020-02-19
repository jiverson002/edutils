# frozen_string_literal: true

require 'etc'
require 'fileutils'
require 'monkey'
require 'yaml'

# Watchdog module
module Watchdog
  # Policy class
  class Policy
    include Comparable

    class << self
      def now
        @now ||= Time.now
      end
    end

    def initialize(time, mode)
      @time = time
      case mode
      when Hash
        @dir  = mode['dir']
        @file = mode['file']
      when String
        @dir  = mode
        @file = mode
      end
    end

    def <=>(other)
      time <=> other.time
    end

    def valid?
      (time - Policy.now.gmt_offset) <= Policy.now
    end

    def mode(fullpath)
      File.directory?(fullpath) ? dir : file
    end

    protected

    attr_reader :time

    private

    attr_reader :dir
    attr_reader :file
  end

  # Path class
  class Path
    def initialize(config, fullpath, parent = nil)
      # record arguments
      %i[config fullpath parent].each do |s|
        instance_variable_set("@#{s}", binding.local_variable_get(s))
      end

      # populate instance variables in specific order
      %i[group excludes includes policy path].each do |s|
        instance_variable_set("@#{s}", send(s))
      end
    end

    def apply
      (path + children).each(&:apply)

      return if @parent.nil?

      chmod(mode, fullpath)
      chown(nil, group, fullpath)
    end

    protected

    attr_reader :fullpath

    def mode
      (excluded? || !policy.max.valid? ? policy.min : policy.max).mode(fullpath)
    end

    def group
      @group ||= @config.delete('group') || @parent&.group || ''
    end

    def policy
      @policy ||= if @config['mode']
                    [Policy.new(Time.at(0), @config.delete('mode'))]
                  else
                    @parent&.policy.clone || []
                  end.tap do |list|
                    list.concat(@config.map do |k, v|
                      Policy.new(k, v) if k.is_a?(Time)
                    end.compact)
                  end
    end

    def excludes
      @excludes ||= (@parent&.excludes.clone || []).tap do |list|
        list.concat(@config.delete('exclude')&.map do |e|
          glob(File.join(fullpath, e))
        end&.flatten || [])
      end
    end

    def includes
      @includes ||= (@parent&.includes.clone || []).tap do |list|
        list.concat(@config.delete('include')&.map do |i|
          glob(File.join(fullpath, i))
        end&.flatten || [])
      end
    end

    private

    def glob(path)
      if Dir.exist?(path)
        Dir.glob(path + '/**/*').push(path)
      else
        Dir.glob(path)
      end.map(&File.method(:expand_path))
    end

    def chmod(mode, fullpath)
      return unless chmod?(mode, fullpath)

      FileUtils.chmod(mode, fullpath, verbose: true)
    end

    def chown(user, group, fullpath)
      return unless chown?(user, group, fullpath)

      FileUtils.chown(nil, group, fullpath, verbose: true)
    end

    def path
      @path ||= @config.map do |k, v|
        Path.new(v, File.join(fullpath, k), self) if k.is_a?(String)
      end.compact
    end

    def children
      @children ||= dir_children(fullpath).map do |c|
        cpath = File.join(fullpath, c)
        Path.new({}, cpath, self) unless path?(cpath)
      end.compact
    end

    def dir_children(fullpath)
      @parent && Dir.exist?(fullpath) ? Dir.children(fullpath) : []
    end

    def chmod?(mode, filepath)
      smode = File.stat(filepath).mode & 0o07777
      imode = FileUtils.send(:symbolic_modes_to_i, mode, filepath)
      smode != imode
    end

    def chown?(_user, group, filepath)
      return if group.empty?

      Etc.getgrnam(group).gid != File.stat(filepath).gid
    end

    def path?(fullpath)
      path.any? { |p| p.fullpath.eql?(fullpath) }
    end

    def excluded?
      excludes.include?(fullpath) && !included?
    end

    def included?
      includes.include?(fullpath)
    end
  end
end
