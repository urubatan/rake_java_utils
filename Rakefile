require 'lib/java_util'
task :default => :test

SRC_FILES = FileList.new 'src/**/*.java'
TST_FILES = FileList.new 'test/**/*.java'
CLASSPATH = FileList.new 'c:/opt/tomcat/lib/*.jar'
@java_util = JavaUtil.new

directory 'output'

desc "Compile all the java files"
task :compile => 'output'  do
  @java_util.javac SRC_FILES, :classpath => CLASSPATH.to_a, :d => 'output'
end

desc "Creates the package after compilation"
task :package => :compile do
  puts "package"
end
desc "Runs the tests after packaging"
task :test => :package do
  puts "test"
end