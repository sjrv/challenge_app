And(/^I like that answer$/) do
  visit question_path(@answer.question)
  # scope was not precise enough
  within(:css, "#answer-#{@answer.id}") do
    click_on "Like"
  end
end

Then(/^That answer should have (\d+) like(s?)$/) do |count, suffix|
  # decided it was enough if such phrase was in page's content, not necessarily 
  # in answer element
  #within(:css, "#answer-#{@answer.id}") do
    expect(page).to have_content("#{count} like#{suffix}")
  #end
end

When(/^This answer is liked$/) do
  # new sign_in seems to be unnecessary
  # sign_in_as(@answer.question.user)
  visit question_path(@answer.question)
  within(:css, "#answer-#{@answer.id}") do
    click_on "Like"
  end

  expect(@user.points).to be(105)
end

When(/^This answer is accepted$/) do
  # new sign_in seems to be unnecessary
  sign_in_as(@answer.question.user)
  visit question_path(@answer.question)
  within(:css, "#answer-#{@answer.id}") do
    click_on "Accept"
  end

  expect(@user.points).to be(125)
end
