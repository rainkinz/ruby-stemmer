require 'rubygems'
require 'bundler/setup'

require 'rdoc/task'
require 'rake/testtask'
require "bundler/gem_tasks"
require 'rake/extensiontask'
require 'rubygems/package_task'

CLOBBER.include("libstemmer_c/**/*.o")

GEMSPEC = Gem::Specification.load("ruby-stemmer.gemspec")

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

def java?
  /java/ === RUBY_PLATFORM
end

if java?
  def add_file_to_gem relative_path
    target_path = File.join gem_build_path, relative_path
    target_dir = File.dirname(target_path)
    mkdir_p target_dir unless File.directory?(target_dir)
    rm_f target_path
    safe_ln relative_path, target_path
    GEMSPEC.files += [relative_path]
  end

  def gem_build_path
    File.join 'pkg', GEMSPEC.full_name
  end

  # TODO: clean this section up.
  require "rake/javaextensiontask"
  Rake::JavaExtensionTask.new("ruby-stemmer", GEMSPEC) do |ext|
    jruby_home = RbConfig::CONFIG['prefix']
    ext.ext_dir = 'ext/java'
    ext.lib_dir = 'lib/lingua'
    ext.source_version = '1.6'
    ext.target_version = '1.6'
    jars = ["#{jruby_home}/lib/jruby.jar"] + FileList['lib/*.jar']
    ext.classpath = jars.map { |x| File.expand_path x }.join ':'
  end

  task gem_build_path => [:compile] do
    add_file_to_gem 'lib/lingua/lingua.jar'
  end
else

  Rake::ExtensionTask.new('ruby-stemmer', GEMSPEC) do |ext|
    ext.lib_dir = File.join(*['lib', 'lingua', ENV['FAT_DIR']].compact)
    ext.ext_dir = File.join 'ext', 'lingua'
    ext.cross_compile = true
    ext.cross_platform = ['i386-mswin32-60', 'i386-mingw32']
    ext.name = 'stemmer_native'
  end
end

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.title = "Ruby-Stemmer #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('ext/lingua/stemmer.c')
  rdoc.rdoc_files.include('MIT-LICENSE')
end

task :default => [:clobber, :compile, :test]

