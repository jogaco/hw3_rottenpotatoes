# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

Then /I should (not )?see the following movies/ do |notsee, movies_list|
  movies_list.hashes.each do |movie|
    if notsee
      assert !page.body.include?(movie[:title])
    else
      assert page.body.include?(movie[:title])
    end
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,\s*/).each do |rating|
    checkbox_id = "ratings_" + rating
    if uncheck == "un"
      uncheck(checkbox_id)
    elsif
      check(checkbox_id)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see all the movies/ do
  assert Movie.count == page.all("table#movies tbody tr").count
end
