# Include markaby support
require File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'sinatra-markaby', 'lib', 'sinatra', 'markaby')
Middleman.helpers Sinatra::Markaby
Middleman.supported_formats << "mab"