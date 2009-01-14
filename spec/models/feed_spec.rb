require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feed do

  before(:each) do
    @news_xml_resp = stub(Net::HTTPSuccess, :body => File.read(fixture_path + 'news.xml'), :kind_of? => true)
	@net_http = mock(Net::HTTP, :get => @news_xml_resp)
    Net::HTTP.stub!(:new).and_return(@net_http)	
  end
    
  it "should post the XML into the DB" do
	Feed.create_from_url("http://news.google.co.in/?output=rss")	
  end
  
  def get_feed_obj
	@feed = Feed.find(1)
  end
  
  it "should have more than 0 rows " do
  @feed = Feed.count(:all)
  @feed.should > 0 
  end
  
  it "should check the title" do
	get_feed_obj
	@feed.title.should == "LeT behind Mumbai carnage: Britain - Times of India"
  end
  
  it "should check the category" do
	get_feed_obj
	@feed.category.should == "Top Stories"
  end

  it "should check the description" do
	get_feed_obj
	@feed.description.should_not be_nil
  end

  it "should check the published date" do
	get_feed_obj
	@feed.pubDate.should == "Tue, 13 Jan 2009 12:47:28 GMT"
  end  
  
end
