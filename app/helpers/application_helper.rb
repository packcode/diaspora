module ApplicationHelper
  require 'lib/common'
  include Diaspora::XMLParser
  def object_path(object)
    eval("#{object.class.to_s.underscore}_path(object)")
  end

  def object_fields(object)
    object.attributes.keys 
  end

  def mine?(post)
    post.person == User.owner
  end
  
  def type_partial(post)
    class_name = post.class.name.to_s.underscore
    "#{class_name.pluralize}/#{class_name}"
  end
  
  def how_long_ago(obj)
    time_ago_in_words(obj.created_at) + " ago."
  end

  def person_url(person)
    case person.class.to_s
    when "User"
      user_path(person)
    when "Person"
      person_path(person)
    else
      "unknown person"
    end
  end

  def link_to_person(person)
    link_to person.real_name, person_url(person)
  end

  def owner_picture
    default = "/images/user/default.jpg"
    image = "/images/user/#{User.owner.profile.last_name.gsub(/ /,'').downcase}.jpg"

    if File.exist?("public/images/user/#{User.owner.profile.last_name.gsub(/ /,'').downcase}.jpg")
      image_tag image, :id => "user_picture"
    else
      image_tag default, :id => "user_picture"
    end
  end

  def new_request(request_count)
    "new_requests" if request_count > 0
  end

end
