require 'fileutils'

describe "Builder" do
  def project_file(*parts)
    File.expand_path(File.join(File.dirname(__FILE__), "..", *parts))
  end

  before :all do
    @root_dir = project_file("spec", "fixtures", "sample")
  end

  before :each do    
    build_cmd = project_file("bin", "mm-build")
    `cd #{@root_dir} && #{build_cmd}`
  end
  
  after :each do
    FileUtils.rm_rf(File.join(@root_dir, "build"))
  end
  
  it "should build markaby files" do
    File.exists?("#{@root_dir}/build/markaby.html").should be_true
    File.read("#{@root_dir}/build/markaby.html").should include("<title>Hi Markaby</title>")
  end
  
  it "should build haml files" do
    File.exists?("#{@root_dir}/build/index.html").should be_true
    File.read("#{@root_dir}/build/index.html").should include("<h1>Welcome</h1>")
  end
  
  it "should build maruku files" do
    File.exists?("#{@root_dir}/build/maruku.html").should be_true
    File.read("#{@root_dir}/build/maruku.html").should include("<h1 class='header' id='hello_maruku'>Hello Maruku</h1>")
  end
  
  it "should build static files" do
    File.exists?("#{@root_dir}/build/static.html").should be_true
    File.read("#{@root_dir}/build/static.html").should include("Static, no code!")
  end

  it "should build subdirectory files" do
    File.exists?("#{@root_dir}/build/services/index.html").should be_true
  end

  it "should build sass files" do
    File.exists?("#{@root_dir}/build/stylesheets/site.css").should be_true
    File.read("#{@root_dir}/build/stylesheets/site.css").should include("html, body, div, span, applet, object, iframe")
  end

  it "should build static css files" do
    File.exists?("#{@root_dir}/build/stylesheets/static.css").should be_true
  end
  
  it "should not build partial files" do
    File.exists?("#{@root_dir}/build/_partial.html").should be_false
  end
end