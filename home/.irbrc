require 'awesome_print'
AwesomePrint.irb!

def safely_require(lib, &block)
  begin
    require lib.to_s
    yield if block_given?
  rescue LoadError => error
    puts "WARNING: Failed to require #{lib}"
  else
    puts "Required #{lib}"
  end
end

safely_require 'rubygems'
safely_require 'awesome_print'
safely_require 'pp'

safely_require 'wirble' do
  Wirble.init
  Wirble.colorize
end

safely_require 'utility_belt_r19' do
# UtilityBelt.equip :google
# UtilityBelt.equip :clipboard
  UtilityBelt.equip :interactive_editor
end

# Configure the prompt. {{{

# This changes it from
#   1.9.3p327 :001 >
# to
#   >>
IRB.conf[:PROMPT_MODE] = :SIMPLE

# }}}

# Configure IRB's history. {{{
IRB.conf[:HISTORY_FILE] = '~/.irb_history'
IRB.conf[:SAVE_HISTORY] = 1000
# }}}

# Configure IRB's backtrace. {{{
IRB.conf[:BACK_TRACE_LIMIT] = 100
# }}}

# Easily print methods local to an object's class # {{{
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def methods_matching(pattern)
    methods.grep(pattern).sort
  end
end # }}}

# Print an object's name and awesome-print its value. {{{
def pap(object_name, object)
  print "#{object_name} = "
  ap object
end # }}}

if defined? Rails
  # Customize the IRB prompt. {{{

  short_env = case Rails.env
    when 'development'
      'dev'
    when 'production'
      'prod'
    else
      Rails.env
    end

  # :PROMPT_I  Normal prompt
  # :PROMPT_S  Prompt when continuing a string
  # :PROMPT_C  Prompt when continuing a statement
  # :PROMPT_N  Prompt when indenting code
  # :RETURN    String that prefixes output of a statement. This is passed to Kernel#printf .
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I  => "#{Rails.application.class.parent_name} #{short_env} > ",
    :PROMPT_S  => "#{Rails.application.class.parent_name} #{short_env} %l> ",
    :PROMPT_C  => "#{Rails.application.class.parent_name} #{short_env} > ",
    :PROMPT_N  => "#{Rails.application.class.parent_name} #{short_env} ..  ",
    :RETURN    => "=> %s\n",
  }

  IRB.conf[:PROMPT_MODE] = :RAILS

  # End customizing the IRB prompt. }}}

  def reconnect_activerecord
    ActiveRecord::Base.verify_active_connections!
  end

  def ar_logger
    ActiveRecord::Base.logger = Logger.new STDOUT
    ActiveRecord::Base.clear_reloadable_connections!
  end

  # Use named routes more easily.
  include Rails.application.routes.url_helpers

#  # Use ActionView helpers more easily. {{{
#  include ActionView::Helpers::DebugHelper
#  include ActionView::Helpers::NumberHelper
#  include ActionView::Helpers::RawOutputHelper
#  include ActionView::Helpers::SanitizeHelper
#  include ActionView::Helpers::TagHelper
#  include ActionView::Helpers::TextHelper
#  include ActionView::Helpers::TranslationHelper
#  # }}}
end

if defined? AwesomePrint
  AwesomePrint.defaults = {
    :indent => -2,
  }
end

def reload_tux!
  exec $0, *ARGV
end

puts  # Put a blank line between the startup messages and the IRB prompt.
