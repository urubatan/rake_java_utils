require 'lib/java_util'
@java_util = JavaUtil.new

task :default => :test

SRC_FILES = FileList.new 'src/**/*.java'
TST_FILES = FileList.new 'test/**/*.java'
CLASSPATH = FileList.new "#{File.join(ENV['TOMCAT_DIR'], 'lib').gsub /\\/,'/'}/*.jar"

@java_util.default_parameter_for :java, :classpath, CLASSPATH.to_a
@java_util.default_parameter_for :javac, :classpath, CLASSPATH.to_a

directory 'output/classes'
directory 'output/tests'

desc "Compile all the java files"
task :compile => ['output/classes','output/tests']  do
  @java_util.javac SRC_FILES, :d => 'output/classes'
  @java_util.javac TST_FILES, :d => 'output/tests', :classpath => ['output/classes',"#{ENV['JUNIT_DIR']}\\junit-4.4.jar"]
end

desc "Creates the package after compilation"
task :package => :compile do
  @java_util.jar '-cf output/target.jar -C output/classes .'
  cp 'output/target.jar', 'WebContent/WEB-INF/lib'
  @java_util.jar '-cf output/target.war -C WebContent .'
end

desc "Runs the tests after packaging"
task :test => :package do
  test_classes = FileList.new 'output/tests/**/*.class'
  test_classes.gsub! /output\/tests\/(.*)\.class/,'\1'
  test_classes.gsub! /\//, '.'
  @java_util.java "org.junit.runner.JUnitCore #{test_classes.join ' '}", :classpath => ['output/tests','output/target.jar',"#{ENV['JUNIT_DIR']}\\junit-4.4.jar"]
end

desc "Clean up all the mess we created"
task :clean do
  rm_f 'output'
end