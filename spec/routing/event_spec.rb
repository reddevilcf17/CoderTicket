require 'rails_helper'

RSpec.describe "Event", :type => :routing do
  it "routes / to events#new" do
    expect(:get => "/").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "routes /events/:id to events#show" do
  	expect(:get => "/events/1").to route_to(
  			:controller => "events",
  			:action => "show",
  			:id => "1"
  		)
  end

  # it "does not show all users" do
  #   expect(:get => "/users").not_to be_routable
  # end
end