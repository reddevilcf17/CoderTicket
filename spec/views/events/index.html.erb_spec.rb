require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  it "renders _card partial for each event" do
    event1 = Event.new
    event1.hero_image_url = 'abc'
    event1.name = 'abc'
    event1.id = 1
    event2 = Event.new
    event2.hero_image_url = 'abc'
    event2.name = 'abc'
    event2.id = 2

    assign(:events, [event1, event2])
    render
    expect(view).to render_template(:partial => "_card", :count => 2)
  end

  it "show the home page" do
    @events = Event.all
    render

    expect(rendered).to include('Discover upcoming events')
  end
end
