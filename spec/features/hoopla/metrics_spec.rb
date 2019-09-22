require 'rails_helper'

RSpec.feature 'Metrics', type: :feature do
  before(:each) do
    create(:metric, name: 'Pipeline')
    visit '/'
  end

  it 'lands on the metrics index' do
    expect(page).to have_content('List of Metrics')
  end

  it 'shows a list of metrics' do
    expect(page).to have_content('Pipeline')
  end

  it 'goes to list of values on clicking a metric' do
    click_on 'Pipeline'
    expect(page).to have_content('List of Values for Pipeline')
  end
end
