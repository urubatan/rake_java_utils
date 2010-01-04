class JavaUtil
  RAW_COMMANDS = %w{appletviewer apt extcheck idlj jar jarsigner java javac javadoc javah javap javaw javaws jconsole jdb jhat jinfo jmap jps jrunscript jstack jstat jstatd jvisualvm keytool kinit klist ktab native2ascii orbd pack200 packager policytool rmic rmid rmiregistry schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc}
  
  def initialize(jdk_home=nil)
    @commands = {}
    @jdk_home = jdk_home || ENV['java_home']
    @default_for_command = {}
    @global_default = {}
    init_commands
  end
  
  def method_missing(met,*args)
    if RAW_COMMANDS.include? met.to_s
      execute_command met, *args
    else
      super.method_missing met, *args
    end
  end
  
  def respond_to?(met)
    RAW_COMMANDS.include?(met.to_s) || super.respond_to?(met)
  end
  
  def default_parameter(param,value)
    @global_default[param] = value
  end
  
  def default_parameter_for(met,param,value)
    params = @default_for_command[met] || {}
    params[param] = value
    @default_for_command[met] = param
  end
  
  private
    def init_commands
      @jdk_bin = File.join @jdk_home , "bin"
      RAW_COMMANDS.each do |cmd|
        @commands[cmd.to_sym] = File.join @jdk_bin, cmd
      end
    end
    
    def update_or_concat_with_defaults(opts,defaults)
      defaults.each do |key,value|
        param = opts[key]
        if !param
          param = value
        else
          if param.is_a? Array
            param << value
            param.flatten!
          end
        end
        opts[key] = param
      end
    end
    
    def execute_command(cmd, *args)
      actual_command = @commands[cmd.to_sym]
      if args
        opts = {}
        opts.update args.pop if args.last.is_a? Hash
        update_or_concat_with_defaults opts, @global_default
        update_or_concat_with_defaults opts, @default_for_command[cmd.to_sym] if @default_for_command[cmd.to_sym]        
        opts.each do |key, value|
          param = value
          param = param.join File::PATH_SEPARATOR if param.is_a? Array
          actual_command << " -" << key.to_s << " "  << param
        end
        actual_command = "#{actual_command} #{args.join ' '} "
      end
      res = %x{#{actual_command}}
      [$?,res]
    end
end