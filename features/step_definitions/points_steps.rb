Then(/^I should have (\d+) points$/) do |points|
  # since same test was used for creating a question and creating new user
  # flat number requirement wouldn't work
  # was flat 100, changed it to points.to_i
  expect(@user.reload.points).to be(points.to_i)
end

Given(/^I have (\d+) points$/) do |points|
  @user.points = points
  @user.save!
end

