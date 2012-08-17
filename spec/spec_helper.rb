lib_dir = File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.expand_path(lib_dir)

require 'rspec/autorun'
