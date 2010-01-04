require 'lib/java_util'
task :default => :test

SRC_FILES = FileList.new 'src/**/*.java'
TST_FILES = FileList.new 'test/**/*.java'
CLASSPATH = FileList.new "#{ENV['TOMCAT_DIR']}/lib/*.jar"
@java_util = JavaUtil.new
@java_util.default_parameter :classpath, CLASSPATH.to_a

directory 'output/classes'
directory 'output/tests'

desc "Compile all the java files"
task :compile => ['output/classes','output/tests']  do
  @java_util.javac SRC_FILES, :d => 'output/classes'
  @java_util.javac TST_FILES, :d => 'output/tests', :classpath => ['output/classes',"#{ENV['JUNIT_DIR']}\junit-4.4.jar"]
end

desc "Creates the package after compilation"
task :package => :compile do
  puts "package"
end
desc "Runs the tests after packaging"
task :test => :package do
  puts "test"
end
