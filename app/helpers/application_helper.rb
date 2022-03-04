module ApplicationHelper

  def seeds_message(message, &block)
    puts message
    yield
    puts "...Done!"
  end

end
